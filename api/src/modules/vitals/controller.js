const service = require("./service");
const { vitalSchema } = require("./validation");

class VitalsController {
  create(req, res) {
    try {
      const parsed = vitalSchema.parse(req.body);
      service.saveVital(parsed);
      res.status(201).json({ message: "Vital recorded" });
    } catch (err) {
      res.status(400).json({ error: err.message });
    }
  }
}

module.exports = new VitalsController();
