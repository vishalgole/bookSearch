import '../repositories/sensor_repository.dart';

class ToggleFlash {
  final SensorRepository sensorRepository;

  ToggleFlash(this.sensorRepository);

  Future<void> call(bool enable) async {
    final isAvailable = await sensorRepository.isFlashAvailable();
    if (!isAvailable) {
      throw Exception('Flash not available on this device');
    }
    await sensorRepository.toggleFlash(enable);
  }
}