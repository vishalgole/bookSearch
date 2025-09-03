import 'package:dio/dio.dart';

import '../strings/strings.dart';

class DioClient {
  final Dio dio;
  DioClient(this.dio){
    dio.options.baseUrl = Strings.baseURL;
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
  }
}