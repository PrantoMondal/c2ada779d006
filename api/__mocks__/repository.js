const { mockDb } = require('./db');

module.exports = {
  insert: (vital) => mockDb.insert(vital),
  getLatest: () => mockDb.getLatest(),
  getAllByDevice: (deviceId) => mockDb.getByDevice(deviceId)
};
