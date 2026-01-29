const router = require("express").Router();
const controller = require("./controller");

router.post("/vitals", controller.create);
router.get("/vitals", controller.getAll);
router.get("/vitals/analytics", controller.getAnalytics);

module.exports = router;
