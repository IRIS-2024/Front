import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/utils/time_diff_utils.dart';
import 'package:iris_flutter/view/controller/post/comment_controller.dart';
import 'package:iris_flutter/view/controller/post/detail_controller.dart';
import 'package:iris_flutter/view/page/post/map_item.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class CommentTab extends StatefulWidget {
  const CommentTab({super.key});

  @override
  State<CommentTab> createState() => _CommentTabState();
}

class _CommentTabState extends State<CommentTab> {
  bool isSwitched = true;

  final carouselController = CarouselController();
  PageController pageController = PageController(initialPage: 0);

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
              return Padding(
                padding: CustomPadding.pageInsets,
                child: Column(
                  children: [
                    // 제목
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            comtController.commentList[cmtIdx].title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        Text(
                            getTimeDiffText(
                                comtController.commentList[cmtIdx].createdAt,
                                comtController.commentList[cmtIdx].updatedAt),
                            style: const TextStyle(fontSize: 12))
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    // 내용
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (comtController
                            .commentList[cmtIdx].images.isNotEmpty)
                          Column(
                            children: [
                              Container(
                                // 이미지(썸네일)
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width),
                                width: 100,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        comtController
                                            .commentList[cmtIdx].images[0],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: GestureDetector(
                                        onTap: () => showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              imgDialog(cmtIdx, context),
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            "${comtController.commentList[cmtIdx].images.length}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(padding: CustomPadding.slimBottom),
                              Text(
                                  '일치율 ${comtController.commentList[cmtIdx].accuracy} %',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary))
                            ],
                          ),
                        const SizedBox(width: 12),
                        Expanded(
                          // 상세 정보 글
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (comtController.commentList[cmtIdx].clothes !=
                                  null)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("옷차림",
                                        style: TextStyle(color: Colors.grey)),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Flexible(
                                        child: Text(comtController
                                            .commentList[cmtIdx].clothes!))
                                  ],
                                ),
                              if (comtController.commentList[cmtIdx].details !=
                                  null)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("당시 상황",
                                        style: TextStyle(color: Colors.grey)),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Flexible(
                                        child: Text(comtController
                                            .commentList[cmtIdx].details!))
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext ctx, int idx) {
              return const Divider();
            },
          ),
        )
      ]),
    );
  }

  Dialog imgDialog(int cmtIdx, BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Colors.black.withOpacity(0.5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int imgIdx) {
              final item = comtController.commentList[cmtIdx].images[imgIdx];
              return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(item),
                  initialScale: PhotoViewComputedScale.contained,
                  minScale:
                      PhotoViewComputedScale.contained * (0.5 + imgIdx / 10),
                  maxScale: PhotoViewComputedScale.contained * 1.1,
                  heroAttributes: PhotoViewHeroAttributes(tag: imgIdx));
            },
            itemCount: comtController.commentList[cmtIdx].images.length,
            // loadingBuilder: loadingBuilder,
            backgroundDecoration:
                const BoxDecoration(color: Colors.transparent),
            pageController: pageController,
            onPageChanged: galleryPageChange,
            scrollDirection: Axis.horizontal,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                '닫기',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void galleryPageChange(int index) {
    comtController.changeImgSlideIdx(index);
  }
}
