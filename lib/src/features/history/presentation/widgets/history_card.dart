import 'package:device_vitals/src/core/constants/app_colors.dart';
import 'package:device_vitals/src/core/constants/app_values.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final String time;
  final double temperature;
  final int battery;
  final String memory;

  const HistoryCard({
    super.key,
    required this.time,
    required this.temperature,
    required this.battery,
    required this.memory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppValues.gap),
      padding: const EdgeInsets.all(AppValues.gapSmall),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppValues.radiusSmall),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            time,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: AppValues.gapSmall),
          const Divider(height: 1),

          const SizedBox(height: AppValues.gapSmall),

          _infoRow(
            icon: Icons.thermostat_outlined,
            label: 'Thermal State',
            value: temperature.toStringAsFixed(0),
          ),
          _infoRow(
            icon: Icons.battery_5_bar_outlined,
            label: 'Battery Level',
            value: '$battery%',
          ),
          _infoRow(icon: Icons.memory_outlined, label: 'Memory Usage', value: memory),
        ],
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
