import 'package:get/get.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/model/comment.dart';
import 'package:iris_flutter/model/post.dart';
import 'package:iris_flutter/repository/comment_repository.dart';
import 'package:iris_flutter/repository/post_repository.dart';

class PostController extends GetxController {
  // 하나의 실종 정보 글에 대한 정보
  Rx<Post> post = Post(
    pid: 0,
    name: "",
    gender: true,
    age: 0,
    address: "",
    latitude: 0.0,
    longitude: 0.0,
    clothes: "빨간 색 상의에 청바지를 입었어요. 파랑색 캡모자를 썼어요.",
    bookmarked: false,
    images: [""],
    genImage: '',
    disappearedAt: '',
    createdAt: '',
    updatedAt: '',
    author: false,
    genRepresent: true,
  ).obs;

  // 해당 실종 정보 글에 달린 제보 댓글들
  RxList<Comment> commentList = <Comment>[].obs;
  RxInt currentIndex = 0.obs; // 댓글 별 이미지 슬라이드

  Rx<Comment> targetComment = Comment(
          cid: 0,
          address: '임시 댓글',
          latitude: 0.0,
          longitude: 0.0,
          images: [''],
          discoveredAt: '2024-02-09T07:11:42.069Z',
          createdAt: '2024-02-09T07:11:42.069Z')
      .obs;
  RxBool targetVisible = false.obs;

  RxBool isFilterOn = true.obs;

  // 임시
  int postId = 4;

  Future<void> loadData() async {
    // /post/{post_id}
    try {
      final dio = createDio();
      final PostRepository infoRepository = PostRepository(dio);
      final response = await infoRepository.getPost(postId);

      post.value = Post(
        pid: response.pid,
        name: response.name,
        gender: response.gender,
        age: response.age,
        address: response.address,
        latitude: response.latitude,
        longitude: response.longitude,
        clothes: response.clothes,
        bookmarked: response.bookmarked,
        images: response.images,
        genImage: response.genImage,
        disappearedAt: response.disappearedAt,
        createdAt: response.createdAt,
        updatedAt: response.updatedAt,
        author: response.author,
        genRepresent: response.genRepresent,
      );
      // post.value = response;
      post.refresh();
    } catch (error) {
      // 에러 처리
      print('Error fetching info detail: $error');
    }
  }

  Future<void> loadComments() async {
    // /post/{post_id}/comments
    try {
      final dio = createDio();
      final CommentRepository comtRepository = CommentRepository(dio);
      final response = await comtRepository.getCommentList(postId, 0);

      commentList.value = response;
      commentList.refresh();
    } catch (error) {
      // 에러 처리
      print('Error fetching info detail: $error');
    }
  }

  Future<void> deletePost() async {
    // /post/{post_id}/comments
    try {
      final dio = createDio();
      final PostRepository postRepository = PostRepository(dio);
      final response = await postRepository.deletePost(postId);
    } catch (error) {
      // 에러 처리
      print('Error fetching info detail: $error');
    }
  }

  void changeImgSlideIdx(int index) {
    currentIndex.value = index;
  }

  Future<void> loadCommentsNoFilter() async {
    try {
      final dio = createDio();
      final CommentRepository comtRepository = CommentRepository(dio);
      final response =
          await comtRepository.getCommentList(postId, Config.filterCriteria);

      commentList.value = response;
      commentList.refresh();
    } catch (error) {
      // 에러 처리
      print('Error fetching info detail: $error');
    }
  }

  void setTargetComment(Comment data) {
    targetComment.value = data;
    targetVisible.value = true;
  }

  void unVisibleTargetComment() {
    targetVisible.value = false;
  }
}
