import 'package:device_vitals/src/features/history/domain/model/history.dart';

abstract class HistoryRepository {
  Future<List<History>> getHistory();
}