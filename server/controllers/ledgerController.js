const { getConnection } = require('../db');
const { getLedgerByFund, getLedgerByAccount } = require('../models/ledgerModel');

const getLedger = async (req, res, next) => {
  const { type, id } = req.query;

  if (!type || id === undefined) {
    return res.status(400).json({ message: 'type and id query parameters are required.' });
  }

  let conn;
  try {
    conn = await getConnection(req.session.dbCredentials);
    let rows;
    if (type === 'fund') {
      rows = await getLedgerByFund(conn, id);
    } else if (type === 'account') {
      rows = await getLedgerByAccount(conn, id);
    } else {
      return res.status(400).json({ message: 'type must be "fund" or "account".' });
    }
    res.json(rows);
  } catch (err) {
    next(err);
  } finally {
    if (conn) await conn.end();
  }
};

module.exports = { getLedger };
