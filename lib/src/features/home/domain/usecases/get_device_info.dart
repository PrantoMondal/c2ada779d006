import 'package:device_vitals/src/features/home/domain/repositories/device_info_repository.dart';

class GetDeviceInfo {
  final DeviceInfoRepository _repository;

  GetDeviceInfo(this._repository);

  Future<Map<String, dynamic>> call() => _repository.getAllInfo();
}
