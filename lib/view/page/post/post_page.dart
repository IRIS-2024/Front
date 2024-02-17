import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/view/controller/my_page/bookmark_controller.dart';
import 'package:iris_flutter/view/controller/post/post_controller.dart';
import 'package:iris_flutter/view/page/main/main_page.dart';
import 'package:iris_flutter/view/page/post/detail_tab.dart';
import 'package:iris_flutter/view/page/post/comment_tab.dart';
import 'package:iris_flutter/config/config.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  PostController postController = Get.put(PostController());
  BookmarkController bookmrkController = Get.put(BookmarkController());
  int pid = 0; // Get.arguments['pid']

  @override
  void initState() {
    super.initState();
    // *** pid = Get.arguments 읽어와서 사용
    // postController.loadData(pid);
    postController.loadData();
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
            elevation: 0, // 앱 바 뒷 배경색 제거
            leading: IconButton(
              icon: const Icon(Icons.arrow_back), // 햄버거버튼 아이콘 생성
              onPressed: () {
                Get.to(() => const MainPage());
              },
            ),
            actions: [
              IconButton(
                icon: postController.post.value.bookmarked
                    ? const Icon(Icons.bookmark)
                    : const Icon(Icons.bookmark_outline), // 장바구니 아이콘 생성
                onPressed: () {
                  // 아이콘 버튼 실행
                  bookmrkController.postAndDeleteBookmark(
                      postController.post.value.bookmarked, pid);
                },
              ),
            ],
            bottom: TabBar(
              labelColor: Colors.white, // 배경색
              unselectedLabelColor: Theme.of(context).colorScheme.primary,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).colorScheme.primary),
              tabs: [
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1)),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text("상세 내용"),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1)),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text("제보"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: const Column(
            children: [
              SizedBox(
                // 탭 바와 본문의 여백을 위해
                height: 12,
              ),
              Expanded(
                child: TabBarView(
                  children: [DetailTab(), CommentTab()],
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              print(
                  'print infoController.missingInfo.value: ${postController.post.value.address}');
              Get.toNamed(Config.routerCommentForm,
                  arguments: postController.post.value);
            },
            label: const Text('제보하기'),
            icon: const Icon(Icons.report_gmailerrorred),
          )),
    );
  }
}
