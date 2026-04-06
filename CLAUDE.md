# Tallis Ledger Web — CLAUDE.md

## Project Overview
Single-page React application for the Bee Sanctuary Movement (Manchester) charity finances. Lightweight ledger-based bookkeeping (~12 transactions/month).

## Tech Stack
- **Frontend**: React (JavaScript, Vite) + AG Grid Community Edition
- **Backend**: Node.js + Express
- **Database**: MySQL (local dev: MySQL 9.x; production: Krystal shared hosting)

## Project Structure
```
Tallis-Ledger-Web/
├── client/          # React SPA (Vite, port 5173 dev)
│   └── src/
│       ├── components/   # Reusable UI (buttons, modals, editors)
│       ├── pages/        # Top-level views: AuthPage, LedgerPage, AddEditPage
│       ├── hooks/        # Custom React hooks
│       ├── services/     # API fetch wrappers (authService, fundService, etc.)
│       └── utils/        # Pure helpers (formatDate, formatCurrency)
├── server/          # Express backend (port 3001)
│   ├── routes/      # Express route handlers
│   ├── controllers/ # Business logic
│   ├── models/      # Database query functions
│   ├── middleware/  # errorHandler, requireAuth
│   ├── db.js        # MySQL connection factory (per-request, credentials from session)
│   └── app.js       # Express app setup
├── .env             # Environment variables (never commit)
└── create.sql       # Database schema definitions
```

## Key Architectural Decisions
- **Authentication**: Users connect with their own MySQL credentials (user, password, database, port). Session stores credentials server-side; each API request creates a short-lived MySQL connection from session creds.
- **Permissions**: Checked at login time via `information_schema`. Determines which buttons are enabled (Add Transaction, Save Transaction, Delete Transaction).
- **Navigation**: No React Router — App.jsx manages `currentPage` state ('auth' | 'ledger' | 'addEdit') with conditional rendering.
- **Balance column**: Computed using MySQL views `LedgerViewWithFundBalance` and `LedgerViewWithAccountBalance`.
- **Ledger filter**: Either FundChoice or AccountChoice is active at one time. Default: AccountChoice with Account.Id = 0.

## Database Tables
- `Fund` — Id (PK), Name, Type
- `Account` — Id (PK), Name, Type
- `Transactions` — Id (AUTO_INCREMENT), UserDate, Description, Created_at, Deleted, Deleted_at
- `Split` — Id (AUTO_INCREMENT), Tran_id (FK→Transactions), Amount, FundId (FK→Fund), AccountId (FK→Account)

## Coding Conventions
- JavaScript only (no TypeScript)
- ES6+: arrow functions, destructuring, template literals, async/await
- `const` over `let`, never `var`
- 2-space indentation, single quotes, semicolons
- Functional React components with hooks only
- Components: PascalCase; functions/vars: camelCase; constants: UPPER_SNAKE_CASE; CSS: kebab-case
- All API calls through `services/` — components never call `fetch` directly
- Database queries in `models/` — controllers call models; routes call controllers

## API Endpoints
- `POST /api/auth/connect` — connect with MySQL credentials, returns permissions
- `DELETE /api/auth/logout` — destroy session
- `GET /api/funds` — list all funds
- `GET /api/accounts` — list all accounts
- `GET /api/ledger?type=fund&id=X` — ledger rows filtered by fund (with balance)
- `GET /api/ledger?type=account&id=X` — ledger rows filtered by account (with balance)
- `GET /api/transactions/:id` — transaction + splits for edit
- `POST /api/transactions` — create transaction + splits (DB transaction)
- `PUT /api/transactions/:id` — update transaction + splits (DB transaction)
- `DELETE /api/transactions/:id` — delete transaction + splits (DB transaction)

## Running Locally
```bash
# Server
cd server && npm install && npm start    # http://localhost:3001

# Client
cd client && npm install && npm run dev  # http://localhost:5173
```

## Environment Variables (.env)
```
SESSION_SECRET=your-secret-here
SERVER_PORT=3001
```
