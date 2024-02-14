import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/view/comm/custom_appbar.dart';
import 'package:iris_flutter/view/controller/my_page/my_comments_controller.dart';
import 'package:iris_flutter/view/page/post/post_page.dart';
import 'package:iris_flutter/view/page/post/single_comment_item.dart';

class MyComments extends StatefulWidget {
  const MyComments({super.key});

  @override
  State<MyComments> createState() => _MyCommentsState();
}

class _MyCommentsState extends State<MyComments> {
  MyCommentsController comtController = Get.put(MyCommentsController());
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    comtController.loadData();
  }

  void galleryPageChange(int index) {
    comtController.changeImgSlideIdx(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "작성한 제보 댓글"),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: comtController.commentList.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.only(top: 5, bottom: 20),
                  itemCount: comtController.commentList.length,
                  itemBuilder: (BuildContext context, int postIdx) {
                    final post = comtController.commentList[postIdx];
                    return Column(
                      children: [
                        Card(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: InkWell(
                            onTap: () => Get.to(const PostPage()),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      post.imgUrl,
                                      height: 40,
                                      width: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Padding(padding: CustomPadding.slimRight),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 120,
                                  child: Text(
                                      '${post.name} / ${post.gender ? "남" : "여"} / ${post.age} 세 / ${post.address}',
                                      overflow: TextOverflow.ellipsis,
                                      style: CustomTextStyle.basic),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                          itemCount: post.commentList.length,
                          itemBuilder: (BuildContext context, int cmtIdx) {
                            return SingleCmtItem(
                              comment: post.commentList[cmtIdx],
                              controller: comtController,
                              closeAble: false,
                            );
                          },
                          separatorBuilder: (BuildContext ctx, int idx) {
                            return const Divider();
                          },
                        ),
                      ],
                    );
                  })
              : const Center(
                  child: Text("작성한 제보 댓글이 없습니다."),
                )),
    );
  }
}
