import 'package:device_vitals/src/core/base/base_view.dart';
import 'package:device_vitals/src/core/routes/app_router.dart';
import 'package:device_vitals/src/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends BaseView<SplashBloc, SplashState> {
  SplashScreen({super.key});

  @override
  void onError(BuildContext context, String message) {
    logger.d("Splash error: $message");
  }

  @override
  bool isLoading(SplashState state) => state is SplashLoading;

  @override
  String errorMessage(SplashState state) => state is SplashError ? state.message : "";

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
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashSuccess) {
          Navigator.of(context).pushReplacementNamed(Routes.home);
        } else if (state is SplashError) {
          onError(context, state.message);
        }
      },
      child: super.build(context),
    );
  }
}
