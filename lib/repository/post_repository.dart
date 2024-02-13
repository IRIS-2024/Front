import 'package:iris_flutter/model/post.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'post_repository.g.dart';

@RestApi()
abstract class PostRepository {
  factory PostRepository(Dio dio, {String baseUrl}) = _PostRepository;

  // 실종 정보 조회
  @GET('/posts/{id}')
  Future<Post> getInfo(@Path() int id);

  // 실종 정보 List 조회
  @GET('/posts')
  Future<List<Post>> getInfoList();

  // 실종 정보 작성
  @POST('/posts')
  Future<Post> postInfo(@Body() FormData data);

  // 실종 정보 삭제
  @DELETE('/posts/{id}')
  Future deleteInfo(@Path() int id);
}
