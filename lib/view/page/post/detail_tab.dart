import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/view/controller/post/detail_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailTab extends StatefulWidget {
  const DetailTab({super.key});

  @override
  State<DetailTab> createState() => _DetailTabState();
}

class _DetailTabState extends State<DetailTab> {
  final controller = CarouselController();
  DetailController detailController = Get.find<DetailController>();

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CarouselSlider.builder(
                  carouselController: controller,
                  itemCount: detailController.urlImages.length,
                  itemBuilder: (context, index, realindex) {
                    final images = detailController.urlImages[index];
                    return buildImage(images, index);
                  },
                  options: CarouselOptions(
                      initialPage: 0,
                      height: 300,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) =>
                          setState(() => activeIndex = index))),
              Padding(
                  padding: CustomPadding.pageInsets,
                  child: Row(
                    children: [
                      if (activeIndex != 0)
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_rounded),
                          onPressed: () => {
                            setState(() {
                              activeIndex -= 1;
                              controller.animateToPage(activeIndex);
                            })
                          },
                        ),
                      const Spacer(),
                      if (activeIndex !=
                          (detailController.urlImages.length - 1))
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios_rounded),
                          onPressed: () => {
                            setState(() {
                              activeIndex += 1;
                              controller.animateToPage(activeIndex);
                            })
                          },
                        )
                    ],
                  ))
            ],
          ),
          const SizedBox(height: 12),
          buildIndicator(),
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

  Widget buildIndicator() => AnimatedSmoothIndicator(
      onDotClicked: animateToSlide,
      effect: const WormEffect(dotWidth: 15),
      activeIndex: activeIndex,
      count: detailController.urlImages.length);

  void animateToSlide(int index) => controller.animateToPage(index);
}

Widget buildImage(String urlImage, int index) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 5),
    child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(urlImage, fit: BoxFit.cover)));

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
