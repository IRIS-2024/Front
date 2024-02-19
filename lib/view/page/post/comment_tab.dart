import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/view/controller/post/post_controller.dart';
import 'package:iris_flutter/view/page/post/single_comment_item.dart';
import 'package:iris_flutter/view/page/post/map_item.dart';

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

          return postController.commentList.isEmpty
              ? const Center(
                  child: Text("아직 제보 댓글이 없습니다."),
                )
              : SingleChildScrollView(
                  child: Column(children: [
                    // map()
                    const SizedBox(
                      height: 300,
                      child: MapItem(),
                    ),
                    //
                    Obx(() => postController.targetVisible.value == true
                        ? Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SingleCmtItem(
                              controller: postController,
                              comment: postController.targetComment.value,
                              closeAble: true,
                              closeMethod:
                                  postController.unVisibleTargetComment,
                              hasImgAuth:
                                  postController.targetComment.value.author ||
                                          postController.post.value.author
                                      ? true
                                      : false,
                            ),
                          )
                        : const Padding(padding: CustomPadding.slimBottom)),
                    Column(
                      children: [
                        Container(
                            alignment: Alignment.centerRight,
                            color: Colors.white,
                            child: Obx(
                              () => SwitchListTile(
                                  value: postController.isFilterOn.value,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title:
                                      Text("정확도 ${Config.filterCriteria}% 이상"),
                                  onChanged: (value) {
                                    print("필터 클릭 - $value");
                                    postController.isFilterOn.value = value;
                                    postController.loadComments();
                                  }),
                            )),
                        Container(
                          color: Colors.white,
                          child: Obx(
                            () => ListView.separated(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: postController.commentList.length,
                              itemBuilder: (BuildContext context, int cmtIdx) {
                                return SingleCmtItem(
                                    comment: postController.commentList[cmtIdx],
                                    controller: postController,
                                    closeAble: false,
                                    hasImgAuth: postController
                                                .commentList[cmtIdx].author ||
                                            postController.post.value.author
                                        ? true
                                        : false);
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
