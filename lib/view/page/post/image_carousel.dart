import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> images;
  const ImageCarousel({Key? key, required this.images}) : super(key: key);

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final controller = CarouselController();
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CarouselSlider.builder(
                carouselController: controller,
                itemCount: widget.images.length,
                itemBuilder: (context, index, realindex) {
                  final images = widget.images[index];
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
                    if (activeIndex != (widget.images.length - 1))
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
        const Padding(padding: CustomPadding.regularBottom),
        buildIndicator(),
      ],
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
      onDotClicked: animateToSlide,
      effect: WormEffect(
          activeDotColor: Theme.of(context).colorScheme.primaryContainer,
          dotWidth: 15,
          dotHeight: 15),
      activeIndex: activeIndex,
      count: widget.images.length);

  void animateToSlide(int index) => controller.animateToPage(index);

  Widget buildImage(String urlImage, int index) => Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(urlImage, fit: BoxFit.cover),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(1.0),
              color: Colors.white.withOpacity(0.5), // 반투명한 하얀 상자
              child: const Text(
                "입력된 정보를 기반으로 \nAI가 생성한 이미지 입니다.",
                style: CustomTextStyle.small,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
        ],
      );
}
