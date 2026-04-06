const getTransactionWithSplits = async (conn, transactionId) => {
  const [[transaction]] = await conn.query(
    'SELECT Id, UserDate, Description FROM Transactions WHERE Id = ? AND Deleted = 0',
    [transactionId]
  );
  if (!transaction) return null;

  const [splits] = await conn.query(
    'SELECT Id, Tran_id, FundId, AccountId, Amount FROM Split WHERE Tran_id = ? ORDER BY Id',
    [transactionId]
  );
  return { transaction, splits };
};

const createTransaction = async (conn, { userDate, description, splits }) => {
  await conn.beginTransaction();
  try {
    const [result] = await conn.query(
      'INSERT INTO Transactions (UserDate, Description) VALUES (?, ?)',
      [userDate, description]
    );
    const tranId = result.insertId;

    for (const split of splits) {
      await conn.query(
        'INSERT INTO Split (Tran_id, FundId, AccountId, Amount) VALUES (?, ?, ?, ?)',
        [tranId, split.fundId, split.accountId, split.amount]
      );
    }

    await conn.commit();
    return tranId;
  } catch (err) {
    await conn.rollback();
    throw err;
  }
};

const updateTransaction = async (conn, transactionId, { userDate, description, splits }) => {
  await conn.beginTransaction();
  try {
    // Soft-delete the existing transaction (preserves audit trail).
    await conn.query(
      'UPDATE Transactions SET Deleted = 1, Deleted_at = CURRENT_TIMESTAMP WHERE Id = ?',
      [transactionId]
    );

    // Insert a new transaction row with the updated values.
    const [result] = await conn.query(
      'INSERT INTO Transactions (UserDate, Description) VALUES (?, ?)',
      [userDate, description]
    );
    const newTranId = result.insertId;

    // Insert splits against the new transaction id.
    for (const split of splits) {
      await conn.query(
        'INSERT INTO Split (Tran_id, FundId, AccountId, Amount) VALUES (?, ?, ?, ?)',
        [newTranId, split.fundId, split.accountId, split.amount]
      );
    }

    await conn.commit();
  } catch (err) {
    await conn.rollback();
    throw err;
  }
};

const deleteTransaction = async (conn, transactionId) => {
  await conn.beginTransaction();
  try {
    // Soft-delete: mark as deleted, leave Split rows intact.
    await conn.query(
      'UPDATE Transactions SET Deleted = 1, Deleted_at = CURRENT_TIMESTAMP WHERE Id = ?',
      [transactionId]
    );
    await conn.commit();
  } catch (err) {
    await conn.rollback();
    throw err;
  }
};

module.exports = {
  getTransactionWithSplits,
  createTransaction,
  updateTransaction,
  deleteTransaction,
};
