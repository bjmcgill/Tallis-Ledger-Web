const { getConnection } = require('../db');
const { getAllAccounts } = require('../models/accountModel');

const listAccounts = async (req, res, next) => {
  let conn;
  try {
    conn = await getConnection(req.session.dbCredentials);
    const accounts = await getAllAccounts(conn);
    res.json(accounts);
  } catch (err) {
    next(err);
  } finally {
    if (conn) await conn.end();
  }
};

module.exports = { listAccounts };
