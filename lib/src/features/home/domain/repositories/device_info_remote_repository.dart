import 'package:device_vitals/src/features/home/data/models/info_params.dart';

abstract class DeviceInfoRemoteRepository {
  Future<String> logStatus({required InfoParams params});
}
