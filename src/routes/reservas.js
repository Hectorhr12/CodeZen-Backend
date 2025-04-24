const { Router } = require('express');
const { getAllReservas } = require('../controllers/reservaController');

const router = Router();

router.get('/', getAllReservas);

module.exports = router;