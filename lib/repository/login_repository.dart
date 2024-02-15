import 'package:iris_flutter/model/user.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'login_repository.g.dart';

@RestApi()
abstract class LoginRepository {
  factory LoginRepository(Dio dio, {String baseUrl}) = _LoginRepository;

  @GET('/auth/refresh')
  Future<User> getRefreshToken(@Query('refreshToken') String refreshToken);

  @GET('/auth/google/callback')
  Future<User> getLogin(@Query('code') String code);
}
