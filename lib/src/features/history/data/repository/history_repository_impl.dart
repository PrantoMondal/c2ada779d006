import 'package:device_vitals/src/features/history/data/datasource/history_remote_datasource.dart';
import 'package:device_vitals/src/features/history/data/entity/history_entity.dart';
import 'package:device_vitals/src/features/history/domain/model/history.dart';
import 'package:device_vitals/src/features/history/domain/repository/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDataSource remoteDataSource;

  HistoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<History>> getHistory() async {
    final response = await remoteDataSource.fetchHistory();

    final entities = response.map((e) => HistoryEntity.fromJson(e)).toList();

    return entities
        .map((e) => History(battery: e.battery, temperature: e.temperature, usedMemory: e.usedMemory, timestamp: DateTime.parse(e.timestamp)))
        .toList();
  }
}
