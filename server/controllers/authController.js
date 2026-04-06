const { getConnection, checkTablePrivilege } = require('../db');

const connect = async (req, res, next) => {
  const { user, password, database, port } = req.body;

  if (!user || !database || !port) {
    return res.status(400).json({ message: 'user, database, and port are required.' });
  }

  let conn;
  try {
    conn = await getConnection({ user, password, database, port });

    // Verify connection works with a simple query
    await conn.query('SELECT 1');

    // Check privileges on Transactions and Split tables
    const [
      canInsertTransactions,
      canInsertSplit,
      canUpdateTransactions,
      canDeleteTransactions,
      canDeleteSplit,
    ] = await Promise.all([
      checkTablePrivilege(conn, 'Transactions', 'INSERT'),
      checkTablePrivilege(conn, 'Split', 'INSERT'),
      checkTablePrivilege(conn, 'Transactions', 'UPDATE'),
      checkTablePrivilege(conn, 'Transactions', 'DELETE'),
      checkTablePrivilege(conn, 'Split', 'DELETE'),
    ]);

    // Store credentials in session
    req.session.dbCredentials = { user, password, database, port };
    req.session.permissions = {
      canInsertTransactions,
      canInsertSplit,
      canUpdateTransactions,
      canDeleteTransactions,
      canDeleteSplit,
    };

    res.json({
      message: 'Connected successfully.',
      permissions: req.session.permissions,
    });
  } catch (err) {
    const error = new Error(`Database connection failed: ${err.message}`);
    error.status = 401;
    next(error);
  } finally {
    if (conn) await conn.end();
  }
};

const logout = (req, res, next) => {
  req.session.destroy((err) => {
    if (err) return next(err);
    res.json({ message: 'Logged out.' });
  });
};

module.exports = { connect, logout };
