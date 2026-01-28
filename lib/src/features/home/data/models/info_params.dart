class InfoParams {
  final String deviceId;
  final String timestamp;
  final int thermalValue;
  final double batteryLevel;
  final double memoryUsage;

  InfoParams({
    required this.deviceId,
    required this.timestamp,
    required this.thermalValue,
    required this.batteryLevel,
    required this.memoryUsage,
  });

  factory InfoParams.fromJson(Map<String, dynamic> json) {
    return InfoParams(
      deviceId: json['device_id'],
      timestamp: json['timestamp'],
      thermalValue: json['thermal_value'],
      batteryLevel: json['battery_level'],
      memoryUsage: json['memory_usage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'device_id': deviceId,
      'timestamp': timestamp,
      'thermal_value': thermalValue,
      'battery_level': batteryLevel,
      'memory_usage': memoryUsage,
    };
  }
}
