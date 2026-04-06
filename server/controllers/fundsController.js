const { getConnection } = require('../db');
const { getAllFunds } = require('../models/fundModel');

const listFunds = async (req, res, next) => {
  let conn;
  try {
    conn = await getConnection(req.session.dbCredentials);
    const funds = await getAllFunds(conn);
    res.json(funds);
  } catch (err) {
    next(err);
  } finally {
    if (conn) await conn.end();
  }
};

module.exports = { listFunds };
