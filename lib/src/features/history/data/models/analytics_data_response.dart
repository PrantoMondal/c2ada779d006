class AnalyticsDataResponse {
  final String deviceId;
  final RollingAverage rollingAverage;
  final int totalRecords;
  final DateTime lastUpdated;

  AnalyticsDataResponse({
    required this.deviceId,
    required this.rollingAverage,
    required this.totalRecords,
    required this.lastUpdated,
  });

  factory AnalyticsDataResponse.fromJson(Map<String, dynamic> json) {
    return AnalyticsDataResponse(
      deviceId: json['device_id'] as String,
      rollingAverage: RollingAverage.fromJson(
        json['rolling_average'] as Map<String, dynamic>,
      ),
      totalRecords: json['total_records'] as int,
      lastUpdated: DateTime.parse(json['last_updated'] as String),
    );
  }
}

class RollingAverage {
  final double thermal;
  final double battery;
  final double memory;

  RollingAverage({required this.thermal, required this.battery, required this.memory});

  factory RollingAverage.fromJson(Map<String, dynamic> json) {
    return RollingAverage(
      thermal: double.parse(json['thermal'].toString()),
      battery: double.parse(json['battery'].toString()),
      memory: double.parse(json['memory'].toString()),
    );
  }
}
