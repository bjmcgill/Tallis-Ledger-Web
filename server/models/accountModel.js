const getAllAccounts = async (conn) => {
  const [rows] = await conn.query('SELECT Id, Name, Type FROM Account ORDER BY Id');
  return rows;
};

module.exports = { getAllAccounts };
