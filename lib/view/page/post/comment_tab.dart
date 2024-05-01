import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/view/controller/post/post_controller.dart';
import 'package:iris_flutter/view/page/post/single_comment_item.dart';
import 'package:iris_flutter/view/page/post/map_item.dart';
import 'package:intl/intl.dart';

class CommentTab extends StatefulWidget {
  const CommentTab({super.key});

  @override
  State<CommentTab> createState() => _CommentTabState();
}

class _CommentTabState extends State<CommentTab> {
  // bool isSwitched = true;

  PostController postController = Get.put(PostController());

  Future<void> _initCommentData() async {
    await Get.find<PostController>().loadComments();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initCommentData(),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Column(children: [
              // map
              const SizedBox(
                height: 300,
                child: MapItem(),
              ),
              // 마커 클릭 시 뜨는 댓글
              Obx(() => postController.targetVisible.value == true
                  ? SingleCmtItem(
                      controller: postController,
                      comment: postController.targetComment.value,
                      closeAble: true,
                      closeMethod: postController.unVisibleTargetComment,
                      hasImgAuth: postController.targetComment.value.author ||
                              postController.post.value.author
                          ? true
                          : false,
                    )
                  : const SizedBox()),
              Column(
                children: [
                  Container(
                      alignment: Alignment.centerRight,
                      color: Colors.white,
                      child: Obx(
                        () => SwitchListTile(
                            value: postController.isFilterOn.value,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(Intl.message('matchingRateFilter',
                                args: [Config.filterCriteria])),
                            onChanged: (value) {
                              postController.isFilterOn.value = value;
                              postController.loadComments();
                            }),
                      )),
                  postController.commentList.isEmpty
                      ? Obx(() => postController.isFilterOn.value
                          ? Padding(
                              padding: CustomPadding.thickTop,
                              child: Text(Intl.message('noCommt')),
                            )
                          : Padding(
                              padding: CustomPadding.thickTop,
                              child: Text(Intl.message('emptyCommt')),
                            ))
                      : Container(
                          color: Colors.white,
                          child: Obx(
                            () => ListView.separated(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: postController.commentList.length,
                              itemBuilder: (BuildContext context, int cmtIdx) {
                                return GestureDetector(
                                    child: SingleCmtItem(
                                        comment:
                                            postController.commentList[cmtIdx],
                                        controller: postController,
                                        closeAble: false,
                                        hasImgAuth: postController
                                                    .commentList[cmtIdx]
                                                    .author ||
                                                postController.post.value.author
                                            ? true
                                            : false),
                                    onTap: () {
                                      postController.setTargetComment(
                                          postController.commentList[cmtIdx]);
                                    });
                              },
                              separatorBuilder: (BuildContext ctx, int idx) {
                                return const Divider();
                              },
                            ),
                          ),
                        )
                ],
              ),
            ]),
          );
        });
  }
}
