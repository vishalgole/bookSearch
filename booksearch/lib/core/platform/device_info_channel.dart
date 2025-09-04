import 'package:flutter/services.dart';

import '../strings/strings.dart';

class DeviceInfoChannel {
  static const _channel = MethodChannel('com.example.device/info');

  Future<int> getBatteryLevel() async {
    final int batteryLevel = await _channel.invokeMethod('getBatteryLevel');
    return batteryLevel ?? -1;
  }
  Future<String> getDeviceName() async {
    final String deviceName = await _channel.invokeMethod('getDeviceName');
    return deviceName ?? Strings.unknown;
  }

  Future<String> getDeviceOSVersion() async {
    final String osVersion = await _channel.invokeMethod('getDeviceOSVersion');
    return osVersion ?? Strings.unknown;
  } 
}