import 'package:flutter/services.dart';

class SensorChannel {
  static const _channel = MethodChannel('com.example.device/sensor');

  Future<bool> isFlashAvailable() async {
    final bool isAvailable = await _channel.invokeMethod('isFlashAvailable');
    return isAvailable ?? false;
  }

  Future<void> toggleFlash(bool enable) async {
    await _channel.invokeMethod('toggleFlash', {'enable': enable});
  }
}