import 'package:device_vitals/src/features/home/data/models/info_params.dart';
import 'package:device_vitals/src/features/home/domain/repositories/device_info_remote_repository.dart';

class LogStatus {
  final DeviceInfoRemoteRepository repository;

  LogStatus(this.repository);

  Future<String> call({required InfoParams params}) {
    return repository.logStatus(params: params);
  }
}
