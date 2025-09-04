import 'package:booksearch/core/platform/device_info_channel.dart';
import 'package:booksearch/core/platform/sensor_channel.dart';
import 'package:booksearch/data/repositories/device_repository_impl.dart';
import 'package:booksearch/domain/repositories/device_repository.dart';
import 'package:booksearch/domain/usecases/get_battery_level.dart';
import 'package:booksearch/domain/usecases/is_flash_available.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'core/strings/strings.dart';
import 'data/datasources/book_local_data_source.dart';
import 'data/repositories/book_repository_impl.dart';
import 'data/repositories/sensor_repository_impl.dart';
import 'domain/repositories/book_repository.dart';
import 'domain/repositories/sensor_repository.dart';
import 'domain/usecases/get_device_info.dart';
import 'domain/usecases/toggle_flash.dart';
import 'presentation/bloc/book_bloc.dart';
import 'presentation/bloc/device_bloc.dart';
import 'presentation/bloc/sensor_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton<Dio>(() => Dio());

  // Local data source
  sl.registerLazySingleton<BookLocalDataSource>(
    () => BookLocalDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<BookRepository>(
    () => BookRepositoryImpl(
      dio: sl(),
      localDataSource: sl(),
    ),
  );

  // Bloc
  sl.registerFactory(() => BookBloc(repository: sl()));

  // Create singleton instance for Strings class
   sl.registerLazySingleton<Strings>(() => Strings());

   // Channels
    sl.registerLazySingleton(() => DeviceInfoChannel());
    sl.registerLazySingleton(() => SensorChannel());

    // Repositories
    sl.registerLazySingleton<DeviceRepository>(() => DeviceRepositoryImpl());
    sl.registerLazySingleton<SensorRepository>(() => SensorRepositoryImpl());

    // Usecases
    sl.registerFactory(() => GetBatteryLevel(sl()));
    sl.registerFactory(() => GetDeviceInfo(sl()));
    sl.registerFactory(() => IsFlashAvailable(sl()));
    sl.registerFactory(() => ToggleFlash(sl()));

    // Blocs
    sl.registerFactory(() => DeviceBloc(
      getBatteryLevel: sl(),
      getDeviceInfo: sl(),
    ));
    sl.registerFactory(() => SensorBloc(
      isFlashAvailable: sl(),
      toggleFlash: sl(),
    ));
}


