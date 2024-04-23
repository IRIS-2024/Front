import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/view/controller/my_page/bookmark_controller.dart';
import 'package:iris_flutter/view/controller/post/post_controller.dart';
import 'package:iris_flutter/view/page/main/delete_post_dialog.dart';
import 'package:iris_flutter/view/page/post/detail_tab.dart';
import 'package:iris_flutter/view/page/post/comment_tab.dart';
import 'package:iris_flutter/config/config.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> with TickerProviderStateMixin {
  PostController postController = Get.put(PostController());
  BookmarkController bookmrkController = Get.put(BookmarkController());
  late TabController _nestedTabController;

  bool isbookmarked = false;

  @override
  void initState() {
    postController.setPid(Get.arguments);
    isbookmarked = postController.post.value.bookmarked;
    _nestedTabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _nestedTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              '실종 정보',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            centerTitle: true,
            elevation: 0,
            // 앱 바 뒷 배경색 제거
            leading: IconButton(
              icon: const Icon(Icons.arrow_back), // 햄버거버튼 아이콘 생성
              onPressed: () {
                if (Get.currentRoute == Config.routerPost) {
                  Get.offAllNamed(Config.routerMain);
                } else {
                  Get.back();
                }
              },
            ),
            actions: [
              IconButton(
                icon: isbookmarked
                    ? const Icon(Icons.bookmark)
                    : const Icon(Icons.bookmark_outline), // 장바구니 아이콘 생성
                onPressed: () {
                  // 아이콘 버튼 실행
                  bookmrkController.postAndDeleteBookmark(
                      postController.post.value.bookmarked,
                      postController.postId.value);
                  setState(() {
                    isbookmarked = !isbookmarked;
                  });
                },
              ),
            ],
            bottom: TabBar(
              padding: CustomPadding.regularHorizontal,
              labelColor: Theme.of(context).colorScheme.onPrimaryContainer,
              labelStyle: CustomTextStyle.basicBold,
              indicator: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(15.0),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              tabs: const [
                SizedBox(height: 40, child: Tab(text: "상세 내용")),
                SizedBox(height: 40, child: Tab(text: "제보"))
              ],
              controller: _nestedTabController,
            ),
          ),
          body: Column(
            children: [
              const Padding(padding: CustomPadding.regularBottom),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _nestedTabController,
                  children: const [DetailTab(), CommentTab()],
                ),
              )
            ],
          ),
          floatingActionButton: Obx(() => postController.post.value.author
              ? FloatingActionButton.extended(
                  onPressed: () {
                    // 발견 완료
                    // dialog로 한 번 더 묻고 -> 신고글 삭제
                    showDeletePostDialog(
                        postController.postId.value, moveToMain);
                  },
                  backgroundColor: Colors.red,
                  label: const Text('신고 해제하기'),
                  icon: const Icon(Icons.highlight_off),
                )
              : FloatingActionButton.extended(
                  onPressed: () {
                    // log('infoController.missingInfo.value: ${postController.post.value.pid}');
                    Get.toNamed(Config.routerCommentForm,
                        arguments: postController.post.value);
                  },
                  backgroundColor:
                      Theme.of(context).colorScheme.tertiaryContainer,
                  foregroundColor:
                      Theme.of(context).colorScheme.onTertiaryContainer,
                  label: const Text('제보하기'),
                  icon: const Icon(Icons.report_gmailerrorred),
                ))),
    );
  }

  void moveToMain() {
    Get.offAllNamed(Config.routerMain);
  }
}
