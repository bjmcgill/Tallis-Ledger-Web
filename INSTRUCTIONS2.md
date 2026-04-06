# Changes to Ledger View

The Add Transaction button will be disabled if the database user does not have insert permissions on both the Transactions and Split Tables

# Changes to AddEdit View

In edit mode only, the Save Transaction button will be disabled, only if the database user does not have both update and insert permissions on the transactions table, and insert permissions on the Split table.

In edit mode only, the Delete Transaction button will be disabled, only if the database user does not have update permissions on the Transactions table.

Change the effect of clicking the delete transaction button in edit mode, so that instead of deleting the current row in the transactions table, it marks the row for deletion by setting the deleted column to 1. The deleted_at column is set to CURRENT_TIMESTAMP. No Operations are carried out on the Split table. The user is returned to the ledger view as before.

Change the effect of clicking the save transaction button in add mode, so that a new row will be inserted into the transactions table taking the appropriate information from the grid. Transactions.id and Transactions.created_at will not be specified so that they will use autoincrement and CURRENT_TIMESTAMP respectively. Rows are inserted into the Split table using the appropriate information from the grid. The user is returned to the ledger view as before

Change the effect of clicking the save transaction button in edit mode, so that the current row in the transactions table is updated by setting the deleted column to 1 (marking it for deletion). The deleted_at column is set to CURRENT_TIMESTAMP. Additionally a new row will be inserted into the transactions table taking the appropriate information from the grid. Transactions.id and Transactions.created_at will not be specified so that they will use autoincrement and CURRENT_TIMESTAMP respectively. Rows are inserted into the Split table using the appropriate information from the grid. Split.Tran-id will take the value of the Transactions.Id that was just inserted into the Transactions table.

