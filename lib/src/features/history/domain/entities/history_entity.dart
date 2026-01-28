class HistoryEntity {
  final int id;
  final String deviceId;
  final int battery;
  final double temperature;
  final double usedMemory;
  final String timestamp;

  HistoryEntity({
    required this.id,
    required this.deviceId,
    required this.battery,
    required this.temperature,
    required this.usedMemory,
    required this.timestamp,
  });
}
