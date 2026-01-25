import 'package:device_vitals/src/core/base/base_view.dart';
import 'package:device_vitals/src/core/constants/app_colors.dart';
import 'package:device_vitals/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:device_vitals/src/features/home/presentation/widgets/sensor_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends BaseView<HomeBloc, HomeState> {
  HomeScreen({super.key});

  @override
  bool isLoading(HomeState state) => state is HomeLoading;

  // @override
  // PreferredSizeWidget? appBar(BuildContext context) {
  //   return super.appBar(context);
  // }

  @override
  Widget body(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeSuccess) {
          onError(context, "message");
        } else if (state is HomeError) {
          onError(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is HomeError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: AppColors.errorColor),
            ),
          );
        }
        return ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            // Battery card
            SensorInfoCard(
              title: "Battery",
              value: "78",
              unit: "%",
              subtitle: "Charging • Est. 5h left",
              icon: Icon(
                Icons.battery_charging_full_rounded,
                size: 32,
                color: Colors.white,
              ),
              backgroundColor: Colors.blue,
              textColor: Colors.white,
            ),

            // Memory card
            SensorInfoCard(
              title: "Memory",
              value: "3.2",
              unit: "/ 8 GB",
              subtitle: "Used • Apps + System",
              icon: Icon(Icons.memory_rounded, size: 32, color: Colors.white),
              backgroundColor: Colors.teal,
            ),

            // Thermal card
            SensorInfoCard(
              title: "Thermal",
              value: "38.4",
              unit: "°C",
              subtitle: "Moderate",
              icon: Icon(Icons.thermostat_rounded, size: 32, color: Colors.white),
              backgroundColor: Colors.deepOrange,
            ),
          ],
        );
      },
    );
  }
}
