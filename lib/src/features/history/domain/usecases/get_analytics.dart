import 'package:device_vitals/src/features/history/domain/entities/analytics_data_entity.dart';
import 'package:device_vitals/src/features/history/domain/repositories/history_repository.dart';

class GetAnalytics {
  final HistoryRepository repository;

  GetAnalytics(this.repository);

  Future<AnalyticsDataEntity> call({required String deviceId}) {
    return repository.getAnalytics(deviceId: deviceId);
  }
}
