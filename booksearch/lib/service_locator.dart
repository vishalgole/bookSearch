import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'core/strings/strings.dart';
import 'data/datasources/book_local_data_source.dart';
import 'data/repositories/book_repository_impl.dart';
import 'domain/repositories/book_repository.dart';
import 'presentation/bloc/book_bloc.dart';

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
}
