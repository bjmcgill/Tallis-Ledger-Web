BEGIN;
-- Drop tables if they already exist
DROP TABLE IF EXISTS Split;
DROP TABLE IF EXISTS Transactions;
DROP TABLE IF EXISTS Fund;
DROP TABLE IF EXISTS Account;

-- Create Fund table
CREATE TABLE Fund (
    Id INT PRIMARY KEY,
    Name VARCHAR(50) CHECK(CHAR_LENGTH(Name) <= 50),
    Type VARCHAR(25) CHECK(CHAR_LENGTH(Type) <= 25)
) ENGINE=InnoDB;

-- Create Account table
CREATE TABLE Account (
    Id INT PRIMARY KEY,
    Name VARCHAR(50) CHECK(CHAR_LENGTH(Name) <= 50),
    Type VARCHAR(25) CHECK(CHAR_LENGTH(Type) <= 25)
) ENGINE=InnoDB;

-- Create Transaction table
CREATE TABLE Transactions (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    UserDate DATE,
    Description VARCHAR(100) CHECK(CHAR_LENGTH(Description) <= 100),
    Created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    Deleted TINYINT(1) DEFAULT 0,
    Deleted_at DATETIME
) ENGINE=InnoDB;

-- Create Split table
CREATE TABLE Split (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Tran_id INT,
    Amount DECIMAL(15,2),
    FundId INT,
    AccountId INT,
    FOREIGN KEY (Tran_id) REFERENCES Transactions(Id),
    FOREIGN KEY (FundId) REFERENCES Fund(Id),
    FOREIGN KEY (AccountId) REFERENCES Account(Id)
) ENGINE=InnoDB;

-- Create indexes for performance
-- Transactions table indexes (excluding primary key Id)
CREATE INDEX idx_transactions_userdate ON Transactions(UserDate);
CREATE INDEX idx_transactions_description ON Transactions(Description);
CREATE INDEX idx_transactions_created_at ON Transactions(Created_at);
CREATE INDEX idx_transactions_deleted ON Transactions(Deleted);
CREATE INDEX idx_transactions_deleted_at ON Transactions(Deleted_at);

-- Split table indexes (excluding primary key Id)
CREATE INDEX idx_split_tran_id ON Split(Tran_id);
CREATE INDEX idx_split_amount ON Split(Amount);
CREATE INDEX idx_split_fund_id ON Split(FundId);
CREATE INDEX idx_split_account_id ON Split(AccountId);

-- Insert default SPECIAL entries into Fund table
INSERT INTO Fund (Id, Name, Type) VALUES
(0, 'No Fund', 'SPECIAL'),
(1, 'Equity', 'SPECIAL'),
(2, 'Opening Balances', 'SPECIAL');

-- Insert default SPECIAL entries into Account table
INSERT INTO Account (Id, Name, Type) VALUES
(0, 'No Account', 'SPECIAL'),
(1, 'Fund Transfers', 'SPECIAL'),
(2, 'Opening Balances', 'SPECIAL'),
(200, 'Equity', 'EQUITY');

-- Suggested Account Schema
-- 000s - SPECIAL ACCOUNTS
-- 100s - ASSETS (BANK OR CASH)
-- 200s - EQUITY
-- 300s - EXPENSES RESTRICTED
-- 400s - EXPENSES UNRESTRICTED
-- 500s - INCOME RESTRICTED
-- 600s - INCOME UNRESTRICTED

-- Create comprehensive views for ledger data and summaries
-- Drop existing views if they exist
DROP VIEW IF EXISTS LedgerView;
DROP VIEW IF EXISTS LedgerViewWithFundBalance;
DROP VIEW IF EXISTS LedgerViewWithAccountBalance;
DROP VIEW IF EXISTS AccountSummaryView;
DROP VIEW IF EXISTS FundSummaryView;
DROP VIEW IF EXISTS AccountTypeSummaryView;

-- Create a comprehensive view for ledger data with formatted choice fields
CREATE VIEW LedgerView AS
SELECT
    Split.Id AS SplitId,
    Transactions.Id AS TransactionsId,
    Transactions.UserDate AS UserDate,
    Transactions.Description AS Description,
    Fund.Id AS FundId,
    Fund.Name AS FundName,
    Fund.Type AS FundType,
    Account.Id AS AccountId,
    Account.Name AS AccountName,
    Account.Type AS AccountType,
    Split.Amount AS Amount
FROM Split
JOIN Transactions ON Split.Tran_id = Transactions.Id
LEFT JOIN Fund ON Split.FundId = Fund.Id
LEFT JOIN Account ON Split.AccountId = Account.Id
WHERE Transactions.Deleted = 0
ORDER BY Transactions.UserDate, Transactions.Id, Split.Id;

CREATE VIEW LedgerViewWithFundBalance AS
SELECT 
    *,
    SUM(Amount) OVER (
        PARTITION BY FundId 
        ORDER BY UserDate, TransactionsId, SplitId 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS Balance
FROM LedgerView 
ORDER BY FundId, UserDate, TransactionsId, SplitId;

CREATE VIEW LedgerViewWithAccountBalance AS
SELECT 
    *,
    SUM(Amount) OVER (
        PARTITION BY AccountId 
        ORDER BY UserDate, TransactionsId, SplitId 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS Balance
FROM LedgerView 
ORDER BY AccountId, UserDate, TransactionsId, SplitId;

CREATE VIEW AccountSummaryView AS
SELECT
    AccountId,
    AccountName,
    AccountType,
    FORMAT(SUM(Amount), 2) AS Balance
FROM LedgerView
GROUP BY AccountId;

CREATE VIEW FundSummaryView AS
SELECT
    FundId,
    FundName,
    FundType,
    FORMAT(SUM(Amount), 2) AS Balance
FROM LedgerView
GROUP BY FundId;

CREATE VIEW AccountTypeSummaryView AS
SELECT
    Account.Type AS AccountType,
    FORMAT(SUM(Split.Amount), 2) AS Balance
FROM Split
JOIN Transactions ON Split.Tran_id = Transactions.Id
LEFT JOIN Account ON Split.AccountId = Account.Id
WHERE Transactions.Deleted = 0
GROUP BY Account.Type;

-- Create stored procedure to return fund summary balance as at a given date
DROP PROCEDURE IF EXISTS FnFundSummaryView;

DELIMITER //
CREATE PROCEDURE FnFundSummaryView(IN p_date DATE)
BEGIN
    SELECT
        FundId,
        FundName,
        FundType,
        FORMAT(SUM(Amount), 2) AS Balance
    FROM LedgerView
    WHERE UserDate <= p_date
    GROUP BY FundId;
END //
DELIMITER ;

-- Create stored procedure to return account summary balance as at a given date
DROP PROCEDURE IF EXISTS FnAccountSummaryView;

DELIMITER //
CREATE PROCEDURE FnAccountSummaryView(IN p_date DATE)
BEGIN
    SELECT
        AccountId,
        AccountName,
        AccountType,
        FORMAT(SUM(Amount), 2) AS Balance
    FROM LedgerView
    WHERE UserDate <= p_date
    GROUP BY AccountId;
END //
DELIMITER ;

COMMIT;