import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/model/comment.dart';
import 'package:iris_flutter/utils/time_diff_utils.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class SingleCmtItem extends StatefulWidget {
  final dynamic controller;
  final Comment comment;
  final bool closeAble;
  final dynamic closeMethod;
  const SingleCmtItem(
      {super.key,
      required this.controller,
      required this.comment,
      required this.closeAble,
      this.closeMethod});

  @override
  State<SingleCmtItem> createState() => _SingleCmtItemState();
}

class _SingleCmtItemState extends State<SingleCmtItem> {
  final carouselController = CarouselController();
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: CustomPadding.pageInsets,
      child: Column(
        children: [
          // 제목
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  widget.comment.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Text(
                  getTimeDiffText(
                      widget.comment.createdAt, widget.comment.createdAt),
                  style: const TextStyle(fontSize: 12)),
              if (widget.closeAble == true)
                IconButton(
                    onPressed: widget.closeMethod,
                    icon: const Icon(Icons.close)),
            ],
          ),
          const Padding(padding: CustomPadding.regularBottom),
          // 내용
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.comment.images.isNotEmpty)
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => imgDialog(context),
                        );
                      },
                      child: Container(
                        // 이미지(썸네일)
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width),
                        width: 100,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                widget.comment.images[0],
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "${widget.comment.images.length}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(padding: CustomPadding.slimBottom),
                    Text('일치율 ${widget.comment.accuracy} %',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.primary))
                  ],
                ),
              const SizedBox(width: 12),
              Expanded(
                // 상세 정보 글
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.comment.clothes != null)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("옷차림",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(
                            width: 8,
                          ),
                          Flexible(child: Text(widget.comment.clothes!))
                        ],
                      ),
                    if (widget.comment.details != null)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("당시 상황",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(
                            width: 8,
                          ),
                          Flexible(child: Text(widget.comment.details!))
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
  }

  Dialog imgDialog(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Colors.black.withOpacity(0.5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int imgIdx) {
              final item = widget.comment.images[imgIdx];
              return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(item),
                  initialScale: PhotoViewComputedScale.contained,
                  minScale:
                      PhotoViewComputedScale.contained * (0.5 + imgIdx / 10),
                  maxScale: PhotoViewComputedScale.contained * 1.1,
                  heroAttributes: PhotoViewHeroAttributes(tag: imgIdx));
            },
            itemCount: widget.comment.images.length,
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
    widget.controller.changeImgSlideIdx(index);
  }
}
