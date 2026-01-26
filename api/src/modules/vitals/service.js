const repo = require("./repository");

class VitalsService {
  saveVital(vital) {
    return repo.insert(vital);
  }
}

module.exports = new VitalsService();
