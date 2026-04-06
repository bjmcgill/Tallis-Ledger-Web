const express = require('express');
const router = express.Router();
const { connect, logout } = require('../controllers/authController');

router.post('/connect', connect);
router.delete('/logout', logout);

module.exports = router;
