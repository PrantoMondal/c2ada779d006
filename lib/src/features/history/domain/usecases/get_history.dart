import 'package:device_vitals/src/features/history/domain/entities/history_entity.dart';
import 'package:device_vitals/src/features/history/domain/repositories/history_repository.dart';

class GetHistory {
  final HistoryRepository repository;

  GetHistory(this.repository);

  Future<List<HistoryEntity>> call() {
    return repository.getHistory();
  }
}
