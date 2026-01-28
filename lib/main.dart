import 'package:device_vitals/src/application.dart';
import 'package:device_vitals/src/core/config/env_config.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'injection_container.dart';
import 'src/core/config/build_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  final envConfig = EnvConfig(
    appName: packageInfo.appName,
    appVersion: packageInfo.version,
    packageName: packageInfo.packageName,
    baseUrl: "http://192.168.0.102:3000/api",
  );

  BuildConfig.instantiate(config: envConfig);
  await setupDependencies();
  runApp(MediaQuery.withNoTextScaling(child: const Application()));
}
