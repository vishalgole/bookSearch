import 'package:booksearch/domain/repositories/device_repository.dart';

class GetDeviceInfo {
  final DeviceRepository deviceRepository;
  GetDeviceInfo(this.deviceRepository);

  Future<(String deviceName, String osVersion)> call() async {
    final name = await deviceRepository.getDeviceName();
    final version = await deviceRepository.getDeviceOSVersion();
    return (name, version);
  }
}