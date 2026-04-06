import { useState, useEffect, useRef, useCallback } from 'react';
import { AgGridReact } from 'ag-grid-react';
import 'ag-grid-community/styles/ag-grid.css';
import 'ag-grid-community/styles/ag-theme-quartz.css';
import { fetchFunds } from '../services/fundService.js';
import { fetchAccounts } from '../services/accountService.js';
import { fetchLedger } from '../services/ledgerService.js';
import { logout } from '../services/authService.js';
import { ymdToDmy } from '../utils/formatDate.js';
import { formatCurrency } from '../utils/formatCurrency.js';
import AlertDialog from '../components/AlertDialog.jsx';
import './LedgerPage.css';

const LedgerPage = ({ permissions, ledgerFilter, onFilterChange, onOpenAddEdit, onLogout }) => {
  const [funds, setFunds] = useState([]);
  const [accounts, setAccounts] = useState([]);
  const [rows, setRows] = useState([]);
  const [activeDropdown, setActiveDropdown] = useState(ledgerFilter.type);
  const [selectedFundId, setSelectedFundId] = useState(
    ledgerFilter.type === 'fund' ? ledgerFilter.id : 0
  );
  const [selectedAccountId, setSelectedAccountId] = useState(
    ledgerFilter.type === 'account' ? ledgerFilter.id : 0
  );
  const [error, setError] = useState('');
  const gridRef = useRef();

  const canAddTransaction =
    permissions.canInsertTransactions && permissions.canInsertSplit;

  const loadData = useCallback(async (type, id) => {
    try {
      const data = await fetchLedger(type, id);
      setRows(data);
    } catch (err) {
      setError(err.message);
    }
  }, []);

  // Load funds and accounts on mount
  useEffect(() => {
    const init = async () => {
      try {
        const [fundsData, accountsData] = await Promise.all([fetchFunds(), fetchAccounts()]);
        setFunds(fundsData);
        setAccounts(accountsData);
      } catch (err) {
        setError(err.message);
      }
    };
    init();
  }, []);

  // Load ledger data whenever active filter changes
  useEffect(() => {
    const id = activeDropdown === 'fund' ? selectedFundId : selectedAccountId;
    loadData(activeDropdown, id);
  }, [activeDropdown, selectedFundId, selectedAccountId, loadData]);

  const handleFundChange = (e) => {
    const id = Number(e.target.value);
    setSelectedFundId(id);
    setActiveDropdown('fund');
    onFilterChange({ type: 'fund', id });
  };

  const handleAccountChange = (e) => {
    const id = Number(e.target.value);
    setSelectedAccountId(id);
    setActiveDropdown('account');
    onFilterChange({ type: 'account', id });
  };

  const handleFundFocus = () => {
    setActiveDropdown('fund');
    onFilterChange({ type: 'fund', id: selectedFundId });
    loadData('fund', selectedFundId);
  };

  const handleAccountFocus = () => {
    setActiveDropdown('account');
    onFilterChange({ type: 'account', id: selectedAccountId });
    loadData('account', selectedAccountId);
  };

  const handleAddTransaction = () => {
    const currentFilter = { type: activeDropdown, id: activeDropdown === 'fund' ? selectedFundId : selectedAccountId };
    onOpenAddEdit('add', null, currentFilter);
  };

  const handleLogout = async () => {
    try {
      await logout();
    } catch (_) {
      // Ignore logout errors — always navigate away
    }
    onLogout();
  };

  const handleRowClick = (event) => {
    const transactionId = event.data?.TransactionsId;
    if (!transactionId) return;
    const currentFilter = { type: activeDropdown, id: activeDropdown === 'fund' ? selectedFundId : selectedAccountId };
    onOpenAddEdit('edit', transactionId, currentFilter);
  };

  const columnDefs = [
    { field: 'SplitId', headerName: 'Split ID', width: 90 },
    { field: 'TransactionsId', headerName: 'Tran ID', width: 90 },
    {
      field: 'UserDate',
      headerName: 'Date',
      width: 110,
      valueFormatter: (p) => ymdToDmy(p.value),
    },
    { field: 'Description', headerName: 'Description', flex: 1, minWidth: 160 },
    {
      headerName: 'Fund',
      valueGetter: (p) => `${p.data.FundId}: ${p.data.FundName}: ${p.data.FundType}`,
      width: 200,
    },
    {
      headerName: 'Account',
      valueGetter: (p) => `${p.data.AccountId}: ${p.data.AccountName}: ${p.data.AccountType}`,
      width: 220,
    },
    {
      field: 'Amount',
      headerName: 'Amount',
      width: 110,
      type: 'rightAligned',
      valueFormatter: (p) => formatCurrency(p.value),
    },
    {
      field: 'Balance',
      headerName: 'Balance',
      width: 120,
      type: 'rightAligned',
      valueFormatter: (p) => formatCurrency(p.value),
    },
  ];

  const defaultColDef = {
    resizable: true,
    sortable: false,
  };

  return (
    <div className="page ledger-page">
      <div className="toolbar">
        <label className={`dropdown-label ${activeDropdown === 'fund' ? 'active' : ''}`}>
          Fund:&nbsp;
          <select
            value={selectedFundId}
            onChange={handleFundChange}
            onFocus={handleFundFocus}
          >
            {funds.map((f) => (
              <option key={f.Id} value={f.Id}>
                {f.Id}: {f.Name}: {f.Type}
              </option>
            ))}
          </select>
        </label>
        <label className={`dropdown-label ${activeDropdown === 'account' ? 'active' : ''}`}>
          Account:&nbsp;
          <select
            value={selectedAccountId}
            onChange={handleAccountChange}
            onFocus={handleAccountFocus}
          >
            {accounts.map((a) => (
              <option key={a.Id} value={a.Id}>
                {a.Id}: {a.Name}: {a.Type}
              </option>
            ))}
          </select>
        </label>
      </div>
      <div className="toolbar">
        <button onClick={handleAddTransaction} disabled={!canAddTransaction}>
          Add Transaction
        </button>
        <button onClick={handleLogout}>Logout</button>
      </div>
      <div className="grid-container">
        <div className="ag-theme-quartz" style={{ height: '100%', width: '100%' }}>
          <AgGridReact
            ref={gridRef}
            rowData={rows}
            columnDefs={columnDefs}
            defaultColDef={defaultColDef}
            onRowClicked={handleRowClick}
            rowSelection="single"
            suppressCellFocus
          />
        </div>
      </div>
      <AlertDialog message={error} onClose={() => setError('')} />
    </div>
  );
};

export default LedgerPage;
