import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/model/post.dart';
import 'package:iris_flutter/view/controller/post/post_controller.dart';
import 'package:iris_flutter/view/page/post/image_carousel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  late Post post;

  Future<void> _initPostData() async {
    Get.put(PostController());
    await Get.find<PostController>().loadData(widget.pid);
    post = Get.find<PostController>().post.value;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: CustomPadding.dialogInsets,
      child: FutureBuilder(
          future: _initPostData(),
          builder: (context, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
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
                ImageCarousel(
                  images: post.images,
                  genImage: post.genImage,
                  genRepresent: post.genRepresent,
                ),
                const Padding(padding: CustomPadding.regularBottom),
                // 상세 내용
                _titleAndContent(
                    title: AppLocalizations.of(context)!.profile,
                    content:
                        '${Config().getGenderText(post.gender)} / ${post.age}${AppLocalizations.of(context)!.ageunit} ${post.height == null ? '' : '/ ${post.height}cm'} ${post.weight == null ? '' : '/ ${post.weight}kg'}'),
                _titleAndContent(
                    title: AppLocalizations.of(context)!.missingLocation,
                    content: post.address),
                _titleAndContent(
                    title: AppLocalizations.of(context)!.clothing,
                    content: post.clothes),
                post.details == null || post.details == ''
                    ? const SizedBox()
                    : _titleAndContent(
                        title: AppLocalizations.of(context)!.characteristics,
                        content: post.details!),
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
                        child: Text(AppLocalizations.of(context)!.close)),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Config.routerPost, arguments: widget.pid);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                      child: Text(AppLocalizations.of(context)!.view),
                    ),
                  ],
                ),
              ],
            );
          }),
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
