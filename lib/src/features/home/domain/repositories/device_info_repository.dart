import 'package:device_vitals/src/features/home/domain/entities/device_info_entity.dart';

abstract interface class DeviceInfoRepository {
  Future<DeviceInfoEntity> getAllInfo();
}
