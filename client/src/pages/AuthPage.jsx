import { useState } from 'react';
import { connect } from '../services/authService.js';
import AlertDialog from '../components/AlertDialog.jsx';
import './AuthPage.css';

const AuthPage = ({ lastCredentials, onConnected }) => {
  const [user, setUser] = useState(lastCredentials?.user || '');
  const [password, setPassword] = useState('');
  const [database, setDatabase] = useState(lastCredentials?.database || '');
  const [port, setPort] = useState(lastCredentials?.port || '3306');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setLoading(true);
    try {
      const result = await connect({ user, password, database, port });
      // Ask the browser's password manager to offer to save the credentials.
      // Only username/password are stored here; non-secret fields persist via localStorage.
      if (window.PasswordCredential) {
        try {
          const cred = new window.PasswordCredential({ id: user, password });
          await navigator.credentials.store(cred);
        } catch {
          // Credential Management unavailable/declined — non-fatal
        }
      }
      onConnected({ user, database, port }, result.permissions);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="auth-page">
      <div className="auth-card">
        <h1 className="auth-title">Tallis Ledger</h1>
        <p className="auth-subtitle">Connect to Database</p>
        <form onSubmit={handleSubmit} className="auth-form">
          <div className="auth-field">
            <label htmlFor="user">User</label>
            <input
              id="user"
              name="username"
              type="text"
              value={user}
              onChange={(e) => setUser(e.target.value)}
              autoComplete="username"
              required
            />
          </div>
          <div className="auth-field">
            <label htmlFor="password">Password</label>
            <input
              id="password"
              name="password"
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              autoComplete="current-password"
            />
          </div>
          <div className="auth-field">
            <label htmlFor="database">Database</label>
            <input
              id="database"
              name="database"
              type="text"
              value={database}
              onChange={(e) => setDatabase(e.target.value)}
              autoComplete="on"
              required
            />
          </div>
          <div className="auth-field">
            <label htmlFor="port">Port</label>
            <input
              id="port"
              name="port"
              type="number"
              value={port}
              onChange={(e) => setPort(e.target.value)}
              autoComplete="on"
              required
              min="1"
              max="65535"
            />
          </div>
          <div className="auth-submit">
            <button type="submit" disabled={loading}>
              {loading ? 'Connecting…' : 'Submit'}
            </button>
          </div>
        </form>
      </div>
      <AlertDialog message={error} onClose={() => setError('')} />
    </div>
  );
};

export default AuthPage;
