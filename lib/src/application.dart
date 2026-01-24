import 'package:device_vitals/injection_container.dart';
import 'package:device_vitals/src/core/routes/app_router.dart';
import 'package:device_vitals/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:device_vitals/src/features/home/presentation/view/home_screen.dart';
import 'package:device_vitals/src/features/splash/presentation/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/build_config.dart';
import 'features/splash/presentation/bloc/splash_bloc.dart';

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
        Routes.splash: (_) =>
            BlocProvider(create: (_) => sl<SplashBloc>(), child: SplashScreen()),
        Routes.home: (_) =>
            BlocProvider(create: (_) => sl<HomeBloc>(), child: HomeScreen()),
        // Routes.history: (_) => BlocProvider(
        // create: (_) => sl<HistoryBloc>(),
        // child: const HistoryScreen(),
        // ),
      },
    );
  }
}
