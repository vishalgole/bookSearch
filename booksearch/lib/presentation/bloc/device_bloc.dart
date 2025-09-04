import 'package:booksearch/domain/usecases/get_battery_level.dart';
import 'package:booksearch/domain/usecases/get_device_info.dart';
import 'package:booksearch/presentation/bloc/device_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'device_event.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final GetBatteryLevel getBatteryLevel;
  final GetDeviceInfo getDeviceInfo;
  DeviceBloc({
    required this.getBatteryLevel,
    required this.getDeviceInfo,
  }) : super(DeviceState.initial()) {
    on<LoadDeviceDashboard>((event, emit) async {
      emit(state.copyWith(loading: true, error: null));

      await Future.delayed(const Duration(seconds: 2));

      try {
        final batteryLevel = await getBatteryLevel();
        final (deviceName, osVersion) = await getDeviceInfo();
        emit(state.copyWith(
          loading: false,
          batteryLevel: batteryLevel,
          deviceName: deviceName,
          deviceOSVersion: osVersion,
        ));
      } catch (e) {
        emit(state.copyWith(loading: false, error: e.toString()));
      }
    });
  }
}