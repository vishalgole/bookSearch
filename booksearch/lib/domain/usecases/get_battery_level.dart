import '../repositories/device_repository.dart';

class GetBatteryLevel {
  final DeviceRepository deviceRepository;

  GetBatteryLevel(this.deviceRepository);

  Future<int> call() async {
    return await deviceRepository.getBatteryLevel();
  }
}