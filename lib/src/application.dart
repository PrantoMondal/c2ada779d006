import 'package:device_vitals/src/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/config/build_config.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    final config = BuildConfig.instance.envConfig;

    return MaterialApp(
      title: config.appName,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      routes: {
        Routes.splash: (_) => const SplashScreen(),
        Routes.home: (_) => const HomeScreen(),
        Routes.history: (_) => const HistoryScreen(),
      },
    );
  }
}
