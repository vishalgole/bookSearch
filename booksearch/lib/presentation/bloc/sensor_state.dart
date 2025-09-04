import 'package:equatable/equatable.dart';

class SensorState extends Equatable {
  final bool loading;
  final bool flashAvailable;
  final bool flashon;
  final String? error;

  const SensorState({
    required this.loading,
    required this.flashAvailable,
    required this.flashon,
    this.error,
  });

  factory SensorState.initial() {
    return SensorState(
      loading: false,
      flashAvailable: false,
      flashon: false,
    );
  }

  SensorState copyWith({
    bool? loading,
    bool? flashAvailable,
    bool? flashon,
    String? error,
  }) {
    return SensorState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      flashAvailable: flashAvailable ?? this.flashAvailable,
      flashon: flashon ?? this.flashon,
    );
  }

  @override
  List<Object?> get props => [flashAvailable, flashon];
}