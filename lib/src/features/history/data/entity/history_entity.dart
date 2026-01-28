class HistoryEntity {
  final int battery;
  final double temperature;
  final double usedMemory;
  final String timestamp;

  HistoryEntity({
    required this.battery,
    required this.temperature,
    required this.usedMemory,
    required this.timestamp,
  });

  factory HistoryEntity.fromJson(Map<String, dynamic> json) {
    return HistoryEntity(
      battery: json['battery'],
      temperature: (json['temperature'] as num).toDouble(),
      usedMemory: (json['usedMemory'] as num).toDouble(),
      timestamp: json['timestamp'],
    );
  }
}
