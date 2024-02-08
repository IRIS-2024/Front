import 'package:iris_flutter/model/missing_info.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'info_repository.g.dart';

@RestApi()
abstract class InfoRepository {
  factory InfoRepository(Dio dio, {String baseUrl}) = _InfoRepository;

  // 실종 정보 조회
  @GET('/post/{id}')
  Future<MissingInfo> getInfo(@Path() int id);
  
  // 실종 정보 List 조회
  @GET('/post')
  Future<List<MissingInfo>> getInfoList();

  // 실종 정보 작성
  @POST('/post')
  Future<MissingInfo> postInfo();

  // 실종 정보 삭제
  @DELETE('/post/{id}')
  Future deleteInfo(@Path() int id);
}