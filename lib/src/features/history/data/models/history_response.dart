class HistoryResponse {
  final List<HistoryData> histories;

  HistoryResponse({required this.histories});

  factory HistoryResponse.fromJson(List<dynamic> jsonList) {
    return HistoryResponse(
      histories: jsonList.map((e) => HistoryData.fromJson(e)).toList(),
    );
  }

  List<Map<String, dynamic>> toJson() {
    return histories.map((e) => e.toJson()).toList();
  }
}

class HistoryData {
  final int id;
  final String deviceId;
  final String timestamp;
  final double thermalValue;
  final int batteryLevel;
  final double memoryUsage;

  HistoryData({
    required this.id,
    required this.deviceId,
    required this.timestamp,
    required this.thermalValue,
    required this.batteryLevel,
    required this.memoryUsage,
  });

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    return HistoryData(
      id: json['id'],
      deviceId: json['device_id'],
      timestamp: json['timestamp'],
      thermalValue: (json['thermal_value'] as num).toDouble(),
      batteryLevel: json['battery_level'],
      memoryUsage: (json['memory_usage'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'device_id': deviceId,
    'timestamp': timestamp,
    'thermal_value': thermalValue,
    'battery_level': batteryLevel,
    'memory_usage': memoryUsage,
  };
}
