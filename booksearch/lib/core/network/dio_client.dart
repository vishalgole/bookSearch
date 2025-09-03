import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;
  DioClient(this.dio){
    dio.options.baseUrl = 'https://openlibrary.org';
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
  }
}