import 'package:device_vitals/src/features/home/domain/repositories/device_info_repository.dart';
import 'package:flutter/services.dart';

class DeviceInfoDataSource implements DeviceInfoRepository {
  static const MethodChannel _channel = MethodChannel('com.yourdomain.dev/device-info');

  @override
  Future<Map<String, dynamic>> getAllInfo() async {
    try {
      final result = await _channel.invokeMapMethod<String, dynamic>('getDeviceVitals');
      return result ?? {};
    } on PlatformException catch (e) {
      throw Exception('Platform error: ${e.message}');
    }
  }

  @override
  Future<int?> getBatteryInfo() async {
    try {
      return await _channel.invokeMethod<int>('getBatteryLevel');
    } on PlatformException {
      return null;
    }
  }

  @override
  Future<double?> getMemoryInfo() async {
    try {
      return await _channel.invokeMethod<double>('getUsedMemory');
    } on PlatformException {
      return null;
    }
  }

  @override
  Future<double?> getThermalInfo() async {
    try {
      return await _channel.invokeMethod<double>('getDeviceTemperature');
    } on PlatformException {
      return null;
    }
  }
}
