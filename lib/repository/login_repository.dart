import 'package:iris_flutter/model/login_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'login_repository.g.dart';

@RestApi()
abstract class LoginRepository {
  factory LoginRepository(Dio dio, {String baseUrl}) = _LoginRepository;

  @POST('/auth/logout')
  Future postLogout();

  @GET('/auth/refresh')
  Future<LoginResp> getRefresh(
      @Header('refreshToken') String refreshToken);

  @GET('/auth/google/callback')
  Future<LoginResp> getLogin(@Query('code') String code);
}
