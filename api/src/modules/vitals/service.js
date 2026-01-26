const repo = require("./repository");

class VitalsService {
  saveVital(vital) {
    return repo.insert(vital);
  }

  getVitals() {
    return repo.getLatest();
  }

  getAnalytics(deviceId) {
    const data = repo.getAllByDevice(deviceId);
    if (data.length === 0) return null;

    const avg = (key) => data.reduce((sum, v) => sum + v[key], 0) / data.length;

    return {
      device_id: deviceId,
      rolling_average: {
        thermal: avg("thermal_value").toFixed(2),
        battery: avg("battery_level").toFixed(2),
        memory: avg("memory_usage").toFixed(2),
      },
      total_records: data.length,
      last_updated: data[data.length - 1].timestamp,
    };
  }
}

module.exports = new VitalsService();
