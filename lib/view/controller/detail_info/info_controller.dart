import 'package:get/get.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/model/missing_info.dart';
import 'package:iris_flutter/repository/info_repository.dart';

class InfoController extends GetxController {
  Rx<MissingInfo> missingInfo = MissingInfo(
    name: "",
    gender: true,
    age: 0,
    address: "",
    latitude: 0.0,
    longitude: 0.0,
    bookmarked: false,
    images: [""],
    discoveredAt: DateTime.now(),
    createdAt: DateTime.now(),
  ).obs;

  List<String> urlImages = [
    'https://images.unsplash.com/photo-1627916607164-7b20241db935?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
    'https://images.unsplash.com/photo-1522037576655-7a93ce0f4d10?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'https://images.unsplash.com/photo-1570829053985-56e661df1ca2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'https://images.unsplash.com/photo-1612825173281-9a193378527e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=499&q=80',
    'https://images.unsplash.com/photo-1580654712603-eb43273aff33?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  ];

  // Future<void> loadData() async {
  //   // /post/{post_id}
  //   try {
  //     // 임시
  //     int postId = 1;
  //     final dio = createDio();
  //     final InfoRepository infoRepository = InfoRepository(dio);
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
    MissingInfo loadData = MissingInfo(
      name: "김송송",
      age: 10,
      gender: true,
      address: "서울특별시 용산구 청파동3가 34",
      latitude: 37.543926,
      longitude: 126.969633,
      images: urlImages,
      height: 140,
      weight: 30,
      details:
          "달볓 나래 사과 책방 그루잠 나비잠 그루잠 로운 우리는 나비잠 컴퓨터 나래 도담도담 함초롱하다 달볓 옅구름 소솜 도서관 나비잠 로운 아슬라 도르레 바람꽃 예그리나 예그리나 옅구름 우리는 예그리나 감사합니다 도담도담 이플 포도 곰다시 도서 로운 달볓 안녕 노트북 도담도담 함초롱하다 가온해 예그리나 아리아 비나리 미쁘다 별하 도서관 산들림 감사합니다 그루잠",
      clothes:
          "바나나 감사합니다 아름드리 아리아 아름드리 도르레 바나나 바나나 나비잠 가온해 가온누리 여우별 별하 나래 로운 별빛 소록소록 나비잠 도서 예그리나 노트북 가온해",
      bookmarked: false,
      discoveredAt: DateTime.now(),
      createdAt: DateTime.now(),
    );

    missingInfo.value = loadData;
  }
}
