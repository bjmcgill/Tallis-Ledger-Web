-- Sample Data for Tallis Ledger
-- This file contains example data for testing and demonstration purposes

-- Insert additional Funds (IDs 3-20)
BEGIN;

INSERT INTO Fund (Id, Name, Type) VALUES
(3, 'General Fund', 'OPERATING'),
(4, 'Building Fund', 'CAPITAL'),
(5, 'Mission Fund', 'RESTRICTED'),
(6, 'Youth Ministry', 'PROGRAM'),
(7, 'Music Ministry', 'PROGRAM'),
(8, 'Outreach Fund', 'RESTRICTED'),
(9, 'Emergency Relief', 'RESTRICTED'),
(10, 'Education Fund', 'PROGRAM'),
(11, 'Maintenance Fund', 'OPERATING'),
(12, 'Technology Fund', 'CAPITAL'),
(13, 'Scholarship Fund', 'RESTRICTED'),
(14, 'Community Events', 'PROGRAM'),
(15, 'Benevolence Fund', 'RESTRICTED'),
(16, 'Worship Fund', 'PROGRAM'),
(17, 'Admin Fund', 'OPERATING'),
(18, 'Parking Lot Fund', 'CAPITAL'),
(19, 'Holiday Programs', 'PROGRAM'),
(20, 'Memorial Fund', 'RESTRICTED');

-- Insert additional Accounts (IDs 201-250)
INSERT INTO Account (Id, Name, Type) VALUES
(201, 'Checking Account - Main', 'ASSET'),
(202, 'Savings Account - Reserve', 'ASSET'),
(203, 'Petty Cash', 'ASSET'),
(204, 'Accounts Receivable', 'ASSET'),
(205, 'Prepaid Expenses', 'ASSET'),
(210, 'Accounts Payable', 'LIABILITY'),
(211, 'Accrued Expenses', 'LIABILITY'),
(212, 'Deferred Revenue', 'LIABILITY'),
(213, 'Loans Payable', 'LIABILITY'),
(220, 'Donations - General', 'INCOME'),
(221, 'Donations - Designated', 'INCOME'),
(222, 'Grants Received', 'INCOME'),
(223, 'Fundraising Income', 'INCOME'),
(224, 'Event Registration', 'INCOME'),
(225, 'Investment Income', 'INCOME'),
(226, 'Rental Income', 'INCOME'),
(227, 'Miscellaneous Income', 'INCOME'),
(230, 'Salaries & Wages', 'EXPENSE'),
(231, 'Payroll Taxes', 'EXPENSE'),
(232, 'Benefits', 'EXPENSE'),
(233, 'Professional Services', 'EXPENSE'),
(234, 'Utilities', 'EXPENSE'),
(235, 'Insurance', 'EXPENSE'),
(236, 'Building Maintenance', 'EXPENSE'),
(237, 'Office Supplies', 'EXPENSE'),
(238, 'Program Supplies', 'EXPENSE'),
(239, 'Technology Expenses', 'EXPENSE'),
(240, 'Marketing & Outreach', 'EXPENSE'),
(241, 'Travel & Meetings', 'EXPENSE'),
(242, 'Equipment Rental', 'EXPENSE'),
(243, 'Postage & Shipping', 'EXPENSE'),
(244, 'Bank Fees', 'EXPENSE'),
(245, 'Depreciation', 'EXPENSE'),
(246, 'Interest Expense', 'EXPENSE'),
(247, 'Scholarship Disbursements', 'EXPENSE'),
(248, 'Mission Support', 'EXPENSE'),
(249, 'Food & Hospitality', 'EXPENSE'),
(250, 'Miscellaneous Expense', 'EXPENSE');

-- Insert Transactions and their corresponding Splits
-- Transaction 1: Opening Balance
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-01-01', 'Opening Balance - Checking Account');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 50000.00, 3, 201),
(LAST_INSERT_ID(), -50000.00, 1, 200);

-- Transaction 2: Opening Balance - Savings
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-01-01', 'Opening Balance - Savings Account');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 25000.00, 3, 202),
(LAST_INSERT_ID(), -25000.00, 1, 200);

-- Transaction 3: General Donation
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-01-05', 'Weekly Offering - Week 1');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3250.00, 3, 201),
(LAST_INSERT_ID(), -3250.00, 3, 220);

-- Transaction 4: Designated Donation - Mission
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-01-07', 'Designated Gift - Mission Fund');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 1500.00, 5, 201),
(LAST_INSERT_ID(), -1500.00, 5, 221);

