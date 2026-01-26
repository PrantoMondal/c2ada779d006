const db = require("../../config/database");

class VitalsRepository {
  insert(vital) {
    const stmt = db.prepare(`
      INSERT INTO vitals 
      (device_id, timestamp, thermal_value, battery_level, memory_usage)
      VALUES (?, ?, ?, ?, ?)
    `);

    return stmt.run(
      vital.device_id,
      vital.timestamp,
      vital.thermal_value,
      vital.battery_level,
      vital.memory_usage,
    );
  }
}

module.exports = new VitalsRepository();
