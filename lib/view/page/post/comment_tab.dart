import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/view/controller/post/comment_controller.dart';
import 'package:iris_flutter/view/controller/post/detail_controller.dart';
import 'package:iris_flutter/view/page/post/single_comment_item.dart';
import 'package:iris_flutter/view/page/post/map_item.dart';

class CommentTab extends StatefulWidget {
  const CommentTab({super.key});

  @override
  State<CommentTab> createState() => _CommentTabState();
}

class _CommentTabState extends State<CommentTab> {
  bool isSwitched = true;

  DetailController detailController = Get.find<DetailController>();
  CommentController comtController = Get.put(CommentController());

  @override
  void initState() {
    super.initState();
    comtController.loadCommentsOfPost();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        // map()
        SizedBox(
          height: 300,
          child: Obx(
            () => detailController.post.value.latitude == null
                ? const CircularProgressIndicator()
                : const MapItem(),
          ),
        ),
        const SizedBox(height: 12),
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
            itemCount: comtController.commentList.length,
            itemBuilder: (BuildContext context, int cmtIdx) {
              return singleCmtItem(
                  comment: comtController.commentList[cmtIdx],
                  controller: comtController);
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
