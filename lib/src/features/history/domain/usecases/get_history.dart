import 'package:device_vitals/src/features/history/domain/model/history.dart';
import 'package:device_vitals/src/features/history/domain/repository/history_repository.dart';

class GetHistory {
  final HistoryRepository repository;

  GetHistory(this.repository);

  Future<List<History>> call() {
    return repository.getHistory();
  }
}