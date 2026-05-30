import { useState } from 'react';
import AuthPage from './pages/AuthPage.jsx';
import LedgerPage from './pages/LedgerPage.jsx';
import AddEditPage from './pages/AddEditPage.jsx';

const STORAGE_KEY = 'tallis.lastCredentials';

const loadLastCredentials = () => {
  try {
    const saved = JSON.parse(localStorage.getItem(STORAGE_KEY) || '{}');
    return {
      user: saved.user || '',
      database: saved.database || '',
      port: saved.port || '3306',
    };
  } catch {
    return { user: '', database: '', port: '3306' };
  }
};

const App = () => {
  const [currentPage, setCurrentPage] = useState('auth');
  const [lastCredentials, setLastCredentials] = useState(loadLastCredentials);
  const [permissions, setPermissions] = useState({});
  // ledgerFilter: which dropdown is active and its selected id
  const [ledgerFilter, setLedgerFilter] = useState({ type: 'account', id: 0 });
  // addEdit context
  const [addEditMode, setAddEditMode] = useState('add');
  const [editTransactionId, setEditTransactionId] = useState(null);

  const handleConnected = (creds, perms) => {
    const nextCreds = { user: creds.user, database: creds.database, port: creds.port };
    setLastCredentials(nextCreds);
    try {
      localStorage.setItem(STORAGE_KEY, JSON.stringify(nextCreds));
    } catch {
      // localStorage unavailable (private mode / disabled) — non-fatal
    }
    setPermissions(perms);
    setCurrentPage('ledger');
  };

  const handleLogout = () => {
    try {
      localStorage.removeItem(STORAGE_KEY);
    } catch {
      // localStorage unavailable — non-fatal
    }
    setLastCredentials({ user: '', database: '', port: '3306' });
    setCurrentPage('auth');
  };

  const handleOpenAddEdit = (mode, transactionId = null, filter) => {
    setAddEditMode(mode);
    setEditTransactionId(transactionId);
    if (filter) setLedgerFilter(filter);
    setCurrentPage('addEdit');
  };

  const handleAddEditDone = (filter) => {
    if (filter) setLedgerFilter(filter);
    setCurrentPage('ledger');
  };

  return (
    <>
      {currentPage === 'auth' && (
        <AuthPage
          lastCredentials={lastCredentials}
          onConnected={handleConnected}
        />
      )}
      {currentPage === 'ledger' && (
        <LedgerPage
          permissions={permissions}
          ledgerFilter={ledgerFilter}
          onFilterChange={setLedgerFilter}
          onOpenAddEdit={handleOpenAddEdit}
          onLogout={handleLogout}
        />
      )}
      {currentPage === 'addEdit' && (
        <AddEditPage
          mode={addEditMode}
          transactionId={editTransactionId}
          ledgerFilter={ledgerFilter}
          permissions={permissions}
          onDone={handleAddEditDone}
        />
      )}
    </>
  );
};

export default App;
