const getLedgerByFund = async (conn, fundId) => {
  const [rows] = await conn.query(
    'SELECT * FROM LedgerViewWithFundBalance WHERE FundId = ? ORDER BY UserDate, TransactionsId, SplitId',
    [fundId]
  );
  return rows;
};

const getLedgerByAccount = async (conn, accountId) => {
  const [rows] = await conn.query(
    'SELECT * FROM LedgerViewWithAccountBalance WHERE AccountId = ? ORDER BY UserDate, TransactionsId, SplitId',
    [accountId]
  );
  return rows;
};

module.exports = { getLedgerByFund, getLedgerByAccount };
