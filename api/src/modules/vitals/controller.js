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

  getAll(req, res) {
    const data = service.getVitals();
    res.json(data);
  }

  getAnalytics(req, res) {
    const { device_id } = req.query;
    if (!device_id) {
      return res.status(400).json({ error: "device_id is required" });
    }

    const analytics = service.getAnalytics(device_id);
    if (!analytics) {
      return res.status(404).json({ error: "No data found" });
    }

    res.json(analytics);
  }
}

module.exports = new VitalsController();
