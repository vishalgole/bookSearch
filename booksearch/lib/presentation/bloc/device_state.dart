import 'package:equatable/equatable.dart';

import '../../core/strings/strings.dart';

class DeviceState extends Equatable {
 final bool loading;
 final int batteryLevel;
 final String deviceName;
 final String deviceOSVersion;
 final String? error;

  DeviceState({
    required this.loading,
    required this.batteryLevel,
    required this.deviceName,
    required this.deviceOSVersion,
    this.error,
  });

  factory DeviceState.initial() {
    return DeviceState(
      loading: false,
      batteryLevel: -1,
      deviceName: Strings.unknown,
      deviceOSVersion: Strings.unknown,
      error: null,
    );
  }

  DeviceState copyWith({
    bool? loading,
    int? batteryLevel,
    String? deviceName,
    String? deviceOSVersion,
    String? error,
  }) {
    return DeviceState(
      loading: loading ?? this.loading,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      deviceName: deviceName ?? this.deviceName,
      deviceOSVersion: deviceOSVersion ?? this.deviceOSVersion,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [loading, batteryLevel, deviceName, deviceOSVersion, error];
}
