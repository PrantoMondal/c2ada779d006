const Database = require("better-sqlite3");

const db = new Database("data/vitals.db");

db.prepare(
  `
CREATE TABLE IF NOT EXISTS vitals (
id INTEGER PRIMARY KEY AUTOINCREMENT,
device_id TEXT NOT NULL,
timestamp TEXT NOT NULL,
thermal_value INTEGER NOT NULL,
battery_level INTEGER NOT NULL,
memory_usage INTEGER NOT NULL
)
`,
).run();

module.exports = db;
