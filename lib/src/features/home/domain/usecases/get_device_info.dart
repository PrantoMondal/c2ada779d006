import 'package:device_vitals/src/features/home/domain/entities/device_info_entity.dart';
import 'package:device_vitals/src/features/home/domain/repositories/device_info_repository.dart';

class GetDeviceInfo {
  final DeviceInfoRepository _repository;

  GetDeviceInfo(this._repository);

  Future<DeviceInfoEntity> call() => _repository.getAllInfo();
}
