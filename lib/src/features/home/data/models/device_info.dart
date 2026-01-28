class DeviceInfo {
  final int batteryLevel;
  final bool isCharging;
  final double usedMemoryGB;
  final double totalMemoryGB;
  final double temperatureC;

  DeviceInfo({
    required this.batteryLevel,
    required this.isCharging,
    required this.usedMemoryGB,
    required this.totalMemoryGB,
    required this.temperatureC,
  });

  factory DeviceInfo.fromMap(Map<String, dynamic> map) {
    return DeviceInfo(
      batteryLevel: _parseBatteryLevel(map['batteryLevel']),
      isCharging: map['isCharging'] as bool? ?? false,
      usedMemoryGB: (map['usedMemoryGB'] as num?)?.toDouble() ?? 0.0,
      totalMemoryGB: (map['totalMemoryGB'] as num?)?.toDouble() ?? 0.0,
      temperatureC: (map['temperatureC'] as num?)?.toDouble() ?? 0.0,
    );
  }

  /// Parse battery level which can be int or "unknown" string
  static int _parseBatteryLevel(dynamic value) {
    if (value is int) return value;
    if (value is String && value == "unknown") return -1;
    return 0;
  }

  Map<String, dynamic> toMap() {
    return {
      'batteryLevel': batteryLevel,
      'isCharging': isCharging,
      'usedMemoryGB': usedMemoryGB,
      'totalMemoryGB': totalMemoryGB,
      'temperatureC': temperatureC,
    };
  }
}
