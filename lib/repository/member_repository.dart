import 'package:iris_flutter/model/noti_setting.dart';
import 'package:iris_flutter/model/user.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'member_repository.g.dart';

@RestApi()
abstract class MemberRepository {
  factory MemberRepository(Dio dio, {String baseUrl}) = _MemberRepository;

  @PATCH('/members/push')
  Future patchPush(@Body() NotiSetting notiSetting);

  @GET('/members/push/region')
  Future<String> getPushRegion();

  @GET('/member')
  Future<User> getUserInfo();
}