
abstract class DeviceRepository {
  Future<int> getBatteryLevel();
  Future<String> getDeviceName();
  Future<String> getDeviceOSVersion();
}