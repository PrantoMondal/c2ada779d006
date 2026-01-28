import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceUtils {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  static Future<String> getDeviceId() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        return androidInfo.id;
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        return iosInfo.identifierForVendor ?? 'unknown';
      } else {
        return 'unsupported_platform';
      }
    } catch (e) {
      return 'error';
    }
  }
}
