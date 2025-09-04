import 'package:booksearch/domain/usecases/is_flash_available.dart';
import 'package:booksearch/presentation/bloc/sensor_event.dart';
import 'package:booksearch/presentation/bloc/sensor_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/toggle_flash.dart';

class SensorBloc extends Bloc<SensorEvent, SensorState> {
  final IsFlashAvailable isFlashAvailable;
  final ToggleFlash toggleFlash;
  SensorBloc({
    required this.isFlashAvailable,
    required this.toggleFlash,
  }) : super(SensorState.initial()) {
    on<LoadFlashAvailability>((event, emit) async {
      emit(state.copyWith(loading: true, error: null));
      try {
        final available = await isFlashAvailable();
        emit(state.copyWith(loading: false, flashAvailable: available));
      } catch (e) {
        emit(state.copyWith(loading: false, error: e.toString()));
      }
    });

    on<ToggleFlashPressed>((event, emit) async {
      try {
        await toggleFlash(event.enable);
        emit(state.copyWith(loading: false, flashon: event.enable));
      } catch (e) {
        emit(state.copyWith(loading: false, error: e.toString()));
      }
    });
  }
}