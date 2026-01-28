import 'package:device_vitals/src/features/history/domain/entities/analytics_data_entity.dart';
import 'package:device_vitals/src/features/history/domain/entities/history_entity.dart';

abstract class HistoryRepository {
  Future<List<HistoryEntity>> getHistory();

  Future<AnalyticsDataEntity> getAnalytics({required String deviceId});
}
