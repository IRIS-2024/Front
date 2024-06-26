import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/model/comment.dart';
import 'package:iris_flutter/model/post.dart';
import 'package:iris_flutter/repository/comment_repository.dart';
import 'package:iris_flutter/repository/post_repository.dart';
import 'package:iris_flutter/view/comm/custom_snackbar.dart';
import 'package:label_marker/label_marker.dart';
import 'package:intl/intl.dart';

class PostController extends GetxController {
  // 이전 페이지에서 전달 받은 postId
  RxInt postId = 0.obs;

  // Rx<Post?> post = Rx<Post?>(null);
  // 하나의 실종 정보 글에 대한 정보
  Rx<Post> post = Post(
    pid: 0,
    name: "",
    gender: true,
    age: 0,
    address: "",
    latitude: 0.0,
    longitude: 0.0,
    clothes: "",
    bookmarked: false,
    images: [""],
    genImage: '',
    disappearedAt: '',
    createdAt: '',
    updatedAt: '',
    author: false,
    genRepresent: true,
  ).obs;

  // imageCarousel 에 보일 전체 images
  RxList<String> fullImages = [""].obs;

  // 해당 실종 정보 글에 달린 제보 댓글들
  RxList<Comment> commentList = <Comment>[].obs;
  RxSet<Marker> commentMarkers = <Marker>{}.obs;
  RxInt currentIndex = 0.obs; // 댓글 별 이미지 슬라이드

  Rx<Comment> targetComment = Comment(
          cid: 0,
          address: '',
          latitude: 0.0,
          longitude: 0.0,
          images: [''],
          discoveredAt: '',
          createdAt: '',
          author: false)
      .obs;
  RxBool targetVisible = false.obs;

  RxBool isFilterOn = true.obs;

  void setPid(int argumentPid) {
    postId.value = argumentPid;
  }

  Future<void> loadData(int? argumentPid) async {
    // /post/{post_id}
    try {
      final dio = createDio();
      final PostRepository infoRepository = PostRepository(dio);
      final response =
          await infoRepository.getPost(argumentPid ?? postId.value);

      post.value = response;
    } catch (error) {
      // 에러 처리
      print('Error fetching info detail: $error');
    }
  }

  Future<void> loadComments() async {
    // /post/{post_id}/comments
    int filterNum = 0;
    if (isFilterOn.value) {
      filterNum = Config.filterCriteria;
    }

    try {
      final dio = createDio();
      final CommentRepository comtRepository = CommentRepository(dio);
      final response =
          await comtRepository.getCommentList(postId.value, filterNum);

      commentList.value = response;
      // commentList.refresh();
      makeMarkers();
    } catch (error) {
      // 에러 처리s
      print('Error fetching info detail: $error');
    }
  }

  void makeMarkers() {
    for (int i = 0; i < commentList.length; i++) {
      commentMarkers.addLabelMarker(LabelMarker(
          label: '${i + 1}',
          markerId: MarkerId(commentList[i].cid.toString()),
          position: LatLng(commentList[i].latitude, commentList[i].longitude),
          backgroundColor: commentList[i].cid == targetComment.value.cid
              ? const Color(0xffffda66)
              : Colors.red,
          textStyle: TextStyle(
              fontSize: 40,
              color: commentList[i].cid == targetComment.value.cid
                  ? const Color(0xff544300)
                  : Colors.white),
          onTap: () {
            setTargetComment(commentList[i]);
          }));
    }
  }

  void deleteComment(int cid) async {
    final dio = createDio();
    CommentRepository commentRepository = CommentRepository(dio);
    await commentRepository.deleteComment(cid).then((resp) {
      // Error 발생 안 하면 성공
      customSnackBar(
          title: Intl.message('delComment'),
          message: Intl.message('delCommentSnackBar'));
      loadComments();
    }).catchError((error) {
      log('[catchError]: $error');
    });
  }

  void changeImgSlideIdx(int index) {
    currentIndex.value = index;
  }

  void setTargetComment(Comment data) {
    targetComment.value = data;
    targetVisible.value = true;

    makeMarkers(); // 숫자가 표시되는 특별한 마커를 사용하고 있기 때문에, 클릭될 때마다 Marker들을 다 다시 그려주어야 함
  }

  void unVisibleTargetComment() {
    // 초기화
    targetComment.value = Comment(
        cid: 0,
        address: '',
        latitude: 0.0,
        longitude: 0.0,
        images: [''],
        discoveredAt: '',
        createdAt: '',
        author: false);
    targetVisible.value = false;

    makeMarkers(); //  마커 색상 변경을 위해 재생성
  }
}
