import 'package:dio/dio.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio()
      ..options = BaseOptions(
        baseUrl: 'YOUR_API_BASE_URL',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      )
      ..interceptors.addAll([
        // Add your interceptors here
      ]);
  }

  Dio get dio => _dio;
}
