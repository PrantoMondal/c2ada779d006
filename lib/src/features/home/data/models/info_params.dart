class InfoParams {
  final String deviceId;
  final String timestamp;
  final double thermalValue;
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
      deviceId: json['deviceId'],
      timestamp: json['timestamp'],
      thermalValue: json['thermalValue'],
      batteryLevel: json['batteryLevel'],
      memoryUsage: json['memoryUsage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'timestamp': timestamp,
      'thermalValue': thermalValue,
      'batteryLevel': batteryLevel,
      'memoryUsage': memoryUsage,
    };
  }
}