-- Transaction 5: Utility Payment
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-01-10', 'Electric Bill - December');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -450.75, 3, 234),
(LAST_INSERT_ID(), 450.75, 3, 201);

-- Transaction 6: Salary Payment
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-01-15', 'Payroll - January 1st Period');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -8500.00, 3, 230),
(LAST_INSERT_ID(), 8500.00, 3, 201);

-- Transaction 7: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-01-12', 'Weekly Offering - Week 2');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 2875.50, 3, 201),
(LAST_INSERT_ID(), -2875.50, 3, 220);

-- Transaction 8: Building Fund Donation
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-01-14', 'Building Fund Contribution');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 5000.00, 4, 201),
(LAST_INSERT_ID(), -5000.00, 4, 221);

-- Transaction 9: Office Supplies
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-01-16', 'Office Depot - Supplies');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -287.45, 17, 237),
(LAST_INSERT_ID(), 287.45, 17, 201);

-- Transaction 10: Internet Service
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-01-18', 'Internet Service - January');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -125.00, 12, 234),
(LAST_INSERT_ID(), 125.00, 12, 201);

-- Transaction 11: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-01-19', 'Weekly Offering - Week 3');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3420.75, 3, 201),
(LAST_INSERT_ID(), -3420.75, 3, 220);

-- Transaction 12: Youth Program Supplies
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-01-20', 'Youth Event Supplies');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -342.80, 6, 238),
(LAST_INSERT_ID(), 342.80, 6, 201);

-- Transaction 13: Music Equipment
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-01-22', 'Worship Sound Equipment');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -1250.00, 7, 239),
(LAST_INSERT_ID(), 1250.00, 7, 201);

-- Transaction 14: Grant Received
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-01-23', 'Community Grant - Education Programs');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 10000.00, 10, 201),
(LAST_INSERT_ID(), -10000.00, 10, 222);

-- Transaction 15: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-01-26', 'Weekly Offering - Week 4');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3125.00, 3, 201),
(LAST_INSERT_ID(), -3125.00, 3, 220);

-- Transaction 16: Insurance Payment
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-01-28', 'Property Insurance - Q1');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -2850.00, 3, 235),
(LAST_INSERT_ID(), 2850.00, 3, 201);

-- Transaction 17: Mission Support Payment
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-01-29', 'Monthly Mission Partner Support');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -1500.00, 5, 248),
(LAST_INSERT_ID(), 1500.00, 5, 201);

-- Transaction 18: Payroll - 2nd Period
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-01-30', 'Payroll - January 2nd Period');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -8500.00, 3, 230),
(LAST_INSERT_ID(), 8500.00, 3, 201);

-- Transaction 19: Fundraiser Income
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-02-01', 'Pancake Breakfast Fundraiser');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 875.00, 6, 201),
(LAST_INSERT_ID(), -875.00, 6, 223);

-- Transaction 20: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-02-02', 'Weekly Offering - Week 5');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3650.25, 3, 201),
(LAST_INSERT_ID(), -3650.25, 3, 220);

-- Transaction 21: Maintenance Supplies
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-02-03', 'HVAC Filter Replacement');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -185.50, 11, 236),
(LAST_INSERT_ID(), 185.50, 11, 201);

-- Transaction 22: Scholarship Award
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-02-05', 'Student Scholarship - Spring Semester');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -2500.00, 13, 247),
(LAST_INSERT_ID(), 2500.00, 13, 201);

-- Transaction 23: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-02-09', 'Weekly Offering - Week 6');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3280.00, 3, 201),
(LAST_INSERT_ID(), -3280.00, 3, 220);

-- Transaction 24: Technology Purchase
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-02-10', 'Laptop for Admin Office');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -1450.00, 12, 239),
(LAST_INSERT_ID(), 1450.00, 12, 201);

-- Transaction 25: Water Bill
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-02-12', 'Water & Sewer - January');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -125.80, 3, 234),
(LAST_INSERT_ID(), 125.80, 3, 201);

-- Transaction 26: Payroll
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-02-15', 'Payroll - February 1st Period');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -8500.00, 3, 230),
(LAST_INSERT_ID(), 8500.00, 3, 201);

-- Transaction 27: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-02-16', 'Weekly Offering - Week 7');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3890.50, 3, 201),
(LAST_INSERT_ID(), -3890.50, 3, 220);

