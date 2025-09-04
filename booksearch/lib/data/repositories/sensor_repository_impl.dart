import 'package:flutter/services.dart';
import 'package:booksearch/domain/repositories/sensor_repository.dart';

class SensorRepositoryImpl implements SensorRepository {
  static const _channel = MethodChannel("sensorChannel");

  @override
  Future<bool> isFlashAvailable() async {
    try {
      final result = await _channel.invokeMethod<bool>("isFlashAvailable");
      return result ?? false;
    } catch (e) {
      throw Exception("Failed to check flash availability: $e");
    }
  }

  @override
  Future<void> toggleFlash(bool enable) async {
    try {
      await _channel.invokeMethod("toggleFlash", enable);
    } catch (e) {
      throw Exception("Failed to toggle flash: $e");
    }
  }
}
