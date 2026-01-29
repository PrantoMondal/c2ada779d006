import 'package:device_vitals/src/core/constants/app_strings.dart';
import 'package:device_vitals/src/features/home/data/models/device_info.dart';
import 'package:flutter/services.dart';

class DeviceInfoDataSource {
  static const MethodChannel _channel = MethodChannel(AppStrings.deviceInfoChannelName);

  Future<DeviceInfo> getAllInfo() async {
    try {
      final result = await _channel.invokeMapMethod<String, dynamic>('getDeviceVitals');
      if (result == null) {
        throw Exception('No data received from platform channel');
      }
      return DeviceInfo.fromMap(result);
    } on PlatformException catch (e) {
      throw Exception('Platform error: ${e.message}');
    }
  }
}
