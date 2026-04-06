const express = require('express');
const router = express.Router();
const requireAuth = require('../middleware/requireAuth');
const { getTransaction, create, update, remove } = require('../controllers/transactionsController');

router.get('/:id', requireAuth, getTransaction);
router.post('/', requireAuth, create);
router.put('/:id', requireAuth, update);
router.delete('/:id', requireAuth, remove);

module.exports = router;
