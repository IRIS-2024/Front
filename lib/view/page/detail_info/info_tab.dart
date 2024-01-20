import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InfoTab extends StatefulWidget {
  const InfoTab({super.key});

  @override
  State<InfoTab> createState() => _InfoTabState();
}

class _InfoTabState extends State<InfoTab> {
  final controller = CarouselController();

  int activeIndex = 0;

  final urlImages = [
    'https://images.unsplash.com/photo-1612825173281-9a193378527e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=499&q=80',
    'https://images.unsplash.com/photo-1580654712603-eb43273aff33?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'https://images.unsplash.com/photo-1627916607164-7b20241db935?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
    'https://images.unsplash.com/photo-1522037576655-7a93ce0f4d10?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'https://images.unsplash.com/photo-1570829053985-56e661df1ca2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CarouselSlider.builder(
                    carouselController: controller,
                    itemCount: urlImages.length,
                    itemBuilder: (context, index, realindex) {
                      final images = urlImages[index];
                      return buildImage(images, index);
                    },
                    options: CarouselOptions(
                        initialPage: 0,
                        height: 300,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) =>
                            setState(() => activeIndex = index))),
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
                                controller.animateToPage(activeIndex);
                              })
                            },
                          ),
                        const Spacer(),
                        if (activeIndex != (urlImages.length - 1))
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "김실종",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: infoItem("성별", "남"),
                        ),
                        Expanded(
                          child: infoItem("만나이", "만 9세"),
                        )
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: infoItem("키", "140 cm"),
                        ),
                        Expanded(
                          child: infoItem("몸무게", "30 kg"),
                        )
                      ],
                    ),
                    const Divider(),
                    infoItem("마지막 위치", "서울특별시 용산구 청파동 34"),
                    const Divider(),
                    infoItem("실종 당시 옷차림",
                        "바나나 감사합니다 아름드리 아리아 아름드리 도르레 바나나 바나나 나비잠 가온해 가온누리 여우별 별하 나래 로운 별빛 소록소록 나비잠 도서 예그리나 노트북 가온해 "),
                    const Divider(),
                    infoItem("특이사항",
                        "달볓 나래 사과 책방 그루잠 나비잠 그루잠 로운 우리는 나비잠 컴퓨터 나래 도담도담 함초롱하다 달볓 옅구름 소솜 도서관 나비잠 로운 아슬라 도르레 바람꽃 예그리나 예그리나 옅구름 우리는 예그리나 감사합니다 도담도담 이플 포도 곰다시 도서 로운 달볓 안녕 노트북 도담도담 함초롱하다 가온해 예그리나 아리아 비나리 미쁘다 별하 도서관 산들림 감사합니다 그루잠."),
                    const Divider(),
                  ]),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
      onDotClicked: animateToSlide,
      effect: const WormEffect(dotWidth: 15),
      activeIndex: activeIndex,
      count: urlImages.length);

  void animateToSlide(int index) => controller.animateToPage(index);
}

Widget buildImage(String urlImage, int index) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 5),
    child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(urlImage, fit: BoxFit.cover)));

Widget infoItem(title, context) => Column(
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
        Text(context),
      ],
    );
