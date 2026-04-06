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
              type="text"
              value={database}
              onChange={(e) => setDatabase(e.target.value)}
              required
            />
          </div>
          <div className="auth-field">
            <label htmlFor="port">Port</label>
            <input
              id="port"
              type="number"
              value={port}
              onChange={(e) => setPort(e.target.value)}
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
