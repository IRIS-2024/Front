import 'package:flutter/material.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/model/comment_img_item_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ReportItem extends StatefulWidget {
  const ReportItem({super.key});

  @override
  State<ReportItem> createState() => _ReportItemState();
}

class _ReportItemState extends State<ReportItem> {
  @override
  void initState() {
    super.initState();
    currentIndex = 0; //  widget.initialIndex;
  }

  PageController pageController = PageController(initialPage: 0);

  late int currentIndex;

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: CustomPadding.pageInsets,
      child: Column(
        children: [
          // 제목
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "이 텍스트는 제목이 됩니다. 이렇게",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Text("8분전", style: TextStyle(fontSize: 12))
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          // 내용
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  // 이미지(썸네일)
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width),
                  width: 100,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        onTap: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => Dialog.fullscreen(
                            backgroundColor: Colors.black.withOpacity(0.5),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                PhotoViewGallery.builder(
                                  scrollPhysics: const BouncingScrollPhysics(),
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
                        child: Image.network(galleries[1].resource,
                            fit: BoxFit.cover),
                      ))),
              const SizedBox(width: 12),
              Expanded(
                // 상세 정보 글
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("옷차림", style: TextStyle(color: Colors.grey)),
                        SizedBox(
                          width: 8,
                        ),
                        Flexible(child: Text("산들림 비나리 소록소록 가온해 소록소록"))
                      ],
                    ),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("당시 상황", style: TextStyle(color: Colors.grey)),
                        SizedBox(
                          width: 8,
                        ),
                        Flexible(
                            child: Text(
                                "근로자는 근로조건의 향상을 위하여 자주적인 단결권·단체교섭권 및 단체행동권을 가진다. 군인은 현역을 면한 후가 아니면 국무위원으로 임명될 수 없다."))
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text("일치율 88%",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.primary))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
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
