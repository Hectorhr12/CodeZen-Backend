const { Router } = require("express");
const { historyController } = require("../controllers/history");

const router = Router();

router.get('/', historyController.getHostHistory);
router.get('/:id', historyController.getReservationDetails);

module.exports = router;