import 'package:equatable/equatable.dart';

class SensorEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadFlashAvailability extends SensorEvent {}
class ToggleFlashPressed extends SensorEvent {
  final bool enable;

  ToggleFlashPressed(this.enable);

  @override
  List<Object?> get props => [enable];
}