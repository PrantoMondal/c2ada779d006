import 'package:device_vitals/src/core/base/base_view.dart';
import 'package:device_vitals/src/core/constants/app_colors.dart';
import 'package:device_vitals/src/core/routes/app_router.dart';
import 'package:device_vitals/src/core/utils/extensions.dart';
import 'package:device_vitals/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:device_vitals/src/features/home/presentation/widgets/sensor_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends BaseView<HomeBloc, HomeState> {
  HomeScreen({super.key});

  @override
  bool isLoading(HomeState state) => state.isLoading && !state.isRefreshing;

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      title: Text(
        'Device Vitals',
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(color: AppColors.textPrimary),
      ),
      actions: [
        IconButton(
          onPressed: () => Navigator.of(context).pushNamed(Routes.history),
          icon: const Icon(Icons.history, color: AppColors.textPrimary),
        ),
      ],
    );
  }

  @override
  Widget body(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.isFailure && state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: AppColors.errorColor,
              action: SnackBarAction(
                label: 'Retry',
                textColor: Colors.white,
                onPressed: () => context.read<HomeBloc>().add(const LoadHomeData()),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.isFailure && !state.hasData) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline_rounded, size: 64, color: AppColors.errorColor),
                const SizedBox(height: 16),
                Text(
                  state.errorMessage ?? 'Failed to load device info',
                  style: const TextStyle(fontSize: 18, color: AppColors.errorColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => context.read<HomeBloc>().add(const LoadHomeData()),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final vitals = state.deviceData;

        return RefreshIndicator(
          onRefresh: () async {
            context.read<HomeBloc>().add(const LoadHomeData(isRefresh: true));
            await Future.delayed(const Duration(milliseconds: 300));
          },
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  state.lastUpdated != null && state.isSuccess
                      ? 'Last updated: ${state.lastUpdated!.toString().formattedTime}'
                      : '',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SensorInfoCard(
                title: 'Battery',
                status: vitals != null
                    ? (vitals.isCharging ? 'Charging' : 'Not charging')
                    : 'Loading',
                value: vitals != null ? '${vitals.batteryLevel ?? '--'}%' : '--',
                subtitle: "",
                icon: Icons.battery_charging_full_rounded,
                iconColor: Colors.blue,
                cardColor: AppColors.secondary,
              ),

              SensorInfoCard(
                title: 'Memory',
                status: 'Used',
                value: vitals != null
                    ? '${double.tryParse(vitals.memoryUsagePercentage.toString())?.toStringAsFixed(2) ?? '--'} GB'
                          '/ ${double.tryParse(vitals.totalMemoryGB.toString())?.toStringAsFixed(2) ?? '--'} GB'
                    : '--',
                subtitle: "Apps + System",
                icon: Icons.memory_rounded,
                iconColor: Colors.teal,
                cardColor: AppColors.secondary,
              ),

              SensorInfoCard(
                title: 'Thermal',
                status: _getThermalStatus(vitals?.temperatureC),
                value: vitals != null ? '${vitals.temperatureC ?? '--'}°C' : '--',
                subtitle: 'Device temperature',
                icon: Icons.thermostat_rounded,
                iconColor: _getThermalColor(vitals?.temperatureC),
                cardColor: AppColors.secondary,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 0,
                ),
                onPressed: () {},
                child: Text(
                  "Log Status",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: AppColors.backgroundColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getThermalStatus(double? temp) {
    if (temp == null) return "Loading...";
    if (temp < 35) return "Cool";
    if (temp < 42) return "Normal";
    if (temp < 50) return "Warm";
    return "Hot • Caution";
  }

  Color _getThermalColor(double? temp) {
    if (temp == null) return Colors.deepOrange;
    if (temp < 35) return Colors.blue;
    if (temp < 42) return Colors.teal;
    if (temp < 50) return Colors.orange;
    return Colors.redAccent;
  }
}
