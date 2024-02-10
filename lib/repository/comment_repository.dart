import 'package:iris_flutter/model/comment.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'comment_repository.g.dart';

@RestApi()
abstract class CommentRepository {
  factory CommentRepository(Dio dio, {String baseUrl}) = _CommentRepository;

  // 제보 댓글 List 조회
  @GET('/comments/{pid}')
  Future<List<Comment>> getCommentList(@Path() int pid);

  // 내가 작성한 제보글 조회
  // @GET('/my-comments')
  // Future

  // 제보 댓글 작성
  @POST('/comments/{pid}')
  Future postComment(@Path() int pid);
  
  // 제보 댓글 삭제
  @DELETE('/comments/{cid}')
  Future deleteComment(@Path() int cid);
}