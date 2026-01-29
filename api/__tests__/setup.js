const { mockDb } = require('../__mocks__/db');

jest.mock('../src/modules/vitals/repository', () => require('../__mocks__/repository'));

beforeEach(() => {
  jest.clearAllMocks();
  mockDb.clear();
});

global.mockDb = mockDb;
