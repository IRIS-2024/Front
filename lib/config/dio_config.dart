import 'package:dio/dio.dart';

Dio createDio() {
  final options = BaseOptions(
    baseUrl: '#TODO: baseUrl',
  );
  final dio = Dio(options);

  // JWT 헤더 추가 및 토큰 재발급 관련 처리
  // dio.interceptors.add(TokenInterceptor(dio: dio));
  return dio;
}


Dio createDioWithoutToken() {
  final options = BaseOptions(
    baseUrl: '#TODO: baseUrl',
  );
  final dio = Dio(options);

  return dio;
}