import '../repositories/sensor_repository.dart';

class IsFlashAvailable {
  final SensorRepository sensorRepository;

  IsFlashAvailable(this.sensorRepository);

  Future<bool> call() async {
    return await sensorRepository.isFlashAvailable();
  }
}