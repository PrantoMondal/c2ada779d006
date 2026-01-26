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

  getLatest(limit = 100) {
    return db
      .prepare(
        `
      SELECT * FROM vitals
      ORDER BY timestamp DESC
      LIMIT ?
    `,
      )
      .all(limit);
  }

  getAllByDevice(deviceId) {
    return db
      .prepare(
        `
      SELECT * FROM vitals
      WHERE device_id = ?
      ORDER BY timestamp ASC
    `,
      )
      .all(deviceId);
  }
}

module.exports = new VitalsRepository();
