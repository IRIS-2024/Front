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
      print('[Error AccessToken Expired]: reissue Token');

      // 토큰 재발급
      final token = await reissueToken();
      if (token.isNotEmpty) {
        // 토큰 재발급 성공-> 새로운 토큰으로 API request 재진행
        await _retryRequest(err.requestOptions, token);
      } else {
        print('[Error 토큰 재발급 실패]: $err');
      }
    } else if (err.response?.statusCode == 403) {
      print('[Error 403]: 토큰이 없음 $err');
    }
    super.onError(err, handler);
  }

  // 토큰 재발급
  Future<String> reissueToken() async {
    try {
      final dio = createDioWithoutToken();
      LoginRepository loginRepository = LoginRepository(dio);

      final RefreshToken = await getRT();

      final resp = await loginRepository.getRefreshToken(RefreshToken);
      print('new AccessToken Token: ${resp.accessToken}');
      final AT = resp.accessToken;
      final RT = resp.refreshToken;

      // storage 에 새로운 token 저장
      await tokenStorage.write(key: 'AccessToken', value: AT);
      await tokenStorage.write(key: 'RefreshToken', value: RT);

      return AT;
    } on DioException catch (e) {
      print('print reissueToken Error: $e');

      // 401 에러-> refreshToken 유효하지 않음. 재로그인
      if (e.response?.statusCode == 401) {
        print('print refreshToken Expired: Logout');

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
