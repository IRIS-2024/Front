import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/view/controller/post/detail_controller.dart';
import 'package:iris_flutter/view/page/post/image_carousel.dart';

class DetailTab extends StatefulWidget {
  const DetailTab({super.key});

  @override
  State<DetailTab> createState() => _DetailTabState();
}

class _DetailTabState extends State<DetailTab> {
  DetailController detailController = Get.find<DetailController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ImageCarousel(images: detailController.post.value.images),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            color: Colors.white,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                detailController.post.value.name,
                style: CustomTextStyle.titleBold,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: postItem(
                        "성별", detailController.post.value.gender ? "남" : "여"),
                  ),
                  Expanded(
                    child: postItem("만나이", detailController.post.value.age),
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: postItem(
                        "키", "${detailController.post.value.height} cm"),
                  ),
                  Expanded(
                    child: postItem(
                        "몸무게", "${detailController.post.value.weight} kg"),
                  )
                ],
              ),
              const Divider(),
              postItem("마지막 위치", detailController.post.value.address),
              const Divider(),
              postItem("실종 당시 옷차림", detailController.post.value.clothes),
              const Divider(),
              postItem("특이사항", detailController.post.value.details),
              const Divider(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget postItem(String title, dynamic context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(context.toString()),
        ],
      );
}
