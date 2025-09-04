
import 'package:bloc_test/bloc_test.dart';
import 'package:booksearch/domain/usecases/is_flash_available.dart';
import 'package:booksearch/domain/usecases/toggle_flash.dart';
import 'package:booksearch/presentation/bloc/sensor_bloc.dart';
import 'package:booksearch/presentation/bloc/sensor_event.dart';
import 'package:booksearch/presentation/bloc/sensor_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIsFlashAvailable extends Mock implements IsFlashAvailable {
}  
class MockToggleFlash extends Mock implements ToggleFlash {
}

void main() {
  late MockIsFlashAvailable mockIsFlashAvailable;
  late MockToggleFlash mockToggleFlash;
  late SensorBloc sensorBloc;

  setUp((){
    mockIsFlashAvailable = MockIsFlashAvailable();
    mockToggleFlash = MockToggleFlash();
    sensorBloc = SensorBloc(
      isFlashAvailable: mockIsFlashAvailable,
      toggleFlash: mockToggleFlash,
    );
  });

  tearDown((){
    sensorBloc.close();
  });

  blocTest<SensorBloc, SensorState>(
  'emits [loading:true, flashon:false] then [loading:false, flashon:true] when ToggleFlashPressed is added',
  build: () {
    when(() => mockToggleFlash.call(true)).thenAnswer((_) async {});
    return sensorBloc;
  },
  act: (bloc) => bloc.add(ToggleFlashPressed(true)),
  expect: () => [
    sensorBloc.state.copyWith(loading: false, flashon: true), // second emit
  ],
  verify: (_) {
    verify(() => mockToggleFlash.call(true)).called(1);
  },
);

  blocTest<SensorBloc, SensorState>(
  'emits [loading:true, flashAvailable:false] then [loading:false, flashAvailable:true] when LoadFlashAvailability is added',
  build: () {
    when(() => mockIsFlashAvailable.call()).thenAnswer((_) async => true);
    return sensorBloc;
  },
  act: (bloc) => bloc.add(LoadFlashAvailability()),
  expect: () => [
    // first state: loading started, flashAvailable still false
    SensorState(loading: true, flashAvailable: false, flashon: false, error: null),

    // second state: loading done, flashAvailable true
    SensorState(loading: false, flashAvailable: true, flashon: false, error: null),
  ],
  verify: (_) {
    verify(() => mockIsFlashAvailable.call()).called(1);
  },
);


}