const router = require("express").Router();
const controller = require("./controller");

router.post("/vitals", controller.create);

module.exports = router;
