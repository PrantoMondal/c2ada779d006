abstract interface class DeviceInfoRepository {
  Future<Map<String, dynamic>> getAllInfo();

  Future<int?> getBatteryInfo();

  Future<double?> getMemoryInfo();

  Future<double?> getThermalInfo();
}
