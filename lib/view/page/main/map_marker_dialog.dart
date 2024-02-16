import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/model/post.dart';
import 'package:iris_flutter/view/controller/post/post_controller.dart';
import 'package:iris_flutter/view/page/post/image_carousel.dart';

void showMapMarkerDialog(int pid) {
  Get.dialog(Dialog(
      child: MapMarkerDialog(
    pid: pid,
  )));
}

class MapMarkerDialog extends StatefulWidget {
  final int pid;

  const MapMarkerDialog({Key? key, required this.pid}) : super(key: key);

  @override
  State<MapMarkerDialog> createState() => _MapMarkerDialogState();
}

class _MapMarkerDialogState extends State<MapMarkerDialog> {
  @override
  void initState() {
    Get.put(PostController()).loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Post post = Get.put(PostController()).post.value;

    return Padding(
      padding: CustomPadding.dialogInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 이름
          Text(
            post.name,
            style: CustomTextStyle.title
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          const Padding(padding: CustomPadding.regularBottom),
          // 사진
          ImageCarousel(images: post.images),
          const Padding(padding: CustomPadding.regularBottom),
          // 상세 내용
          _titleAndContent(
              title: '인적사항',
              content:
                  '${Config().getGenderText(post.gender)} / ${post.age}세 / ${post.height == 0 ? '' : '${post.height}cm'} / ${post.weight == 0 ? '' : '${post.weight}kg'}'),
          _titleAndContent(title: '마지막 위치', content: post.address),
          post.clothes != ''
              ? _titleAndContent(title: '옷차림', content: post.clothes)
              : const SizedBox(),
          post.details != ''
              ? _titleAndContent(title: '특이사항', content: post.details!)
              : const SizedBox(),
          const Padding(
            padding: CustomPadding.mediumBottom,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('닫기')),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(Config.routerPost, arguments: widget.pid);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    foregroundColor:
                        Theme.of(context).colorScheme.onPrimaryContainer),
                child: const Text('보기'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _titleAndContent({required String title, required String content}) {
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              title,
              style: TextStyle(color: Theme.of(context).colorScheme.outline),
            ),
          ),
          const Padding(padding: CustomPadding.slimRight),
          SizedBox(
            width: constraints.maxWidth - 80,
            child: Text(
              content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
