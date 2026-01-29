const service = require('../src/modules/vitals/service');


describe('VitalsService', () => {
  const testVital = {
    device_id: 'test-device-1',
    thermal_value: 36.5,
    battery_level: 80,
    memory_usage: 40,
    timestamp: new Date().toISOString()
  };

  beforeEach(() => {
    jest.clearAllMocks();
    mockDb.clear();
  });

  describe('saveVital', () => {
    it('should save a vital record', () => {
      const mockVital = { ...testVital };
      mockDb.insert.mockReturnValueOnce(mockVital);

      const result = service.saveVital(mockVital);
      
      expect(mockDb.insert).toHaveBeenCalledWith(mockVital);
      expect(result).toEqual(mockVital);
    });
  });

  describe('getVitals', () => {
    it('should return all vitals', () => {
      const mockVitals = [
        { ...testVital },
        { ...testVital, device_id: 'test-device-2' }
      ];
      
      mockDb.getLatest.mockReturnValueOnce([...mockVitals]);

      const result = service.getVitals();
      
      expect(mockDb.getLatest).toHaveBeenCalled();
      expect(result).toEqual(mockVitals);
    });
  });

describe('getAnalytics', () => {
  it('should return analytics for a device with data', () => {
    const deviceId = 'test-device-1';
    const testVitals = [
      { ...testVital, thermal_value: 1, battery_level: 80, memory_usage: 40 },
      { ...testVital, thermal_value: 2, battery_level: 78, memory_usage: 42 },
      { ...testVital, thermal_value: 3, battery_level: 76, memory_usage: 44 }
    ];

    mockDb.getByDevice.mockReturnValueOnce([...testVitals]);

    const result = service.getAnalytics(deviceId);

    expect(mockDb.getByDevice).toHaveBeenCalledWith(deviceId);
    expect(result).toEqual({
      device_id: deviceId,
      rolling_average: {
        thermal: '2.00',
        battery: '78.00',
        memory: '42.00'
      },
      total_records: 3,
      last_updated: testVitals[2].timestamp
    });
  });
});

});