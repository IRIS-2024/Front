import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/model/comment_img_item_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ReportTab extends StatefulWidget {
  const ReportTab({super.key});

  @override
  State<ReportTab> createState() => _ReportTabState();
}

class _ReportTabState extends State<ReportTab> {
  // urlImages = 댓글 사진 썸네일(대표 이미지)
  final urlImages = [
    'https://images.unsplash.com/photo-1612825173281-9a193378527e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=499&q=80',
    'https://images.unsplash.com/photo-1580654712603-eb43273aff33?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'https://images.unsplash.com/photo-1627916607164-7b20241db935?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
    'https://images.unsplash.com/photo-1522037576655-7a93ce0f4d10?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'https://images.unsplash.com/photo-1570829053985-56e661df1ca2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  ];

  // galleries = 댓글 하나에 등록된 여러 이미지의 모음
  List<CommentImgItemModel> galleries = [
    CommentImgItemModel(
        id: 1,
        resource:
            'https://images.unsplash.com/photo-1612825173281-9a193378527e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=499&q=80',
        isSVG: false,
        description: 'First Photo'),
    CommentImgItemModel(
        id: 2,
        resource:
            'https://images.unsplash.com/photo-1580654712603-eb43273aff33?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
        isSVG: false,
        description: 'Second Photo'),
    CommentImgItemModel(
        id: 3,
        resource:
            'https://images.unsplash.com/photo-1627916607164-7b20241db935?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
        isSVG: false,
        description: 'Third Photo'),
    CommentImgItemModel(
        id: 4,
        resource:
            'https://images.unsplash.com/photo-1522037576655-7a93ce0f4d10?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
        isSVG: false,
        description: 'Fourth Photo'),
    CommentImgItemModel(
        id: 5,
        resource:
            'https://images.unsplash.com/photo-1570829053985-56e661df1ca2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
        isSVG: false,
        description: 'Fifth Photo'),
  ];

  bool isSwitched = true;

  late int currentIndex;

  PageController pageController = PageController(initialPage: 0);

  final carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    currentIndex = 0; //  widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        // map()
        // const SizedBox(
        //   height: 300,
        //   child: MapWidget(),
        // ),
        const SizedBox(height: 12),
        Container(
            alignment: Alignment.centerRight,
            color: Colors.white,
            child: SwitchListTile(
                value: isSwitched,
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text("정확도 80% 이상"),
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    print(isSwitched);
                  });
                })),
        Container(
          color: Colors.white,
          child: ListView.separated(
            primary: false,
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width),
                      width: 100,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GestureDetector(
                            onTap: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  Dialog.fullscreen(
                                backgroundColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    PhotoViewGallery.builder(
                                      scrollPhysics:
                                          const BouncingScrollPhysics(),
                                      builder: _buildItem,
                                      itemCount: galleries.length,
                                      // loadingBuilder: loadingBuilder,
                                      backgroundDecoration: const BoxDecoration(
                                          color: Colors.transparent),
                                      pageController: pageController,
                                      onPageChanged: galleryPageChange,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          '닫기',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            child: Image.network(urlImages[index],
                                fit: BoxFit.cover),
                          ))),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                "이 텍스트는 제목이 됩니다. 이렇게",
                                style: CustomTextStyle.titleBold),
                              ),]
                            ),
                            Text("8분전", style: CustomTextStyle.small),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("옷차림", style: TextStyle(color: Theme.of(context).colorScheme.outline)),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(child: Text("산들림 비나리 소록소록 가온해 소록소록"))
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("당시 상황", style: TextStyle(color: Theme.of(context).colorScheme.outline)),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                                child: Text(
                                    "근로자는 근로조건의 향상을 위하여 자주적인 단결권·단체교섭권 및 단체행동권을 가진다. 군인은 현역을 면한 후가 아니면 국무위원으로 임명될 수 없다."))
                          ],
                        ),
                        Text("일치율 88%",
                            style: CustomTextStyle.basicBold.copyWith(
                                color: Theme.of(context).colorScheme.primary))
                      ],
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext ctx, int idx) {
              return const Divider();
            },
          ),
        )
      ]),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final item = galleries[index];
    return PhotoViewGalleryPageOptions(
        imageProvider: NetworkImage(item.resource),
        initialScale: PhotoViewComputedScale.contained,
        minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
        maxScale: PhotoViewComputedScale.contained * 1.1,
        heroAttributes: PhotoViewHeroAttributes(tag: item.id));
  }

  void galleryPageChange(int index) {
    setState() {
      currentIndex = index;
    }
  }
}
