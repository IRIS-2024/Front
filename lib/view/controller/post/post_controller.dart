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
    // try {
    //   final dio = createDio();
    //   final PostRepository infoRepository = PostRepository(dio);
    //   final response =
    //       await infoRepository.getPost(argumentPid ?? postId.value);

    //   post.value = response;
    // } catch (error) {
    //   // 에러 처리
    //   print('Error fetching info detail: $error');
    // }

    Post dummy = Post(
        pid: 1,
        images: [
          'https://plus.unsplash.com/premium_photo-1664203067979-47448934fd97?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
        ],
        genImage:
            'https://plus.unsplash.com/premium_photo-1664203067979-47448934fd97?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        genRepresent: true,
        name: '윤여희',
        gender: true,
        age: 52,
        height: 160,
        weight: 55,
        clothes: '흰 모자에 보라색 조끼, 검정 긴 바지',
        details: '디테일디테일디테일디테일디테일디테일디테일디테일디테일내용내용내용내용',
        address: '대한민국 서울특별시 숙명여대후문.이봉창활동터',
        latitude: 37.544908,
        longitude: 126.964758,
        disappearedAt: '2024-04-16T11:56:52.588Z',
        createdAt: "2024-04-16T11:56:52.588Z",
        updatedAt: "2024-04-16T11:56:52.588Z",
        bookmarked: false,
        author: false);

    post.value = dummy;
  }

  Future<void> loadComments() async {
    // /post/{post_id}/comments
    int filterNum = 0;
    if (isFilterOn.value) {
      filterNum = Config.filterCriteria;
    }

    // try {
    //   final dio = createDio();
    //   final CommentRepository comtRepository = CommentRepository(dio);
    //   final response =
    //       await comtRepository.getCommentList(postId.value, filterNum);

    //   commentList.value = response;
    //   // commentList.refresh();
    // } catch (error) {
    //   // 에러 처리s
    //   print('Error fetching info detail: $error');
    // }

    List<Comment> dummy = [
      Comment(
          cid: 1,
          address: '대한민국 서울특별시 용산구 갈월동 13-6',
          latitude: 37.545048,
          longitude: 126.963200,
          clothes: '',
          details: '상세',
          images: [
            'https://images.unsplash.com/photo-1499952127939-9bbf5af6c51c?q=80&w=1476&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1287&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
          ],
          discoveredAt: '2024-04-19T05:50:51.273Z',
          createdAt: '2024-04-19T05:50:51.273Z',
          author: true),
      Comment(
          cid: 2,
          address: '대한민국 서울특별시 용산구 남영동 47-1',
          latitude: 37.544228,
          longitude: 126.963606,
          clothes: '옷차림',
          details: '',
          images: [
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1287&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            'https://images.unsplash.com/photo-1499952127939-9bbf5af6c51c?q=80&w=1476&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          ],
          accuracy: 85,
          discoveredAt: '2024-04-19T05:50:51.273Z',
          createdAt: '2024-04-19T05:50:51.273Z',
          author: false)
    ];
    commentList.value = dummy;

    makeMarkers();
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
            makeMarkers(); // 숫자가 표시되는 특별한 마커를 사용하고 있기 때문에, 클릭될 때마다 Marker들을 다 다시 그려주어야 함
          }));
    }
  }

  void deleteComment(int cid) async {
    final dio = createDio();
    CommentRepository commentRepository = CommentRepository(dio);
    await commentRepository.deleteComment(cid).then((resp) {
      // Error 발생 안 하면 성공
      customSnackBar(title: '제보 댓글 삭제', message: '제보 댓글을 삭제하였습니다.');
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
