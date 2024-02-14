import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  bool isSwitched = true;

  PostController postController = Get.find<PostController>();

  @override
  void initState() {
    super.initState();
    postController.loadCommentsOfPost();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        // map()
        SizedBox(
          height: 300,
          child: Obx(
            () => postController.post.value.latitude == null
                ? const CircularProgressIndicator()
                : const MapItem(),
          ),
        ),
        Obx(() => postController.targetVisible.value == true
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: postController.unVisibleTargetComment,
                      icon: const Icon(Icons.close)),
                  SingleCmtItem(
                      controller: postController,
                      comment: postController.targetComment.value),
                ],
              )
            : const Padding(padding: CustomPadding.slimBottom)),
        Container(
            alignment: Alignment.centerRight,
            color: Colors.white,
            child: SwitchListTile(
                value: isSwitched,
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text("정확도 80% 이상"),
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    print(isSwitched);
                    // 필터 API 요청
                  });
                })),
        Container(
          color: Colors.white,
          child: ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemCount: postController.commentList.length,
            itemBuilder: (BuildContext context, int cmtIdx) {
              return SingleCmtItem(
                  comment: postController.commentList[cmtIdx],
                  controller: postController);
            },
            separatorBuilder: (BuildContext ctx, int idx) {
              return const Divider();
            },
          ),
        )
      ]),
    );
  }
}
