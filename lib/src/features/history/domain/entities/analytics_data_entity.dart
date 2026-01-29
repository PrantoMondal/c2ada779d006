class AnalyticsDataEntity {
  final String deviceId;
  final RollingAverageEntity rollingAverage;
  final int totalRecords;
  final DateTime lastUpdated;

  AnalyticsDataEntity({
    required this.deviceId,
    required this.rollingAverage,
    required this.totalRecords,
    required this.lastUpdated,
  });
}

class RollingAverageEntity {
  final double thermal;
  final double battery;
  final double memory;

  RollingAverageEntity({
    required this.thermal,
    required this.battery,
    required this.memory,
  });
}
