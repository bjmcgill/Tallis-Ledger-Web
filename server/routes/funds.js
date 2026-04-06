const express = require('express');
const router = express.Router();
const requireAuth = require('../middleware/requireAuth');
const { listFunds } = require('../controllers/fundsController');

router.get('/', requireAuth, listFunds);

module.exports = router;