-- Transaction 28: Emergency Relief Donation
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-02-18', 'Designated Gift - Emergency Relief');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 5000.00, 9, 201),
(LAST_INSERT_ID(), -5000.00, 9, 221);

-- Transaction 29: Event Registration
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-02-19', 'Conference Registration Fees');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 1250.00, 14, 201),
(LAST_INSERT_ID(), -1250.00, 14, 224);

-- Transaction 30: Marketing Materials
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-02-20', 'Flyers & Banners for Outreach');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -425.00, 8, 240),
(LAST_INSERT_ID(), 425.00, 8, 201);

-- Transaction 31: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-02-23', 'Weekly Offering - Week 8');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3540.75, 3, 201),
(LAST_INSERT_ID(), -3540.75, 3, 220);

-- Transaction 32: Professional Services
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-02-24', 'Accounting Services - January');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -850.00, 17, 233),
(LAST_INSERT_ID(), 850.00, 17, 201);

-- Transaction 33: Building Fund Transfer
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-02-25', 'Transfer to Savings - Building Fund');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -5000.00, 4, 201),
(LAST_INSERT_ID(), 5000.00, 4, 202);

-- Transaction 34: Food & Hospitality
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-02-26', 'Coffee & Refreshments');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -165.40, 3, 249),
(LAST_INSERT_ID(), 165.40, 3, 201);

-- Transaction 35: Payroll
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-02-28', 'Payroll - February 2nd Period');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -8500.00, 3, 230),
(LAST_INSERT_ID(), 8500.00, 3, 201);

-- Transaction 36: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-03-01', 'Weekly Offering - Week 9');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3775.25, 3, 201),
(LAST_INSERT_ID(), -3775.25, 3, 220);

-- Transaction 37: Memorial Donation
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-03-03', 'Memorial Gift - Smith Family');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 2000.00, 20, 201),
(LAST_INSERT_ID(), -2000.00, 20, 221);

-- Transaction 38: Gas Bill
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-03-05', 'Natural Gas - February');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -385.60, 3, 234),
(LAST_INSERT_ID(), 385.60, 3, 201);

-- Transaction 39: Travel Reimbursement
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-03-06', 'Staff Conference Travel');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -625.00, 17, 241),
(LAST_INSERT_ID(), 625.00, 17, 201);

-- Transaction 40: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-03-08', 'Weekly Offering - Week 10');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 4125.00, 3, 201),
(LAST_INSERT_ID(), -4125.00, 3, 220);

-- Transaction 41: Music Ministry Donation
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-03-10', 'Designated Gift - Music Ministry');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 750.00, 7, 201),
(LAST_INSERT_ID(), -750.00, 7, 221);

-- Transaction 42: Postage
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-03-11', 'Bulk Mail - Newsletter');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -245.80, 17, 243),
(LAST_INSERT_ID(), 245.80, 17, 201);

-- Transaction 43: Equipment Rental
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-03-12', 'Table & Chair Rental - Event');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -350.00, 14, 242),
(LAST_INSERT_ID(), 350.00, 14, 201);

-- Transaction 44: Payroll
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-03-15', 'Payroll - March 1st Period');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -8500.00, 3, 230),
(LAST_INSERT_ID(), 8500.00, 3, 201);

-- Transaction 45: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-03-15', 'Weekly Offering - Week 11');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3625.50, 3, 201),
(LAST_INSERT_ID(), -3625.50, 3, 220);

-- Transaction 46: Benevolence Distribution
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-03-17', 'Benevolence Assistance - Family Aid');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -500.00, 15, 247),
(LAST_INSERT_ID(), 500.00, 15, 201);

-- Transaction 47: Program Supplies
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-03-18', 'Education Program Materials');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -425.30, 10, 238),
(LAST_INSERT_ID(), 425.30, 10, 201);

-- Transaction 48: Bank Fees
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-03-20', 'Monthly Bank Service Fees');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -45.00, 3, 244),
(LAST_INSERT_ID(), 45.00, 3, 201);

-- Transaction 49: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-03-22', 'Weekly Offering - Week 12');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3950.75, 3, 201),
(LAST_INSERT_ID(), -3950.75, 3, 220);

-- Transaction 50: Rental Income
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-03-23', 'Facility Rental - Weekend Event');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 500.00, 3, 201),
(LAST_INSERT_ID(), -500.00, 3, 226);

-- Transaction 51: Parking Lot Maintenance
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-03-24', 'Parking Lot Line Painting');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -1250.00, 18, 236),
(LAST_INSERT_ID(), 1250.00, 18, 201);

