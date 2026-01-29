import 'package:device_vitals/src/core/base/base_view.dart';
import 'package:device_vitals/src/core/constants/app_colors.dart';
import 'package:device_vitals/src/core/constants/app_values.dart';
import 'package:device_vitals/src/core/utils/extensions.dart';
import 'package:device_vitals/src/features/history/presentation/bloc/history_bloc.dart';
import 'package:device_vitals/src/features/history/presentation/widgets/history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryScreen extends BaseView<HistoryBloc, HistoryState> {
  HistoryScreen({super.key});

  @override
  bool isLoading(HistoryState state) => state.isLoading;

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      title: Text('History', style: TextStyle(color: AppColors.textPrimary)),
      backgroundColor: AppColors.primary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(

      builder: (context, state) {
        return state.items.isEmpty? const Center(
          child: Text('No history found'),
        ):Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (_, index) {
                  final item = state.items[index];
                  return HistoryCard(
                    battery: item.battery,
                    memory: item.usedMemory.toString(),
                    temperature: double.parse(item.temperature.toStringAsFixed(1)),
                    time: item.timestamp.formattedTime,
                  );
                },
              ),
            ),
            Divider(),
            state.analytics != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: AppValues.gapSmall),
                        child: const Text(
                          'Analytics',
                          style: TextStyle(
                            color: AppColors.shadowColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildAnalyticsRow(
                              label: 'Battery',
                              value:
                                  '${state.analytics!.rollingAverage.battery.toStringAsFixed(1)}%',
                              icon: Icons.battery_charging_full,
                            ),
                            const SizedBox(height: 12),
                            _buildAnalyticsRow(
                              label: 'Memory',
                              value:
                                  '${state.analytics!.rollingAverage.memory.toStringAsFixed(1)}%',
                              icon: Icons.memory,
                            ),
                            const SizedBox(height: 12),
                            _buildAnalyticsRow(
                              label: 'Thermal',
                              value: _getThermalText(
                                state.analytics!.rollingAverage.thermal.toInt(),
                              ),
                              icon: Icons.thermostat,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : SizedBox(),
          ],
        );
      },
    );
  }

  Widget _buildAnalyticsRow({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textPrimary, size: 20),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(color: AppColors.textPrimary.withOpacity(0.7), fontSize: 14),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _getThermalText(int status) {
    switch (status) {
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
