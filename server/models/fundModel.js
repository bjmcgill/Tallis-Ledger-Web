const getAllFunds = async (conn) => {
  const [rows] = await conn.query('SELECT Id, Name, Type FROM Fund ORDER BY Id');
  return rows;
};

module.exports = { getAllFunds };
