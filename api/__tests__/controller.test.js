const request = require('supertest');
const app = require('../src/app');

jest.mock('../src/modules/vitals/validation', () => ({
  vitalSchema: {
    parse: jest.fn((data) => ({
      ...data,
      timestamp: new Date().toISOString(),
    })),
  },
}));

describe('Vitals Controller', () => {
  const baseUrl = '/api/vitals';
  const testVital = {
    device_id: 'test-device-1',
    thermal_value: 1,
    battery_level: 85,
    memory_usage: 45,
    timestamp: new Date().toISOString()
  };

  afterEach(() => {
    jest.clearAllMocks();
    mockDb.clear();
  });

  describe('POST /vitals', () => {
    it('should create a new vital record', async () => {
      const response = await request(app)
        .post(baseUrl)
        .send(testVital)
        .expect(201);

      expect(response.body).toHaveProperty('message', 'Vitals logged successfully');
      expect(mockDb.insert).toHaveBeenCalledTimes(1);
    });

    it('should return 400 for invalid data', async () => {
      const { vitalSchema } = require('../src/modules/vitals/validation');
      const error = new Error('Validation error');
      vitalSchema.parse.mockImplementationOnce(() => {
        throw error;
      });

      const response = await request(app)
        .post(baseUrl)
        .send({ invalid: 'data' })
        .expect(400);

      expect(response.body).toHaveProperty('error', 'Validation error');
    });
  });

  describe('GET /vitals', () => {
    it('should return all vitals', async () => {
      mockDb.insert(testVital);
      mockDb.insert({ ...testVital, device_id: 'test-device-2' });

      const response = await request(app)
        .get(baseUrl)
        .expect(200);

      expect(Array.isArray(response.body)).toBe(true);
      expect(response.body.length).toBe(2);
      expect(mockDb.getLatest).toHaveBeenCalledTimes(1);
    });
  });

  describe('GET /vitals/analytics', () => {
    it('should return analytics for a device', async () => {
      const deviceId = 'test-device-1';
      const testVitals = [
        { ...testVital, thermal_value: 3, battery_level: 80, memory_usage: 40 },
        { ...testVital, thermal_value: 2, battery_level: 78, memory_usage: 42 },
        { ...testVital, thermal_value: 1, battery_level: 76, memory_usage: 44 }
      ];

      testVitals.forEach(vital => mockDb.insert(vital));

      const response = await request(app)
        .get(`${baseUrl}/analytics`)
        .query({ device_id: deviceId })
        .expect(200);

      expect(response.body).toHaveProperty('device_id', deviceId);
      expect(response.body).toHaveProperty('total_records', 3);
      expect(response.body.rolling_average).toEqual({
        thermal: '2.00',
        battery: '78.00',
        memory: '42.00'
      });
    });

    it('should return 400 if device_id is missing', async () => {
      const response = await request(app)
        .get(`${baseUrl}/analytics`)
        .expect(400);

      expect(response.body).toHaveProperty('error', 'device_id is required');
    });

    it('should return 404 if no data found for device', async () => {
      const response = await request(app)
        .get(`${baseUrl}/analytics`)
        .query({ device_id: 'non-existent-device' })
        .expect(404);

      expect(response.body).toHaveProperty('error', 'No data found');
    });
  });
});