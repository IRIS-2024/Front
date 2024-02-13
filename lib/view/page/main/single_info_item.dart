import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/model/post_list.dart';
import 'package:iris_flutter/utils/time_diff_utils.dart';
import 'package:iris_flutter/view/controller/mypage/bookmark_controller.dart';

<<<<<<< HEAD
class SingleInfo extends StatelessWidget {
  Post missingInfo;
  SingleInfo({super.key, required this.missingInfo});
=======
class SingleInfoItem extends StatefulWidget {
  final dynamic controller;
  final PostList info;

  const SingleInfoItem({
    super.key,
    required this.controller,
    required this.info,
  });
>>>>>>> main

  @override
  State<SingleInfoItem> createState() => _SingleInfoItemState();
}

class _SingleInfoItemState extends State<SingleInfoItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Config.routerDetailInfo, arguments: widget.info.pid);
      },
      child: Padding(
        padding: CustomPadding.thickBottom,
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  widget.info.imgUrl,
                  height: 170,
                  width: 380,
                  fit: BoxFit.fitWidth,
                )),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.info.name} / ${widget.info.age}세 / ${widget.info.address}",
                  style: CustomTextStyle.title,
                ),
                IconButton(
                  onPressed: () {
                    // 북마크 추가 or 삭제
                    // 통신
                    Get.put(BookmarkController()).postAndDeleteBookmark(widget.info.bookmarked, widget.info.pid);
                    // 화면 변경
                    setState(() {
                      widget.info.bookmarked = !widget.info.bookmarked;
                    });
                  },
                  icon: Icon(widget.info.bookmarked
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 18,
                  color: Theme.of(context).colorScheme.outline,
                ),
                const Padding(padding: CustomPadding.slimRight),
                Text(
                  getTimeDiffText(widget.info.createdAt, widget.info.createdAt),
                  style:
                  TextStyle(color: Theme.of(context).colorScheme.outline),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
