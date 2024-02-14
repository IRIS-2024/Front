import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/model/post.dart';
import 'package:iris_flutter/model/short_post.dart';
import 'package:iris_flutter/repository/post_repository.dart';

class MainController {
  RxList<ShortPost> postList = <ShortPost>[].obs;
  RxList<Post> markerList = <Post>[].obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  Rx<Position?> position = Rx<Position?>(null); // current location


  void getPostList() async {
    // final dio = createDio();
    // PostRepository postRepository = PostRepository(dio);
    // await postRepository
    //     .getPostList(latitude.value, longitude.value, null, null, null)
    //     .then((value) {
    //   postList.value = value;
    // }).catchError((error) {
    //   print('print e: $error');
    // });

    setTmpData();
  }

  setTmpData() {
    double sampleLatitude = 0;
    double sampleLongitude = 0;

    postList.value = [
      ShortPost(
          pid: 0,
          imgUrl:
              'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg',
          name: '김말순',
          gender: true,
          age: 85,
          address: '용산구 갈월동',
          latitude: sampleLatitude + 0.0022,
          longitude: sampleLongitude + 0.0004,
          bookmarked: false,
          disappearedAt: "2024-02-09T07:11:42.069Z",
          createdAt: "2024-02-09T07:11:42.069Z",
          updatedAt: null),
      ShortPost(
          pid: 0,
          imgUrl:
              'https://cdn.class101.net/images/587ecdf0-4329-4447-ac00-f2b25b23eab8',
          name: '김실종',
          gender: false,
          age: 7,
          address: '용산구 왕왕동',
          latitude: sampleLatitude + 0.0052,
          longitude: sampleLongitude + 0.0020,
          disappearedAt: "2024-02-12 22:57:05.427963",
          createdAt: "2024-02-12 22:57:05.427963",
          updatedAt: null,
          bookmarked: true),
      ShortPost(
          pid: 1,
          imgUrl:
              'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg',
          name: '김무무',
          gender: true,
          age: 9,
          address: '용산구 왕왕동',
          latitude: sampleLatitude + 0.0070,
          longitude: sampleLongitude + 0.0040,
          disappearedAt: "2024-02-09T07:11:42.069Z",
          createdAt: "2024-02-09T07:11:42.069Z",
          updatedAt: null,
          bookmarked: true),
    ];
  }

  setTmpMarkerData() {
    double sampleLatitude = 0;
    double sampleLongitude = 0;

    markerList.value = [
      Post(
        name: "김송송",
        age: 10,
        gender: true,
        address: "서울특별시 용산구 청파동3가 34",
        latitude: sampleLatitude + 0.0022,
        longitude: sampleLongitude + 0.0004,
        images: [
          'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg',
          'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg'
        ],
        height: 173,
        weight: 30,
        details:
            "달볓 나래 사과 책방 그루잠 나비잠 그루잠 로운 우리는 나비잠 컴퓨터 나래 도담도담 함초롱하다 달볓 옅구름 소솜 도서관 나비잠 로운 아슬라 도르레 바람꽃 예그리나 예그리나 옅구름 우리는 예그리나 감사합니다 도담도담 이플 포도 곰다시 도서 로운 달볓 안녕 노트북 도담도담 함초롱하다 가온해 예그리나 아리아 비나리 미쁘다 별하 도서관 산들림 감사합니다 그루잠",
        clothes:
            "바나나 감사합니다 아름드리 아리아 아름드리 도르레 바나나 바나나 나비잠 가온해 가온누리 여우별 별하 나래 로운 별빛 소록소록 나비잠 도서 예그리나 노트북 가온해",
        bookmarked: false,
        disappearedAt: "2024-02-09T07:11:42.069Z",
        createdAt: "2024-02-09T07:11:42.069Z",
      ),
      Post(
        name: "김랄랑",
        age: 31,
        gender: false,
        address: "서울특별시 용산구 청파동3가 34",
        latitude: sampleLatitude + 0.0052,
        longitude: sampleLongitude + 0.0020,
        images: [
          'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg',
          'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg'
        ],
        height: 120,
        weight: 90,
        details:
            "달볓 나래 사과 책방 그루잠 나비잠 그루잠 로운 우리는 나비잠 컴퓨터 나래 도담도담 함초롱하다 달볓 옅구름 소솜 도서관 나비잠 로운 아슬라 도르레 바람꽃 예그리나 예그리나 옅구름 우리는 예그리나 감사합니다 도담도담 이플 포도 곰다시 도서 로운 달볓 안녕 노트북 도담도담 함초롱하다 가온해 예그리나 아리아 비나리 미쁘다 별하 도서관 산들림 감사합니다 그루잠",
        clothes:
            "바나나 감사합니다 아름드리 아리아 아름드리 도르레 바나나 바나나 나비잠 가온해 가온누리 여우별 별하 나래 로운 별빛 소록소록 나비잠 도서 예그리나 노트북 가온해",
        bookmarked: false,
        disappearedAt: "2024-02-09T07:11:42.069Z",
        createdAt: "2024-02-09T07:11:42.069Z",
      ),
      Post(
        name: "김박박",
        age: 78,
        gender: true,
        address: "서울특별시 용산구 청파동3가 34",
        latitude: sampleLatitude + 0.0070,
        longitude: sampleLongitude + 0.0040,
        images: [
          'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg',
          'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg'
        ],
        height: 170,
        weight: 34,
        details:
            "달볓 나래 사과 책방 그루잠 나비잠 그루잠 로운 우리는 나비잠 컴퓨터 나래 도담도담 함초롱하다 달볓 옅구름 소솜 도서관 나비잠 로운 아슬라 도르레 바람꽃 예그리나 예그리나 옅구름 우리는 예그리나 감사합니다 도담도담 이플 포도 곰다시 도서 로운 달볓 안녕 노트북 도담도담 함초롱하다 가온해 예그리나 아리아 비나리 미쁘다 별하 도서관 산들림 감사합니다 그루잠",
        clothes:
            "바나나 감사합니다 아름드리 아리아 아름드리 도르레 바나나 바나나 나비잠 가온해 가온누리 여우별 별하 나래 로운 별빛 소록소록 나비잠 도서 예그리나 노트북 가온해",
        bookmarked: false,
        disappearedAt: "2024-02-09T07:11:42.069Z",
        createdAt: "2024-02-09T07:11:42.069Z",
      ),
    ];
  }
}
