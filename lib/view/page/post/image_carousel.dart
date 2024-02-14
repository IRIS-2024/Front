import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iris_flutter/config/custom_padding.dart';
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
                        onPressed: () =>
                        {
                          setState(() {
                            activeIndex -= 1;
                            controller.animateToPage(activeIndex);
                          })
                        },
                      ),
                    const Spacer(),
                    if (activeIndex !=
                        (widget.images.length - 1))
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios_rounded),
                        onPressed: () =>
                        {
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

  Widget buildIndicator() =>
      AnimatedSmoothIndicator(
          onDotClicked: animateToSlide,
          effect: WormEffect(
              activeDotColor: Theme.of(context).colorScheme.primaryContainer,
              dotWidth: 15, dotHeight: 15),
          activeIndex: activeIndex,
          count: widget.images.length);

  void animateToSlide(int index) => controller.animateToPage(index);


  Widget buildImage(String urlImage, int index) =>
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(urlImage, fit: BoxFit.cover)));
}