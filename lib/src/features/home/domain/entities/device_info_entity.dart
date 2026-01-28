class DeviceInfoEntity {
  final int batteryLevel;
  final bool isCharging;
  final double memoryUsagePercentage;
  final int thermalStatus;

  DeviceInfoEntity({
    required this.batteryLevel,
    required this.isCharging,
    required this.memoryUsagePercentage,
    required this.thermalStatus,
  });

  bool get isBatteryLow => batteryLevel < 20;
  bool get isOverheating => thermalStatus >= 2;
  bool get isBatteryUnknown => batteryLevel == -1;

  String get thermalStatusText {
    switch (thermalStatus) {
      case 0:
        return 'Normal';
      case 1:
        return 'Light';
      case 2:
        return 'Moderate';
      case 3:
        return 'Severe';
      default:
        return 'Unknown';
    }
  }
}