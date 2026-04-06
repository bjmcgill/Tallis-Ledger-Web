Build the following program, creating a CLAUDE.md file as you go.

# Tallis Ledger Web — Project Instructions

## Project Overview & Goals

---

Tallis Ledger Web is a single-page React application for managing the finances of a small charity (the Bee Sanctuary Movement, Manchester). It provides simple ledger-based bookkeeping, supporting around a dozen transactions per month.

The application is intentionally lightweight and focused. It is not a full accounting suite. Its primary users are non-technical volunteers acting as treasurer.

---

## Tech Stack & Architecture

| Layer | Technology |
|---|---|
| Frontend | React (JavaScript, Vite) |
| Data grid | AG Grid Community Edition |
| Backend | Node.js with Express |
| Database | MySQL (local dev: MySQL 9.x via Homebrew; production: Krystal shared hosting |
| Hosting | Krystal (production) |
| Version control | Git / GitHub |


---

### Architecture notes

- This is a **single-page application (SPA)**. All navigation is handled client-side; there is no server-side rendering.
- The React frontend communicates with the Express backend via a **REST API**. The frontend and backend are separate concerns and should be developed in separate directories within the monorepo.
- The backend is responsible for all database access. The frontend never connects to MySQL directly.
- Authentication is by using database user name and password

---

### Database Definitions

- The definitions of the MySQL objects used in the program are contained in the create.sql file. The tables used are Fund, Account, Transactions and Split. The Split table contains transaction lines relevant to the transaction identified by Tran-id.

---

## File & Folder Structure

```
Tallis-Ledger-Web/
├── client/                  # React SPA (Vite)
│   ├── public/              # Static assets (favicon etc.)
│   ├── index.html           # Entry point — lives in root with Vite, not in public/
│   ├── vite.config.js       # Vite configuration
│   ├── src/
│   │   ├── components/      # Reusable UI components
│   │   ├── pages/           # Top-level page components (routed views)
│   │   ├── hooks/           # Custom React hooks
│   │   ├── services/        # API call functions (fetch wrappers)
│   │   ├── utils/           # Pure helper functions (formatting, date handling etc.)
│   │   ├── App.jsx
│   │   └── main.jsx         # Vite entry point (replaces index.js in CRA)
│   └── package.json
│
├── server/                  # Node.js / Express backend
│   ├── routes/              # Express route handlers
│   ├── controllers/         # Business logic
│   ├── models/              # Database query functions
│   ├── middleware/          # Express middleware (error handling etc.)
│   ├── db.js                # MySQL connection pool
│   ├── app.js               # Express app setup
│   └── package.json
│
├── .env                     # Environment variables (never commit)
├── .gitignore
├── .claudeignore
└── create.sql               # Database object definitions


> **Vite note:** Unlike Create React App, Vite places `index.html` in the project root (not `public/`), and uses `main.jsx` as the JavaScript entry point. The dev server runs on port 5173 by default. Use `vite.config.js` to configure the proxy for API calls to the Express backend during development.
```

### Key conventions for structure

- Keep `components/` for generic, reusable UI pieces (buttons, modals, form fields).
- Keep `pages/` for top-level views that map to routes (e.g. `LedgerPage`, `ReconcilePage`).
- All calls to the backend API belong in `services/`. Components never call `fetch` directly.
- Database queries belong in `models/`. Controllers call models; routes call controllers.

---

## Coding Conventions & Style

### General

- **JavaScript only** — no TypeScript for this project.
- Use **ES6+** syntax throughout: arrow functions, destructuring, template literals, `async/await`.
- Prefer `const` over `let`; never use `var`.
- One component per file. Filename matches the component name (PascalCase): `LedgerTable.jsx`.
- Non-component JS files use camelCase with `.js` extension: `formatCurrency.js`, `transactionService.js`.

### React

- Use **functional components** with hooks throughout. No class components.
- Keep components small and focused. If a component exceeds roughly 150 lines, consider splitting it.
- Lift state up to the nearest common ancestor. Avoid prop drilling beyond two levels — use React Context if needed.
- Use `useEffect` carefully: always specify dependency arrays explicitly.

### Naming

- Components: `PascalCase` (e.g. `TransactionRow`, `MonthPicker`)
- Functions and variables: `camelCase` (e.g. `fetchTransactions`, `currentBalance`)
- Constants: `UPPER_SNAKE_CASE` for true constants (e.g. `MAX_DESCRIPTION_LENGTH`)
- CSS class names: `kebab-case`

### API & backend

- REST endpoints follow the pattern `/api/[resource]` (e.g. `/api/transactions`, `/api/accounts`).
- Use standard HTTP verbs: `GET` for reads, `POST` for creates, `PUT` for updates, `DELETE` for deletes.
- All API responses return JSON. Errors include a `message` field and an appropriate HTTP status code.
- Environment variables are loaded via `dotenv`. Never hardcode credentials or connection strings.

### Formatting

- 2-space indentation.
- Single quotes for strings in JavaScript.
- Semicolons required.
- Keep lines under 100 characters where practical.

---

## Detailed Instructions

### Authentication View

On entrypoint you are given an authentication view. This will be a view which asks for input of user, password, database and port variables. There will be a "Submit" button (centered horizontally and underneath the input text fields) which uses the inputted variables to connect to the database given by the database variable, on the port, given by the port variable, using the username variable and password variable. It will then load the Ledger View using the connected database.

### Ledger View

At the top of the Ledger View screen will be two dropdown boxes: FundChoice and AccountChoice labelled "Fund: " and "Account: ". These will be centered horizontally as a group. Only one of these dropdown boxes will be active at any one time. The FundChoice dropdown box will show the contents of the Fund table with the display of the rows consisting of the Fund.Id, a colon and the Fund.Name, another colon and the Fund.Type. The AccountChoice dropdown box containing a similarly rendered representation of the Account Table. The purpose of these dropdown boxes will be to select transactions from the appropriate choice of Account or Fund in the boxed AG Grid mentioned below. On entering the Ledger View from Authentication View, The AccountChoice dropdown box will be selected with the row, with Account.Id set to 0.

The View has the buttons "Add Transaction" and "Logout" underneath these dropdown boxes. These will be centered horizontally as a group.

Clicking on the "Logout" button will close the database connection and return to Authentication view. The Authentication View will be prepopulated with the values that were previously submitted, with the exception of the Password box which will be clear.

The "Add Transaction" button will be disabled if the database user does not have insert permissions on both the Transactions and Split Tables. Clicking the "Add Transaction" button will launch the Add-Edit View in Add mode. This will allow you to insert the Splits (the line details) of a new transaction.

Underneath the bottons will be a scrollable grid (Using AG Grid) with the following columns: SplitId, TransactionsId, UserDate, Description, FundId, AccountId, Amount and Balance. The balance column will be a cumulative sum of the amount column. The grid will be created from a join of the Transactions table and Split table. The rows shown will be filtered based on whichever of the FundChoice and AccountChoice drop down boxes has been selected. The grid will fill the window with an appropriate margin at the bottom

Clicking on a row in the grid will launch the Add-Edit View in Edit mode. The TransactionsId of the row chosen will be passed on as a parameter. This will allow you to edit the Splits (the line details) of the chosen transaction.

### AddEdit View

The AddEdit View has two modes "add" and "edit". In "add" mode the following buttons will be shown at the top of the screen in a centered group: "Cancel", "Save Transaction" , "Add Split", "Delete Split", "Balance Split". In "edit" mode there will also be a "Delete Transaction" button.

In "edit" mode, the "Save Transaction" button will be disabled if the database user does not have both update permissions on the Transactions table, and delete and insert permissions on the Split table 

In "edit" mode the "Add Split" and "Delete Split" buttons will be disabled if the user does not have both update permissions on the Transactions table and delete and insert permissions on the Split table.

In "edit" mode, the "Delete Transaction" button will be disabled if the user does not have delete permissions on both the Transactions and Split tables.

Underneath these buttons will be a scrollable grid (Using AG Grid) with the following columns: "UserDate", "Description", "FundId", "AccountId" and "Amount". The grid will fill the window with an appropriate margin at the bottom. 

The FundId and AccountId cells will feature a drop down box. The FundId dropdown box will show the contents of the Fund table with the display of the rows consisting of the Fund.Id, a colon and the Fund.Name, another colon and the Fund.Type. The AccountId dropdown box will contain a similarly rendered representation of the Account Table. The actual value which will be saved when the user clicks "Save Transaction" will be the Fund.Id or Account.Id of the selected value of the dropdown box.

In "add" mode the grid will consist of two rows with the UserDate column filled with today's date. The Description column will have empty values. The FundId column, and AccountId column will be filled with the settings of FundChoice and AccountChoice from the Ledger View you were in last. The amount column will be filled with zeros.

In "edit" mode the UserDate and Description columns will be filled with the values of the Transaction row you selected in Ledger View. The FundId, AccountId and Amount columns will be filled with values from the Split table associated with the Tran_id of the Transaction row you selected in Ledger View. In other words the rows will correspond to all splits in the transaction you selected.

In both "add" and "edit" mode, all cells in the grid will be editable. Changing the value of a cell in the UserDate or Description columns will cause all other cells in that columnto be set with the same edited value.

Pressing the "Save Transacton" button in either "add" or "edit" mode will start a check to see if the sum of values in the amount column comes to zero. If it does not, a popup dialog box will appear saying that "The sum of values in the amount column does not come to zero, and therefore the transaction does not balance." When the user clicks on the "Ok" button on the popup box, no further action is taken.

Pressing the "Save Transaction" button in "add" mode will insert the appropriate row in the Transaction table, and insert the appropriate values in the Split table. The Transactions.Id and Split.Id values will not be specified and will automatically insert using the AUTOINCREMENT feature. Split.Tran-id will take the value of the Transactions.Id that was inserted into the Transactions table.

Pressing the "Save Transaction" button in "edit" mode will update the appropriate row in the Transaction table. It will then delete the existing rows in the Split table, and insert the appropriate values in the Split table, both using the specified Split.Tran-id

Pressing the "Add Split" button in either "add" or "edit" mode will insert a row after the row in the grid that is currently selected. "UserDate", "Description" will take the same values as the currently selected row in the grid. "FundId", "AccountId" will take the value of the row in the dropdown associated with the FundChoice and AccountChoice that were selected when you left Ledger View. "Amount" will take the value zero.

Pressing the "Delete Split" button in either "add" or "edit" mode will delete the split (that is row) that is currently selected. If no row is selected, or there are only two or less splits in the grid, no action will be taken.

Pressing the "Balance Split" button in either "add" or "edit" mode will alter the Amount cell in the currently selected row, so that the sum of the values in the Amount column will add up to zero. This will ensure that the transaction balances.

Pressing the "Delete Transaction" in "edit" mode will delete the appropriate row in the Transaction table, and delete the existing rows in the Split table with the specified Split.Tran-id.

When the user clicks on either the "Cancel", "Save Transaction" or "Delete Transaction" button, and after any tables have been modified, the user will be returned to Ledger View with the same settings for the FundChoice and AccountChoice dropdown boxes you last left it in. The grid will be filtered using the dropdown box which was selected when you last left Ledger View.

All operations on the database as a result of clicking the "Save Transaction" or "Delete Transaction" button will be executed as a block transaction, that will roll back if there are any database errors encountered. Any database errors will be announced to the user by a dialog box describing the error, and on the user pressing the "Ok" button on the box, the user will be returned to Ledger View with the same settings for the FundChoice and AccountChoice dropdown boxes you last left it in. The grid will be filtered using the dropdown box which was selected when you last left Ledger View.
