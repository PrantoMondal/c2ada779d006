import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final String timeLabel;
  final double temperature;
  final int battery;
  final String memory;
  final Color backgroundColor;

  const HistoryCard({
    super.key,
    required this.timeLabel,
    required this.temperature,
    required this.battery,
    required this.memory,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          /// Left content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  timeLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                _infoText('Thermal State: ${temperature.toStringAsFixed(1)} °C'),
                _infoText('Battery Level: $battery%'),
                _infoText('Memory Usage: $memory'),
              ],
            ),
          ),

          /// Right icon
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.bar_chart_rounded, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _infoText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Text(text, style: const TextStyle(color: Colors.white70, fontSize: 13)),
    );
  }
}
