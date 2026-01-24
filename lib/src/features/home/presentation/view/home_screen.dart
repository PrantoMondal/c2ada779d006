import 'package:device_vitals/src/core/base/base_view.dart';
import 'package:device_vitals/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:device_vitals/src/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends BaseView<HomeBloc, HomeState> {
  HomeScreen({super.key});

  @override
  void onError(BuildContext context, String message) {
    logger.d("Home error: $message");
  }

  @override
  bool isLoading(HomeState state) => state is HomeLoading;

  @override
  String errorMessage(HomeState state) => state is HomeError ? state.message : "";

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Text(
        "Device Vitals",
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeSuccess) {
          // // Navigate to Home after splash
          // Navigator.of(
          //   context,
          // ).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
        } else if (state is HomeError) {
          onError(context, state.message);
        }
      },
      child: super.build(context),
    );
  }
}
