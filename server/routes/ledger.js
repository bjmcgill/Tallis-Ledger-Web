const express = require('express');
const router = express.Router();
const requireAuth = require('../middleware/requireAuth');
const { getLedger } = require('../controllers/ledgerController');

router.get('/', requireAuth, getLedger);

module.exports = router;
