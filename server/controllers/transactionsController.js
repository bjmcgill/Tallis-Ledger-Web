const { getConnection } = require('../db');
const {
  getTransactionWithSplits,
  createTransaction,
  updateTransaction,
  deleteTransaction,
} = require('../models/transactionModel');

const getTransaction = async (req, res, next) => {
  const { id } = req.params;
  let conn;
  try {
    conn = await getConnection(req.session.dbCredentials);
    const data = await getTransactionWithSplits(conn, id);
    if (!data) {
      return res.status(404).json({ message: 'Transaction not found.' });
    }
    res.json(data);
  } catch (err) {
    next(err);
  } finally {
    if (conn) await conn.end();
  }
};

const create = async (req, res, next) => {
  const { userDate, description, splits } = req.body;
  if (!userDate || !splits || splits.length < 2) {
    return res.status(400).json({ message: 'userDate and at least 2 splits are required.' });
  }
  let conn;
  try {
    conn = await getConnection(req.session.dbCredentials);
    const tranId = await createTransaction(conn, { userDate, description, splits });
    res.status(201).json({ id: tranId });
  } catch (err) {
    next(err);
  } finally {
    if (conn) await conn.end();
  }
};

const update = async (req, res, next) => {
  const { id } = req.params;
  const { userDate, description, splits } = req.body;
  if (!userDate || !splits || splits.length < 2) {
    return res.status(400).json({ message: 'userDate and at least 2 splits are required.' });
  }
  let conn;
  try {
    conn = await getConnection(req.session.dbCredentials);
    await updateTransaction(conn, id, { userDate, description, splits });
    res.json({ message: 'Transaction updated.' });
  } catch (err) {
    next(err);
  } finally {
    if (conn) await conn.end();
  }
};

const remove = async (req, res, next) => {
  const { id } = req.params;
  let conn;
  try {
    conn = await getConnection(req.session.dbCredentials);
    await deleteTransaction(conn, id);
    res.json({ message: 'Transaction deleted.' });
  } catch (err) {
    next(err);
  } finally {
    if (conn) await conn.end();
  }
};

module.exports = { getTransaction, create, update, remove };
