import 'package:device_vitals/src/features/home/data/datasources/device_info_datasource.dart';
import 'package:device_vitals/src/features/home/domain/repositories/device_info_repository.dart';

class DeviceInfoRepositoryImpl implements DeviceInfoRepository {
  final DeviceInfoDataSource _deviceInfoDataSource;

  DeviceInfoRepositoryImpl(this._deviceInfoDataSource);

  @override
  Future<Map<String, dynamic>> getAllInfo() {
    return _deviceInfoDataSource.getAllInfo();
  }

  @override
  Future<int?> getBatteryInfo() {
    return _deviceInfoDataSource.getBatteryInfo();
  }

  @override
  Future<double?> getMemoryInfo() {
    return _deviceInfoDataSource.getMemoryInfo();
  }

  @override
  Future<double?> getThermalInfo() {
    return _deviceInfoDataSource.getThermalInfo();
  }
}
