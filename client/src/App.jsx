import { useState } from 'react';
import AuthPage from './pages/AuthPage.jsx';
import LedgerPage from './pages/LedgerPage.jsx';
import AddEditPage from './pages/AddEditPage.jsx';

const App = () => {
  const [currentPage, setCurrentPage] = useState('auth');
  const [lastCredentials, setLastCredentials] = useState({
    user: '',
    database: '',
    port: '',
  });
  const [permissions, setPermissions] = useState({});
  // ledgerFilter: which dropdown is active and its selected id
  const [ledgerFilter, setLedgerFilter] = useState({ type: 'account', id: 0 });
  // addEdit context
  const [addEditMode, setAddEditMode] = useState('add');
  const [editTransactionId, setEditTransactionId] = useState(null);

  const handleConnected = (creds, perms) => {
    setLastCredentials({ user: creds.user, database: creds.database, port: creds.port });
    setPermissions(perms);
    setCurrentPage('ledger');
  };

  const handleLogout = () => {
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
