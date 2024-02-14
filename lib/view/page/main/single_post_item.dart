import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/model/short_post.dart';
import 'package:iris_flutter/utils/time_diff_utils.dart';
import 'package:iris_flutter/view/controller/my_page/bookmark_controller.dart';

class SinglePostItem extends StatefulWidget {
  final dynamic controller;
  final ShortPost post;

  const SinglePostItem({
    super.key,
    required this.controller,
    required this.post,
  });

  @override
  State<SinglePostItem> createState() => _SinglePostItemState();
}

class _SinglePostItemState extends State<SinglePostItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Config.routerPost, arguments: widget.post.pid);
      },
      child: Padding(
        padding: CustomPadding.thickBottom,
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  widget.post.imgUrl,
                  height: 170,
                  width: 380,
                  fit: BoxFit.fitWidth,
                )),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.post.name} / ${widget.post.age}세 / ${widget.post.address}",
                  style: CustomTextStyle.title,
                ),
                IconButton(
                  onPressed: () {
                    // 북마크 추가 or 삭제
                    // 통신
                    Get.put(BookmarkController()).postAndDeleteBookmark(
                        widget.post.bookmarked, widget.post.pid);
                    // 화면 변경
                    setState(() {
                      widget.post.bookmarked = !widget.post.bookmarked;
                    });
                  },
                  icon: Icon(widget.post.bookmarked
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
                  getTimeDiffText(widget.post.createdAt, widget.post.createdAt),
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
