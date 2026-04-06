const mysql = require('mysql2/promise');

/**
 * Creates a short-lived MySQL connection from stored session credentials.
 * Caller is responsible for calling conn.end() when done.
 */
const getConnection = async (credentials) => {
  const conn = await mysql.createConnection({
    host: 'localhost',
    port: Number(credentials.port),
    user: credentials.user,
    password: credentials.password,
    database: credentials.database,
    dateStrings: true,
  });
  return conn;
};

/**
 * Checks whether the current MySQL user has a given privilege on a given table
 * by querying information_schema at global, schema and table levels.
 */
const checkTablePrivilege = async (conn, tableName, privilegeType) => {
  const granteeExpr = `CONCAT("'", SUBSTRING_INDEX(CURRENT_USER(), '@', 1), "'@'", SUBSTRING_INDEX(CURRENT_USER(), '@', -1), "'")`;
  const [rows] = await conn.query(
    `SELECT COUNT(*) AS cnt FROM (
       SELECT 1 FROM information_schema.USER_PRIVILEGES
       WHERE GRANTEE = ${granteeExpr}
         AND PRIVILEGE_TYPE IN (?, 'ALL PRIVILEGES')
       UNION ALL
       SELECT 1 FROM information_schema.SCHEMA_PRIVILEGES
       WHERE TABLE_SCHEMA = DATABASE()
         AND GRANTEE = ${granteeExpr}
         AND PRIVILEGE_TYPE IN (?, 'ALL PRIVILEGES')
       UNION ALL
       SELECT 1 FROM information_schema.TABLE_PRIVILEGES
       WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = ?
         AND GRANTEE = ${granteeExpr}
         AND PRIVILEGE_TYPE IN (?, 'ALL PRIVILEGES')
     ) p`,
    [privilegeType, privilegeType, tableName, privilegeType]
  );
  return rows[0].cnt > 0;
};

module.exports = { getConnection, checkTablePrivilege };
