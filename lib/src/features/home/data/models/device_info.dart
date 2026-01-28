class DeviceInfo {
  final int batteryLevel;
  final bool isCharging;
  final double memoryUsagePercentage;
  final int thermalStatus;

  DeviceInfo({
    required this.batteryLevel,
    required this.isCharging,
    required this.memoryUsagePercentage,
    required this.thermalStatus,
  });

  factory DeviceInfo.fromMap(Map<String, dynamic> map) {
    return DeviceInfo(
      batteryLevel: _parseBatteryLevel(map['batteryLevel']),
      isCharging: map['isCharging'] as bool? ?? false,
      memoryUsagePercentage: (map['memoryUsagePercentage'] as num?)?.toDouble() ?? 0.0,
      thermalStatus: map['thermalStatus'] as int? ?? 0,
    );
  }

  static int _parseBatteryLevel(dynamic value) {
    if (value is int) return value;
    if (value is String && value == "unknown") return -1;
    return 0;
  }

  Map<String, dynamic> toMap() {
    return {
      'batteryLevel': batteryLevel,
      'isCharging': isCharging,
      'memoryUsagePercentage': memoryUsagePercentage,
      'thermalStatus': thermalStatus,
    };
  }
}
