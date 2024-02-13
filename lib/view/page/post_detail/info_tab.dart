import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/view/controller/detail_info/info_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InfoTab extends StatefulWidget {
  const InfoTab({super.key});

  @override
  State<InfoTab> createState() => _InfoTabState();
}

class _InfoTabState extends State<InfoTab> {
  final controller = CarouselController();
  InfoController infoController = Get.find<InfoController>();

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
                  itemCount: infoController.urlImages.length,
                  itemBuilder: (context, index, realindex) {
                    final images = infoController.urlImages[index];
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
                      if (activeIndex != (infoController.urlImages.length - 1))
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
                infoController.missingInfo.value.name,
                style: CustomTextStyle.titleBold,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: infoItem("성별",
                        infoController.missingInfo.value.gender ? "남" : "여"),
                  ),
                  Expanded(
                    child:
                        infoItem("만나이", infoController.missingInfo.value.age),
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: infoItem(
                        "키", "${infoController.missingInfo.value.height} cm"),
                  ),
                  Expanded(
                    child: infoItem(
                        "몸무게", "${infoController.missingInfo.value.weight} kg"),
                  )
                ],
              ),
              const Divider(),
              infoItem("마지막 위치", infoController.missingInfo.value.address),
              const Divider(),
              infoItem("실종 당시 옷차림", infoController.missingInfo.value.clothes),
              const Divider(),
              infoItem("특이사항", infoController.missingInfo.value.details),
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
      count: infoController.urlImages.length);

  void animateToSlide(int index) => controller.animateToPage(index);
}

Widget buildImage(String urlImage, int index) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 5),
    child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(urlImage, fit: BoxFit.cover)));

Widget infoItem(String title, dynamic context) => Column(
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