-- Transaction 52: Electric Bill
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-03-26', 'Electric Bill - February');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -425.90, 3, 234),
(LAST_INSERT_ID(), 425.90, 3, 201);

-- Transaction 53: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-03-29', 'Weekly Offering - Week 13');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 4250.00, 3, 201),
(LAST_INSERT_ID(), -4250.00, 3, 220);

-- Transaction 54: Payroll
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-03-30', 'Payroll - March 2nd Period');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -8500.00, 3, 230),
(LAST_INSERT_ID(), 8500.00, 3, 201);

-- Transaction 55: Easter Program Donation
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-03-31', 'Designated Gift - Easter Programs');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3500.00, 19, 201),
(LAST_INSERT_ID(), -3500.00, 19, 221);

-- Transaction 56: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-04-05', 'Weekly Offering - Week 14');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 5125.75, 3, 201),
(LAST_INSERT_ID(), -5125.75, 3, 220);

-- Transaction 57: Easter Program Expenses
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-04-06', 'Easter Event Supplies & Decorations');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -1850.00, 19, 238),
(LAST_INSERT_ID(), 1850.00, 19, 201);

-- Transaction 58: Landscaping Service
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-04-08', 'Lawn Care - March');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -275.00, 11, 236),
(LAST_INSERT_ID(), 275.00, 11, 201);

-- Transaction 59: Office Equipment
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-04-09', 'Printer & Copier Supplies');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -385.75, 17, 237),
(LAST_INSERT_ID(), 385.75, 17, 201);

-- Transaction 60: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-04-12', 'Weekly Offering - Week 15');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3825.50, 3, 201),
(LAST_INSERT_ID(), -3825.50, 3, 220);

-- Transaction 61: Payroll
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-04-15', 'Payroll - April 1st Period');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -8500.00, 3, 230),
(LAST_INSERT_ID(), 8500.00, 3, 201);

-- Transaction 62: Investment Income
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-04-16', 'Quarterly Dividend Income');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 750.00, 3, 202),
(LAST_INSERT_ID(), -750.00, 3, 225);

-- Transaction 63: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-04-19', 'Weekly Offering - Week 16');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3675.25, 3, 201),
(LAST_INSERT_ID(), -3675.25, 3, 220);

-- Transaction 64: Software Subscription
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-04-20', 'Church Management Software - Annual');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -1200.00, 12, 239),
(LAST_INSERT_ID(), 1200.00, 12, 201);

-- Transaction 65: Youth Ministry Donation
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-04-21', 'Designated Gift - Youth Summer Camp');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 2500.00, 6, 201),
(LAST_INSERT_ID(), -2500.00, 6, 221);

-- Transaction 66: Maintenance Repair
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-04-22', 'Plumbing Repair - Restroom');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -525.00, 11, 236),
(LAST_INSERT_ID(), 525.00, 11, 201);

-- Transaction 67: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-04-26', 'Weekly Offering - Week 17');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 4050.00, 3, 201),
(LAST_INSERT_ID(), -4050.00, 3, 220);

-- Transaction 68: Outreach Event
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-04-27', 'Community Outreach Event Costs');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -875.50, 8, 238),
(LAST_INSERT_ID(), 875.50, 8, 201);

-- Transaction 69: Payroll
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-04-30', 'Payroll - April 2nd Period');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -8500.00, 3, 230),
(LAST_INSERT_ID(), 8500.00, 3, 201);

-- Transaction 70: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-05-03', 'Weekly Offering - Week 18');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3890.75, 3, 201),
(LAST_INSERT_ID(), -3890.75, 3, 220);

-- Transaction 71: Insurance Payment
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-05-05', 'Liability Insurance - Q2');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -1850.00, 3, 235),
(LAST_INSERT_ID(), 1850.00, 3, 201);

-- Transaction 72: Water Bill
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-05-07', 'Water & Sewer - April');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -145.30, 3, 234),
(LAST_INSERT_ID(), 145.30, 3, 201);

-- Transaction 73: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-05-10', 'Weekly Offering - Week 19');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3725.50, 3, 201),
(LAST_INSERT_ID(), -3725.50, 3, 220);

-- Transaction 74: Building Fund Large Donation
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-05-12', 'Major Gift - Building Fund');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 15000.00, 4, 201),
(LAST_INSERT_ID(), -15000.00, 4, 221);

