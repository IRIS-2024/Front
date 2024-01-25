import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/view/controller/info_form/info_form_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageFormCarousel extends StatefulWidget {
  const ImageFormCarousel({Key? key}) : super(key: key);

  @override
  State<ImageFormCarousel> createState() => _ImageFormCarouselState();
}

class _ImageFormCarouselState extends State<ImageFormCarousel> {
  CarouselController carouselController = CarouselController();
  int activeIndex = 0;

  @override
  void initState() {
    Get.put(InfoFormController()).images.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(InfoFormController());
    final infoFormController = Get.find<InfoFormController>();

    return Obx(() =>
        infoFormController.images.isEmpty ? addInitImage() : imageCarousel());
  }

  Widget addInitImage() {
    Get.put(InfoFormController());
    final infoFormController = Get.find<InfoFormController>();

    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        children: [
          OutlinedButton(
            onPressed: () {
              infoFormController.pickImage();
            },
            style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 200),
                foregroundColor: Theme.of(context).colorScheme.primary,
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            child: Column(
              children: [
                const Text(''),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_outline),
                    Padding(padding: EdgeInsets.only(right: 5)),
                    Text('실종자 사진 추가')
                  ],
                ),
                Text('(최대 3장)', style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.outline
                ),)
              ],
            ),
          ),
          Obx(
            () => infoFormController.images.isEmpty &&
                    infoFormController.initValidation.value != true
                ? Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Text(
                      '사진을 추가해 주세요.',
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.error),
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget imageCarousel() {
    Get.put(InfoFormController());
    final infoFormController = Get.find<InfoFormController>();

    return Column(
      children: [
        Obx(
          () => Stack(
            alignment: Alignment.center,
            children: [
              // Carousel
              CarouselSlider.builder(
                  carouselController: carouselController,
                  itemCount: infoFormController.images.length,
                  itemBuilder: (context, index, realindex) {
                    final image = infoFormController.images[index];
                    return buildImage(image.path, index);
                  },
                  options: CarouselOptions(
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) =>
                          setState(() => activeIndex = index))),
              // 좌우 키
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      if (activeIndex != 0)
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_rounded),
                          onPressed: () => {
                            setState(() {
                              activeIndex -= 1;
                              carouselController.animateToPage(activeIndex);
                            })
                          },
                        ),
                      const Spacer(),
                      if (activeIndex != (infoFormController.images.length - 1))
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios_rounded),
                          onPressed: () => {
                            setState(() {
                              activeIndex += 1;
                              carouselController.animateToPage(activeIndex);
                            })
                          },
                        )
                    ],
                  )),
              // 삭제 아이콘
              Positioned(
                  top: 3,
                  right: MediaQuery.of(context).size.width / 9,
                  child: IconButton(
                      onPressed: () {
                        print('print activeIndex: ${activeIndex}');
                        infoFormController.images.removeAt(activeIndex);
                      },
                      icon: const Icon(Icons.delete_outline),
                      style: IconButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black.withOpacity(0.5))))
            ],
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 15)),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              infoFormController.images.length + 1 <= Config.maxImagesLength
                  ? const SizedBox(
                      width: 100,
                    )
                  : const SizedBox(),
              buildIndicator(),

              // 추가 버튼 따로
              infoFormController.images.length + 1 <= Config.maxImagesLength
                  ? OutlinedButton.icon(
                      onPressed: () {
                        infoFormController.pickImage();
                      },
                      style: OutlinedButton.styleFrom(
                          minimumSize: const Size(40, 35),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      icon: const Icon(Icons.add_circle_outline),
                      label: const Text('추가'))
                  : const SizedBox(),
            ],
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 15)),
      ],
    );
  }

  Widget buildImage(String imagePath, int index) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.file(
              File(imagePath),
              height: 200,
              fit: BoxFit.fitHeight,
            )));
  }

  Widget buildIndicator() {
    Get.put(InfoFormController());
    final infoFormController = Get.find<InfoFormController>();

    return AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: WormEffect(
            activeDotColor: Theme.of(context).colorScheme.primaryContainer,
            dotWidth: 12,
            dotHeight: 12),
        activeIndex: activeIndex,
        count: infoFormController.images.length);
  }

  void animateToSlide(int index) => carouselController.animateToPage(index);
}
