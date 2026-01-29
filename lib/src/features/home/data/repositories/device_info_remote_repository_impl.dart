import 'package:device_vitals/src/features/home/data/datasources/device_info_remote_datasource.dart';
import 'package:device_vitals/src/features/home/data/models/info_params.dart';
import 'package:device_vitals/src/features/home/domain/repositories/device_info_remote_repository.dart';

class DeviceInfoRemoteRepositoryImpl implements DeviceInfoRemoteRepository {
  final DeviceInfoRemoteDatasource remoteDataSource;

  DeviceInfoRemoteRepositoryImpl(this.remoteDataSource);

  @override
  Future<String> logStatus({required InfoParams params}) async {
    final response = await remoteDataSource.logStatus(params: params);
    return response;
  }
}