-- Transaction 75: Payroll
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-05-15', 'Payroll - May 1st Period');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -8500.00, 3, 230),
(LAST_INSERT_ID(), 8500.00, 3, 201);

-- Transaction 76: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-05-17', 'Weekly Offering - Week 20');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3950.25, 3, 201),
(LAST_INSERT_ID(), -3950.25, 3, 220);

-- Transaction 77: Technology Upgrade
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-05-18', 'Streaming Equipment Upgrade');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -2850.00, 12, 239),
(LAST_INSERT_ID(), 2850.00, 12, 201);

-- Transaction 78: Professional Services
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-05-20', 'Legal Services - Contract Review');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -950.00, 17, 233),
(LAST_INSERT_ID(), 950.00, 17, 201);

-- Transaction 79: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-05-24', 'Weekly Offering - Week 21');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 4125.00, 3, 201),
(LAST_INSERT_ID(), -4125.00, 3, 220);

-- Transaction 80: Mission Trip Support
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-05-25', 'Mission Trip Expenses');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -3500.00, 5, 248),
(LAST_INSERT_ID(), 3500.00, 5, 201);

-- Transaction 81: Payroll
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-05-30', 'Payroll - May 2nd Period');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -8500.00, 3, 230),
(LAST_INSERT_ID(), 8500.00, 3, 201);

-- Transaction 82: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-05-31', 'Weekly Offering - Week 22');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3850.50, 3, 201),
(LAST_INSERT_ID(), -3850.50, 3, 220);

-- Transaction 83: Electric Bill
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-06-02', 'Electric Bill - May');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -475.80, 3, 234),
(LAST_INSERT_ID(), 475.80, 3, 201);

-- Transaction 84: Scholarship Donation
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-06-04', 'Designated Gift - Scholarship Fund');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 5000.00, 13, 201),
(LAST_INSERT_ID(), -5000.00, 13, 221);

-- Transaction 85: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-06-07', 'Weekly Offering - Week 23');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 4275.75, 3, 201),
(LAST_INSERT_ID(), -4275.75, 3, 220);

-- Transaction 86: Food & Hospitality
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-06-08', 'Fellowship Meal Supplies');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -425.60, 3, 249),
(LAST_INSERT_ID(), 425.60, 3, 201);

-- Transaction 87: Worship Supplies
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-06-09', 'Communion Supplies');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -125.50, 16, 238),
(LAST_INSERT_ID(), 125.50, 16, 201);

-- Transaction 88: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-06-14', 'Weekly Offering - Week 24');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3625.25, 3, 201),
(LAST_INSERT_ID(), -3625.25, 3, 220);

-- Transaction 89: Payroll
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-06-15', 'Payroll - June 1st Period');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -8500.00, 3, 230),
(LAST_INSERT_ID(), 8500.00, 3, 201);

-- Transaction 90: Grant Application Fee
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-06-16', 'Grant Application Processing');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -150.00, 17, 250),
(LAST_INSERT_ID(), 150.00, 17, 201);

-- Transaction 91: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-06-21', 'Weekly Offering - Week 25');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 4050.00, 3, 201),
(LAST_INSERT_ID(), -4050.00, 3, 220);

-- Transaction 92: VBS Donation
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-06-22', 'VBS Program Donation');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 1500.00, 6, 201),
(LAST_INSERT_ID(), -1500.00, 6, 221);

-- Transaction 93: VBS Supplies
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-06-23', 'VBS Program Materials');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -1285.40, 6, 238),
(LAST_INSERT_ID(), 1285.40, 6, 201);

-- Transaction 94: Air Conditioning Repair
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-06-24', 'HVAC Repair - Sanctuary');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -1850.00, 11, 236),
(LAST_INSERT_ID(), 1850.00, 11, 201);

-- Transaction 95: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-06-28', 'Weekly Offering - Week 26');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3775.50, 3, 201),
(LAST_INSERT_ID(), -3775.50, 3, 220);

-- Transaction 96: Payroll
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-06-30', 'Payroll - June 2nd Period');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -8500.00, 3, 230),
(LAST_INSERT_ID(), 8500.00, 3, 201);

-- Transaction 97: Internet Service
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-07-01', 'Internet Service - July');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -125.00, 12, 234),
(LAST_INSERT_ID(), 125.00, 12, 201);

-- Transaction 98: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-07-05', 'Weekly Offering - Week 27');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3425.75, 3, 201),
(LAST_INSERT_ID(), -3425.75, 3, 220);

