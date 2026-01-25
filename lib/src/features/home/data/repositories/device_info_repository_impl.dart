import 'package:device_vitals/src/features/home/data/datasources/device_info_datasource.dart';
import 'package:device_vitals/src/features/home/domain/repositories/device_info_repository.dart';

class DeviceInfoRepositoryImpl implements DeviceInfoRepository {
  final DeviceInfoDataSource _localDataSource;

  DeviceInfoRepositoryImpl(this._localDataSource);

  @override
  Future<Map<String, dynamic>> getAllInfo() {
    return _localDataSource.getAllInfo();
  }

  @override
  Future<int?> getBatteryInfo() {
    return _localDataSource.getBatteryInfo();
  }

  @override
  Future<double?> getMemoryInfo() {
    return _localDataSource.getMemoryInfo();
  }

  @override
  Future<double?> getThermalInfo() {
    return _localDataSource.getThermalInfo();
  }
}
