class DeviceInfoEntity {
  final int batteryLevel;
  final bool isCharging;
  final double usedMemoryGB;
  final double totalMemoryGB;
  final double temperatureC;

  DeviceInfoEntity({
    required this.batteryLevel,
    required this.isCharging,
    required this.usedMemoryGB,
    required this.totalMemoryGB,
    required this.temperatureC,
  });

  double get availableMemoryGB => totalMemoryGB - usedMemoryGB;
  double get memoryUsagePercentage =>
      totalMemoryGB > 0 ? (usedMemoryGB / totalMemoryGB) * 100 : 0.0;

  bool get isBatteryLow => batteryLevel < 20;
  bool get isOverheating => temperatureC > 40.0;
  bool get isBatteryUnknown => batteryLevel == -1;
}
