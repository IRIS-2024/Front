// 실종 정보 페이지 > 상세 내용 탭에서 사용될 view model

import 'package:get/get.dart';
import 'package:iris_flutter/model/location.dart';
import 'package:iris_flutter/model/post.dart';

class DetailController extends GetxController {
  // 하나의 실종 정보 글에 대한 정보를 담음
  Rx<Post> post = Post(
    name: "",
    gender: true,
    age: 0,
    address: "",
    latitude: 0.0,
    longitude: 0.0,
    bookmarked: false,
    images: [""],
    disappearedAt: '',
    createdAt: '',
  ).obs;

  RxList<Location> markersList = <Location>[].obs;

  // Future<void> loadData() async {
  //   // /post/{post_id}
  //   try {
  //     // 임시
  //     int postId = 1;
  //     final dio = createDio();
  //     final PostRepository infoRepository = PostRepository(dio);
  //     final response = await infoRepository.getInfo(postId);
  //     //infoDetail.value = response;
  //     //infoDetail.refresh();
  //     print(response);
  //   } catch (error) {
  //     // 에러 처리
  //     print('Error fetching info detail: $error');
  //   }
  // }

  void loadData() {
    Post loadData = Post(
      name: "김송송",
      age: 10,
      gender: true,
      address: "서울특별시 용산구 청파동3가 34",
      latitude: 37.543926,
      longitude: 126.969633,
      images: [
        'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg',
        'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg'
      ],
      height: 140,
      weight: 30,
      details:
          "달볓 나래 사과 책방 그루잠 나비잠 그루잠 로운 우리는 나비잠 컴퓨터 나래 도담도담 함초롱하다 달볓 옅구름 소솜 도서관 나비잠 로운 아슬라 도르레 바람꽃 예그리나 예그리나 옅구름 우리는 예그리나 감사합니다 도담도담 이플 포도 곰다시 도서 로운 달볓 안녕 노트북 도담도담 함초롱하다 가온해 예그리나 아리아 비나리 미쁘다 별하 도서관 산들림 감사합니다 그루잠",
      clothes:
          "바나나 감사합니다 아름드리 아리아 아름드리 도르레 바나나 바나나 나비잠 가온해 가온누리 여우별 별하 나래 로운 별빛 소록소록 나비잠 도서 예그리나 노트북 가온해",
      bookmarked: false,
      disappearedAt: "2024-02-09T07:11:42.069Z",
      createdAt: "2024-02-09T07:11:42.069Z",
    );

    post.value = loadData;

    List<Location> loadLocationData = [
      Location(
          location_id: 1, // 실종 위치
          latitude: 37.543926,
          longitude: 126.969633,
          address: "서울특별시 용산구 청파동3가 34"),
      Location(
          location_id: 2, // 댓글 pid에 따라
          latitude: 37.545555,
          longitude: 126.963250,
          address: "서울특별시 용산구 청파동2가 134-6"),
      Location(
          location_id: 3,
          latitude: 37.544562,
          longitude: 126.962961,
          address: "서울특별시 용산구 청파동2가"),
    ];
    markersList.value = loadLocationData;
  }
}
