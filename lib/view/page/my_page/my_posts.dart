import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/view/comm/custom_appbar.dart';
import 'package:iris_flutter/view/controller/my_page/bookmark_controller.dart';
import 'package:iris_flutter/view/page/main/single_post_item.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({super.key});

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  final bookmarkController = Get.put(BookmarkController());
  @override
  void initState() {
    // 여기 에러 때문에 주석 처리함 다른 함수 사용해 주세요!!
    // Get.put(MainController()).setTmpData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(title: "작성한 실종 정보"),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: bookmarkController.postList.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.only(top: 5, bottom: 20),
                    itemCount: bookmarkController.postList.length,
                    itemBuilder: (BuildContext context, int idx) {
                      return SinglePostItem(
                          controller: bookmarkController,
                          post: bookmarkController.postList[idx]);
                    })
                : const Center(
                    child: Text("작성한 실종 정보가 없습니다."),
                  )));
  }
}
