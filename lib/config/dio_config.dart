import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/hidden_config.dart';
import 'package:iris_flutter/repository/login_repository.dart';
import 'package:iris_flutter/utils/user_profile_utils.dart';
import 'package:iris_flutter/view/controller/login/login_controller.dart';

Dio createDio() {
  final options = BaseOptions(
    baseUrl: HiddenConfig.baseUrl,
  );
  final dio = Dio(options);

  // JWT 헤더 추가 및 토큰 재발급 관련 처리
  dio.interceptors.add(TokenInterceptor(dio: dio));

  // request curl 보는 Interceptor - TODO 개발 시에만 사용하세요
  dio.interceptors.add(LogInterceptor(dio: dio));
  return dio;
}

Dio createDioWithoutToken() {
  final options = BaseOptions(
    baseUrl: HiddenConfig.baseUrl,
  );
  final dio = Dio(options);

  return dio;
}

class TokenInterceptor extends Interceptor {
  final Dio dio;

  TokenInterceptor({required this.dio});

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 토큰 읽어와서 헤더에 넣어주기
    final token = await getAT();
    options.headers['Authorization'] = 'Bearer $token';

    super.onRequest(options, handler);
  }

  @override
  Future onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // 401 에러-> AccessToken 재발급
    if (err.response?.statusCode == 401) {
      log('[Error 401 인증 실패]: reissue Token');
      // 토큰 재발급
      final token = await reissueToken();
      if (token.isNotEmpty) {
        // 토큰 재발급 성공-> 새로운 토큰으로 API request 재진행
        await _retryRequest(err.requestOptions, token);
      } else {
        log('[Error reissue RefreshToken Fail]: $err');
      }

    } else if (err.response?.statusCode == 403) {
      log('[Error 403]: 인증 헤더 누락 $err');
    } else {
      log('[Error]: ${err.response ?? err}');
    }
    super.onError(err, handler);
  }

  // 토큰 재발급
  Future<String> reissueToken() async {
    try {
      final dio = createDioWithoutToken();
      LoginRepository loginRepository = LoginRepository(dio);

      final refreshToken = await getRT();

      final resp = await loginRepository.getRefreshToken(refreshToken);
      log('new AccessToken Token: ${resp.accessToken.toString()}');

      // storage 에 새로운 token 저장
      await tokenStorage.write(
          key: 'AccessToken', value: resp.accessToken.toString());
      await tokenStorage.write(
          key: 'RefreshToken', value: resp.refreshToken.toString());
      return resp.accessToken.toString();
    } on DioException catch (e) {
      log('reissueToken Error: $e');

      // 401 에러-> refreshToken 유효하지 않음. 재로그인
      if (e.response?.statusCode == 401) {
        log('refreshToken Expired: Logout');

        Get.put(LoginController());
        Get.find<LoginController>().handleLogout();
      }
      return '';
    }
  }

  Future<Response<dynamic>> _retryRequest(
      RequestOptions requestOptions, String token) async {
    final options = Options(
      method: requestOptions.method,
      headers: {'Authorization': 'Bearer $token'},
    );
    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}

class LogInterceptor extends Interceptor {
  final Dio dio;
  LogInterceptor({required this.dio});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('Curl: ${getCurlCommand(options)}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    List<String> respLog = ['Response\n'];

    if (response.data is Map) {
      response.data.forEach((key, value) {
        respLog.add('resp map \'$key=$value\n');
      });
    } else {
      respLog.add(response.toString());
    }
    log(respLog.toString());
    super.onResponse(response, handler);
  }
}

String getCurlCommand(RequestOptions options) {
  List<String> commandParts = ['curl'];

  // URL
  commandParts.add('\'${options.uri}\n');

  // Headers
  options.headers.forEach((key, value) {
    commandParts.add('-H \'$key: $value\n');
  });

  options.queryParameters.forEach((key, value) {
    commandParts.add('-Query \'$key: $value\n');
  });

  // Request Method
  commandParts.add('-X ${options.method}\n');

  // Request Body
  if (options.data != null) {
    if (options.data is String) {
      commandParts.add('-d \'${options.data}\n');
    } else if (options.data is Map) {
      options.data.forEach((key, value) {
        commandParts.add('-d \'$key=$value\n');
      });
    } else if (options.data is FormData) {
      options.data.fields.forEach((entry) {
        commandParts.add('-F \'${entry.key}=${entry.value}\'\n');
      });
      options.data.files.forEach((entry) {
        commandParts.add('-Files \'${entry.key}=${entry.value.filename}\'\n');
      });
    } else {
      commandParts.add('-d \'${options.data.toString()}\n');
    }
  }

  return commandParts.join(' ');
}