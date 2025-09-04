abstract class SensorRepository {
  Future<bool> isFlashAvailable();
  Future<void> toggleFlash(bool enable);
}