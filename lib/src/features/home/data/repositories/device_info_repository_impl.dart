import 'dart:developer';

import 'package:device_vitals/src/features/home/data/datasources/device_info_datasource.dart';
import 'package:device_vitals/src/features/home/domain/entities/device_info_entity.dart';
import 'package:device_vitals/src/features/home/domain/repositories/device_info_repository.dart';

class DeviceInfoRepositoryImpl implements DeviceInfoRepository {
  final DeviceInfoDataSource dataSource;

  DeviceInfoRepositoryImpl(this.dataSource);

  @override
  Future<DeviceInfoEntity> getAllInfo() async {
    final model = await dataSource.getAllInfo();
    return DeviceInfoEntity(
      batteryLevel: model.batteryLevel,
      isCharging: model.isCharging,
      memoryUsagePercentage: model.memoryUsagePercentage,
      thermalStatus: model.thermalStatus,
    );
  }
}