-- Transaction 99: Memorial Gift
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-07-07', 'Memorial Gift - Johnson Family');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 1500.00, 20, 201),
(LAST_INSERT_ID(), -1500.00, 20, 221);

-- Transaction 100: Office Supplies
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-07-08', 'Office Supplies - Quarterly Order');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -325.80, 17, 237),
(LAST_INSERT_ID(), 325.80, 17, 201);

-- Transaction 101: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-07-12', 'Weekly Offering - Week 28');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3950.25, 3, 201),
(LAST_INSERT_ID(), -3950.25, 3, 220);

-- Transaction 102: Payroll
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-07-15', 'Payroll - July 1st Period');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -8500.00, 3, 230),
(LAST_INSERT_ID(), 8500.00, 3, 201);

-- Transaction 103: Landscaping
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-07-16', 'Lawn Care & Landscaping - July');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -295.00, 11, 236),
(LAST_INSERT_ID(), 295.00, 11, 201);

-- Transaction 104: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-07-19', 'Weekly Offering - Week 29');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 4125.00, 3, 201),
(LAST_INSERT_ID(), -4125.00, 3, 220);

-- Transaction 105: Emergency Relief Distribution
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-07-20', 'Emergency Assistance - Local Family');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -750.00, 9, 247),
(LAST_INSERT_ID(), 750.00, 9, 201);

-- Transaction 106: Water Bill
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-07-22', 'Water & Sewer - June');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -165.40, 3, 234),
(LAST_INSERT_ID(), 165.40, 3, 201);

-- Transaction 107: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-07-26', 'Weekly Offering - Week 30');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3825.50, 3, 201),
(LAST_INSERT_ID(), -3825.50, 3, 220);

-- Transaction 108: Education Grant
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-07-28', 'Education Grant - Summer Programs');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 7500.00, 10, 201),
(LAST_INSERT_ID(), -7500.00, 10, 222);

-- Transaction 109: Payroll
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-07-30', 'Payroll - July 2nd Period');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -8500.00, 3, 230),
(LAST_INSERT_ID(), 8500.00, 3, 201);

-- Transaction 110: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-08-02', 'Weekly Offering - Week 31');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3675.75, 3, 201),
(LAST_INSERT_ID(), -3675.75, 3, 220);

-- Transaction 111: Electric Bill
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-08-05', 'Electric Bill - July');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -525.90, 3, 234),
(LAST_INSERT_ID(), 525.90, 3, 201);

-- Transaction 112: Youth Camp Registration
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-08-06', 'Summer Camp Registration Fees');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 2250.00, 6, 201),
(LAST_INSERT_ID(), -2250.00, 6, 224);

-- Transaction 113: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-08-09', 'Weekly Offering - Week 32');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 4250.25, 3, 201),
(LAST_INSERT_ID(), -4250.25, 3, 220);

-- Transaction 114: Music Copyright Licenses
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-08-10', 'CCLI License Renewal');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -425.00, 7, 239),
(LAST_INSERT_ID(), 425.00, 7, 201);

-- Transaction 115: Payroll
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-08-15', 'Payroll - August 1st Period');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -8500.00, 3, 230),
(LAST_INSERT_ID(), 8500.00, 3, 201);

-- Transaction 116: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-08-16', 'Weekly Offering - Week 33');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3875.50, 3, 201),
(LAST_INSERT_ID(), -3875.50, 3, 220);

-- Transaction 117: Accounting Services
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-08-18', 'Accounting Services - Q2 Review');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -1250.00, 17, 233),
(LAST_INSERT_ID(), 1250.00, 17, 201);

-- Transaction 118: Building Fund Interest
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-08-19', 'Savings Account Interest');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 125.50, 4, 202),
(LAST_INSERT_ID(), -125.50, 4, 225);

-- Transaction 119: Weekly Offering
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-08-23', 'Weekly Offering - Week 34');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 4050.00, 3, 201),
(LAST_INSERT_ID(), -4050.00, 3, 220);

-- Transaction 120: Scholarship Award
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-08-25', 'Fall Semester Scholarship');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -3000.00, 13, 247),
(LAST_INSERT_ID(), 3000.00, 13, 201);

