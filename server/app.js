const path = require('path');
require('dotenv').config({ path: path.resolve(__dirname, '../.env') });

const express = require('express');
const session = require('express-session');
const cors = require('cors');

const authRoutes = require('./routes/auth');
const fundsRoutes = require('./routes/funds');
const accountsRoutes = require('./routes/accounts');
const ledgerRoutes = require('./routes/ledger');
const transactionsRoutes = require('./routes/transactions');
const errorHandler = require('./middleware/errorHandler');

const app = express();

app.use(express.json());

// In development, the Vite dev server handles the client.
// In production, serve the built React app from client/dist.
const isProd = process.env.NODE_ENV === 'production';
if (isProd) {
  const distPath = path.resolve(__dirname, '../client/dist');
  app.use(express.static(distPath));
} else {
  app.use(cors({
    origin: 'http://localhost:5173',
    credentials: true,
  }));
}

app.use(session({
  secret: process.env.SESSION_SECRET || 'dev-secret-change-in-production',
  resave: false,
  saveUninitialized: false,
  cookie: {
    secure: false,
    httpOnly: true,
    maxAge: 24 * 60 * 60 * 1000,
  },
}));

app.use('/api/auth', authRoutes);
app.use('/api/funds', fundsRoutes);
app.use('/api/accounts', accountsRoutes);
app.use('/api/ledger', ledgerRoutes);
app.use('/api/transactions', transactionsRoutes);

// In production, serve index.html for any non-API route (SPA fallback)
if (isProd) {
  const distPath = path.resolve(__dirname, '../client/dist');
  app.get('*', (req, res) => {
    res.sendFile(path.join(distPath, 'index.html'));
  });
}

app.use(errorHandler);

const PORT = process.env.PORT || process.env.SERVER_PORT || 3001;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

module.exports = app;
