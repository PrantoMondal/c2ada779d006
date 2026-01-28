import 'package:device_vitals/src/features/history/data/datasources/history_remote_datasource.dart';
import 'package:device_vitals/src/features/history/domain/entities/history_entity.dart';
import 'package:device_vitals/src/features/history/domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDataSource remoteDataSource;

  HistoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<HistoryEntity>> getHistory() async {
    final response = await remoteDataSource.fetchHistory();

    return response.histories.map((model) {
      return HistoryEntity(
        id: model.id,
        deviceId: model.deviceId,
        battery: model.batteryLevel,
        temperature: model.thermalValue,
        usedMemory: model.memoryUsage,
        timestamp: model.timestamp,
      );
    }).toList();
  }
}
