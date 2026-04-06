import { useState, useEffect, useRef, useMemo } from 'react';
import { AgGridReact } from 'ag-grid-react';
import 'ag-grid-community/styles/ag-grid.css';
import 'ag-grid-community/styles/ag-theme-quartz.css';
import { fetchFunds } from '../services/fundService.js';
import { fetchAccounts } from '../services/accountService.js';
import { fetchTransaction, createTransaction, updateTransaction, deleteTransaction } from '../services/transactionService.js';
import { todayDmy, dmyToYmd, ymdToDmy } from '../utils/formatDate.js';
import { formatCurrency } from '../utils/formatCurrency.js';
import SelectCellEditor from '../components/SelectCellEditor.jsx';
import AlertDialog from '../components/AlertDialog.jsx';
import './AddEditPage.css';

// Each row needs a stable unique id so AG Grid can target it in applyTransaction.
let _rowIdSeq = 0;
const nextRowId = () => String(++_rowIdSeq);

const buildNewRow = (date, description, fundId, accountId, amount = 0) => ({
  _rowId: nextRowId(),
  UserDate: date,
  Description: description,
  FundId: fundId,
  AccountId: accountId,
  Amount: amount,
});

const AddEditPage = ({ mode, transactionId, ledgerFilter, permissions, onDone }) => {
  // initialRows is set exactly once per mount; after that AG Grid owns the data.
  const [initialRows, setInitialRows] = useState(null);
  const [alert, setAlert] = useState({ message: '', onClose: null });

  // Grid API ref — populated in onGridReady.
  const apiRef = useRef(null);

  // Refs for funds/accounts data so columnDefs (created once) can always read the
  // latest values without needing to be recreated when data loads.
  const fundsRef = useRef([]);
  const fundOptsRef = useRef([]);
  const accountsRef = useRef([]);
  const accountOptsRef = useRef([]);

  const defaultFundId = ledgerFilter?.type === 'fund' ? ledgerFilter.id : 0;
  const defaultAccountId = ledgerFilter?.type === 'account' ? ledgerFilter.id : 0;

  // Derived permissions
  const canSaveEdit =
    permissions.canUpdateTransactions &&
    permissions.canInsertTransactions &&
    permissions.canInsertSplit;
  const canEditSplits = mode === 'edit' ? canSaveEdit : true;
  const canDelete = permissions.canUpdateTransactions;

  // ── Reference data ──────────────────────────────────────────────────────────
  useEffect(() => {
    const init = async () => {
      try {
        const [fundsData, accountsData] = await Promise.all([fetchFunds(), fetchAccounts()]);
        fundsRef.current = fundsData;
        fundOptsRef.current = fundsData.map((f) => ({
          id: f.Id,
          label: `${f.Id}: ${f.Name}: ${f.Type}`,
        }));
        accountsRef.current = accountsData;
        accountOptsRef.current = accountsData.map((a) => ({
          id: a.Id,
          label: `${a.Id}: ${a.Name}: ${a.Type}`,
        }));
        // Refresh all cells so valueFormatters pick up the loaded labels.
        apiRef.current?.refreshCells({ force: true });
      } catch (err) {
        setAlert({ message: err.message, onClose: () => onDone(ledgerFilter) });
      }
    };
    init();
  }, []); // eslint-disable-line react-hooks/exhaustive-deps

  // ── Initial grid rows ───────────────────────────────────────────────────────
  useEffect(() => {
    if (mode === 'add') {
      const today = todayDmy();
      setInitialRows([
        buildNewRow(today, '', defaultFundId, defaultAccountId),
        buildNewRow(today, '', defaultFundId, defaultAccountId),
      ]);
      return;
    }
    const load = async () => {
      try {
        const { transaction, splits } = await fetchTransaction(transactionId);
        setInitialRows(
          splits.map((s) =>
            buildNewRow(
              ymdToDmy(transaction.UserDate),
              transaction.Description,
              s.FundId,
              s.AccountId,
              Number(s.Amount)
            )
          )
        );
      } catch (err) {
        setAlert({ message: err.message, onClose: () => onDone(ledgerFilter) });
      }
    };
    load();
  }, [mode, transactionId]); // eslint-disable-line react-hooks/exhaustive-deps

  // ── Helpers ─────────────────────────────────────────────────────────────────
  const getGridRows = () => {
    if (!apiRef.current) return [];
    const rows = [];
    apiRef.current.forEachNode((node) => rows.push(node.data));
    return rows;
  };

  const getSelectedNode = () => {
    const nodes = apiRef.current?.getSelectedNodes();
    return nodes?.length ? nodes[0] : null;
  };

  // ── Cell value changed — cascade UserDate / Description to all rows ─────────
  const handleCellValueChanged = (params) => {
    const field = params.colDef.field;
    if (field !== 'UserDate' && field !== 'Description') return;
    const updates = [];
    apiRef.current.forEachNode((node) => {
      if (node.data._rowId !== params.node.data._rowId) {
        updates.push({ ...node.data, [field]: params.newValue });
      }
    });
    if (updates.length) apiRef.current.applyTransaction({ update: updates });
  };

  // ── Button handlers ─────────────────────────────────────────────────────────
  const handleAddSplit = () => {
    const selectedNode = getSelectedNode();
    const refData = selectedNode?.data ?? getGridRows().slice(-1)[0] ?? {};
    const newRow = buildNewRow(
      refData.UserDate || todayDmy(),
      refData.Description || '',
      defaultFundId,
      defaultAccountId
    );
    const addIndex = selectedNode ? selectedNode.rowIndex + 1 : undefined;
    apiRef.current.applyTransaction({ add: [newRow], addIndex });
  };

  const handleDeleteSplit = () => {
    const rows = getGridRows();
    if (rows.length <= 2) return;
    const selectedNode = getSelectedNode();
    if (!selectedNode) return;
    apiRef.current.applyTransaction({ remove: [selectedNode.data] });
  };

  const handleBalanceSplit = () => {
    const selectedNode = getSelectedNode();
    if (!selectedNode) return;
    const rows = getGridRows();
    const otherSum = rows.reduce(
      (sum, r) =>
        r._rowId !== selectedNode.data._rowId ? sum + Number(r.Amount || 0) : sum,
      0
    );
    apiRef.current.applyTransaction({
      update: [{ ...selectedNode.data, Amount: -otherSum }],
    });
  };

  const handleSave = async () => {
    const rows = getGridRows();
    const sum = rows.reduce((s, r) => s + Number(r.Amount || 0), 0);

    if (Math.abs(sum) > 0.001) {
      setAlert({
        message:
          'The sum of values in the amount column does not come to zero, and therefore the transaction does not balance.',
        onClose: () => setAlert({ message: '', onClose: null }),
      });
      return;
    }

    const userDate = dmyToYmd(rows[0]?.UserDate || todayDmy());
    const description = rows[0]?.Description || '';
    const splits = rows.map((r) => ({
      fundId: r.FundId,
      accountId: r.AccountId,
      amount: Number(r.Amount),
    }));

    try {
      if (mode === 'add') {
        await createTransaction({ userDate, description, splits });
      } else {
        await updateTransaction(transactionId, { userDate, description, splits });
      }
      onDone(ledgerFilter);
    } catch (err) {
      setAlert({ message: err.message, onClose: () => onDone(ledgerFilter) });
    }
  };

  const handleDeleteTransaction = async () => {
    try {
      await deleteTransaction(transactionId);
      onDone(ledgerFilter);
    } catch (err) {
      setAlert({ message: err.message, onClose: () => onDone(ledgerFilter) });
    }
  };

  const handleCancel = () => onDone(ledgerFilter);

  // ── Column definitions — created once; refs provide live data access ────────
  const columnDefs = useMemo(
    () => [
      { field: 'UserDate', headerName: 'Date', editable: true, width: 130 },
      {
        field: 'Description',
        headerName: 'Description',
        editable: true,
        flex: 1,
        minWidth: 160,
      },
      {
        field: 'FundId',
        headerName: 'Fund',
        editable: true,
        width: 220,
        cellEditor: SelectCellEditor,
        // Function form reads the ref at the moment the editor opens.
        cellEditorParams: () => ({ options: fundOptsRef.current }),
        valueFormatter: (p) => {
          const f = fundsRef.current.find((x) => x.Id === p.value);
          return f ? `${f.Id}: ${f.Name}: ${f.Type}` : String(p.value ?? '');
        },
      },
      {
        field: 'AccountId',
        headerName: 'Account',
        editable: true,
        width: 220,
        cellEditor: SelectCellEditor,
        cellEditorParams: () => ({ options: accountOptsRef.current }),
        valueFormatter: (p) => {
          const a = accountsRef.current.find((x) => x.Id === p.value);
          return a ? `${a.Id}: ${a.Name}: ${a.Type}` : String(p.value ?? '');
        },
      },
      {
        field: 'Amount',
        headerName: 'Amount',
        editable: true,
        width: 120,
        type: 'rightAligned',
        valueFormatter: (p) => formatCurrency(p.value),
        valueParser: (p) => Number(p.newValue),
      },
    ],
    [] // No deps — refs give fresh data without recreating columns.
  );

  const defaultColDef = useMemo(() => ({ resizable: true, sortable: false }), []);

  return (
    <div className="page addedit-page">
      <div className="toolbar">
        <button onClick={handleCancel}>Cancel</button>
        <button onClick={handleSave} disabled={mode === 'edit' && !canSaveEdit}>
          Save Transaction
        </button>
        <button onClick={handleAddSplit} disabled={!canEditSplits}>
          Add Split
        </button>
        <button onClick={handleDeleteSplit} disabled={!canEditSplits}>
          Delete Split
        </button>
        <button onClick={handleBalanceSplit}>Balance Split</button>
        {mode === 'edit' && (
          <button onClick={handleDeleteTransaction} disabled={!canDelete} className="btn-danger">
            Delete Transaction
          </button>
        )}
      </div>
      <div className="grid-container">
        <div className="ag-theme-quartz" style={{ height: '100%', width: '100%' }}>
          <AgGridReact
            rowData={initialRows}
            columnDefs={columnDefs}
            defaultColDef={defaultColDef}
            getRowId={(params) => params.data._rowId}
            onGridReady={(params) => { apiRef.current = params.api; }}
            onCellValueChanged={handleCellValueChanged}
            rowSelection="single"
            singleClickEdit
            stopEditingWhenCellsLoseFocus
          />
        </div>
      </div>
      <AlertDialog message={alert.message} onClose={alert.onClose} />
    </div>
  );
};

export default AddEditPage;