-- Continuing with more transactions to reach 1000 lines...
-- Transaction 121-150: Additional September-October transactions
INSERT INTO Transactions (UserDate, Description) VALUES ('2024-08-30', 'Weekly Offering - Week 35');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3950.75, 3, 201),
(LAST_INSERT_ID(), -3950.75, 3, 220);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-08-30', 'Payroll - August 2nd Period');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -8500.00, 3, 230),
(LAST_INSERT_ID(), 8500.00, 3, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-09-01', 'Fall Program Registration');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 1875.00, 10, 201),
(LAST_INSERT_ID(), -1875.00, 10, 224);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-09-03', 'Gas Bill - August');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -195.30, 3, 234),
(LAST_INSERT_ID(), 195.30, 3, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-09-06', 'Weekly Offering - Week 36');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 4175.25, 3, 201),
(LAST_INSERT_ID(), -4175.25, 3, 220);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-09-08', 'Community Event Donation');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 2500.00, 14, 201),
(LAST_INSERT_ID(), -2500.00, 14, 221);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-09-10', 'Fall Festival Supplies');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -625.80, 14, 238),
(LAST_INSERT_ID(), 625.80, 14, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-09-13', 'Weekly Offering - Week 37');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3825.50, 3, 201),
(LAST_INSERT_ID(), -3825.50, 3, 220);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-09-15', 'Payroll - September 1st Period');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -8500.00, 3, 230),
(LAST_INSERT_ID(), 8500.00, 3, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-09-16', 'Building Maintenance - Roof Inspection');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -450.00, 11, 236),
(LAST_INSERT_ID(), 450.00, 11, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-09-18', 'Equipment Purchase - Kitchen');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -1850.00, 11, 239),
(LAST_INSERT_ID(), 1850.00, 11, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-09-20', 'Weekly Offering - Week 38');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 4325.00, 3, 201),
(LAST_INSERT_ID(), -4325.00, 3, 220);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-09-22', 'Outreach Materials');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -375.50, 8, 240),
(LAST_INSERT_ID(), 375.50, 8, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-09-23', 'Mission Partner Support');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -1500.00, 5, 248),
(LAST_INSERT_ID(), 1500.00, 5, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-09-25', 'Bank Service Fees');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -45.00, 3, 244),
(LAST_INSERT_ID(), 45.00, 3, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-09-27', 'Weekly Offering - Week 39');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3975.75, 3, 201),
(LAST_INSERT_ID(), -3975.75, 3, 220);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-09-29', 'Fall Festival Income');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 1450.00, 14, 201),
(LAST_INSERT_ID(), -1450.00, 14, 223);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-09-30', 'Payroll - September 2nd Period');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -8500.00, 3, 230),
(LAST_INSERT_ID(), 8500.00, 3, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-10-01', 'Electric Bill - September');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -485.60, 3, 234),
(LAST_INSERT_ID(), 485.60, 3, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-10-04', 'Weekly Offering - Week 40');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 4125.50, 3, 201),
(LAST_INSERT_ID(), -4125.50, 3, 220);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-10-06', 'Designated Gift - Worship Fund');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 1250.00, 16, 201),
(LAST_INSERT_ID(), -1250.00, 16, 221);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-10-08', 'Worship Sound System Repair');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -725.00, 16, 239),
(LAST_INSERT_ID(), 725.00, 16, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-10-11', 'Weekly Offering - Week 41');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3850.25, 3, 201),
(LAST_INSERT_ID(), -3850.25, 3, 220);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-10-13', 'Water & Sewer - September');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -155.70, 3, 234),
(LAST_INSERT_ID(), 155.70, 3, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-10-15', 'Payroll - October 1st Period');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -8500.00, 3, 230),
(LAST_INSERT_ID(), 8500.00, 3, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-10-18', 'Weekly Offering - Week 42');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 4375.00, 3, 201),
(LAST_INSERT_ID(), -4375.00, 3, 220);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-10-20', 'Education Program Materials');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -685.40, 10, 238),
(LAST_INSERT_ID(), 685.40, 10, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-10-22', 'Memorial Gift - Davis Family');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 2500.00, 20, 201),
(LAST_INSERT_ID(), -2500.00, 20, 221);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-10-25', 'Weekly Offering - Week 43');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3925.75, 3, 201),
(LAST_INSERT_ID(), -3925.75, 3, 220);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-10-27', 'Harvest Festival Expenses');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -825.50, 14, 238),
(LAST_INSERT_ID(), 825.50, 14, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-10-29', 'Landscaping - Fall Cleanup');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -425.00, 11, 236),
(LAST_INSERT_ID(), 425.00, 11, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-10-30', 'Payroll - October 2nd Period');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -8500.00, 3, 230),
(LAST_INSERT_ID(), 8500.00, 3, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-11-01', 'Weekly Offering - Week 44');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 4225.50, 3, 201),
(LAST_INSERT_ID(), -4225.50, 3, 220);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-11-03', 'Technology Donation');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3500.00, 12, 201),
(LAST_INSERT_ID(), -3500.00, 12, 221);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-11-05', 'Network Equipment Upgrade');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -2850.00, 12, 239),
(LAST_INSERT_ID(), 2850.00, 12, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-11-08', 'Weekly Offering - Week 45');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 3875.25, 3, 201),
(LAST_INSERT_ID(), -3875.25, 3, 220);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-11-10', 'Thanksgiving Program Supplies');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -525.80, 19, 238),
(LAST_INSERT_ID(), 525.80, 19, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-11-12', 'Benevolence Assistance');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -750.00, 15, 247),
(LAST_INSERT_ID(), 750.00, 15, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-11-15', 'Weekly Offering - Week 46');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 4625.00, 3, 201),
(LAST_INSERT_ID(), -4625.00, 3, 220);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-11-15', 'Payroll - November 1st Period');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -8500.00, 3, 230),
(LAST_INSERT_ID(), 8500.00, 3, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-11-17', 'Electric Bill - October');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -445.90, 3, 234),
(LAST_INSERT_ID(), 445.90, 3, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-11-19', 'Office Equipment Repair');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -285.00, 17, 239),
(LAST_INSERT_ID(), 285.00, 17, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-11-22', 'Weekly Offering - Week 47');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 5125.75, 3, 201),
(LAST_INSERT_ID(), -5125.75, 3, 220);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-11-24', 'Thanksgiving Food Baskets');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -1850.00, 8, 248),
(LAST_INSERT_ID(), 1850.00, 8, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-11-26', 'Facility Rental Income');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 650.00, 3, 201),
(LAST_INSERT_ID(), -650.00, 3, 226);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-11-29', 'Weekly Offering - Week 48');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 4375.50, 3, 201),
(LAST_INSERT_ID(), -4375.50, 3, 220);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-11-30', 'Payroll - November 2nd Period');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -8500.00, 3, 230),
(LAST_INSERT_ID(), 8500.00, 3, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-12-01', 'Advent Program Donation');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 2000.00, 19, 201),
(LAST_INSERT_ID(), -2000.00, 19, 221);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-12-03', 'Christmas Decorations');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -625.00, 19, 238),
(LAST_INSERT_ID(), 625.00, 19, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-12-06', 'Weekly Offering - Week 49');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 4550.25, 3, 201),
(LAST_INSERT_ID(), -4550.25, 3, 220);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-12-08', 'Year-End Major Gift');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 25000.00, 3, 201),
(LAST_INSERT_ID(), -25000.00, 3, 220);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-12-10', 'Insurance - Annual Review');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -3250.00, 3, 235),
(LAST_INSERT_ID(), 3250.00, 3, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-12-13', 'Weekly Offering - Week 50');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 4825.00, 3, 201),
(LAST_INSERT_ID(), -4825.00, 3, 220);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-12-15', 'Payroll - December 1st Period');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -8500.00, 3, 230),
(LAST_INSERT_ID(), 8500.00, 3, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-12-16', 'Year-End Accounting Services');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -1500.00, 17, 233),
(LAST_INSERT_ID(), 1500.00, 17, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-12-18', 'Christmas Program Expenses');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -1250.00, 19, 238),
(LAST_INSERT_ID(), 1250.00, 19, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-12-20', 'Weekly Offering - Week 51');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 6250.50, 3, 201),
(LAST_INSERT_ID(), -6250.50, 3, 220);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-12-22', 'Christmas Offering - Mission Fund');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 8500.00, 5, 201),
(LAST_INSERT_ID(), -8500.00, 5, 221);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-12-24', 'Holiday Food & Hospitality');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), -875.50, 3, 249),
(LAST_INSERT_ID(), 875.50, 3, 201);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-12-27', 'Weekly Offering - Week 52');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 4125.75, 3, 201),
(LAST_INSERT_ID(), -4125.75, 3, 220);

INSERT INTO Transactions (UserDate, Description) VALUES ('2024-12-28', 'Year-End Building Fund Gift');
INSERT INTO Split (Tran_id, Amount, FundId, AccountId) VALUES
(LAST_INSERT_ID(), 10000.00, 4, 201),
(LAST_INSERT_ID(), -10000.00, 4, 221);

-- End of data.sql file
COMMIT;