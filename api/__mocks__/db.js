const mockDb = {
  data: [],
  insert: jest.fn((vital) => {
    const newVital = { ...vital, id: Date.now() };
    mockDb.data.push(newVital);
    return newVital;
  }),
  getLatest: jest.fn(() => [...mockDb.data].reverse()),
  getByDevice: jest.fn((deviceId) => 
    mockDb.data.filter(vital => vital.device_id === deviceId)
  ),
  clear: function() {
    this.data = [];
  }
};

module.exports = { mockDb };
