import 'package:get/get.dart';
import 'package:iris_flutter/model/missing_info.dart';
import 'package:iris_flutter/model/photo.dart';

class MainController {
  RxList<MissingInfo> missingInfoList = <MissingInfo>[].obs;
  Rx<Photo> photo = Photo(
          photo_id: 0,
          uuid: 0,
          url: '',
          createdAt: DateTime.now(),
          post_id: 0,
          member_id: 0)
      .obs;

  setTmpData() {
    missingInfoList.value = [
      MissingInfo(
          post_id: 1,
          member_id: 1,
          isDone: false,
          missingName: '김말순',
          missingGender: '여자',
          missingAge: '85',
          missingHeight: '160',
          missingWeight: '45',
          missingLocation: '용산구 갈월동',
          missingClothes: '빨간 숏패딩, 검은 슬랙스, 분홍색 운동화',
          detail: '치매가 있으십니다.',
          createdAt: DateTime.now()),
      MissingInfo(
          post_id: 1,
          member_id: 2,
          isDone: false,
          missingName: '김실종',
          missingGender: '남자',
          missingAge: '7',
          missingHeight: '120',
          missingWeight: '43',
          missingLocation: '용산구 왕왕동',
          missingClothes: '빨간 반팔, 청바지, 은색 운동화, 파랑 캡모자',
          detail:
              '축구 공을 가지고 놀고 있었습니다. 또래에 비해 체구가 작습니다. 강아지를 쫓아다니는 특이행동을 합니다. 실종 당시 강아지를 쫓아가다 실종 되었습니다.',
          createdAt: DateTime.now())
    ];

    photo.value = Photo(
        photo_id: 1,
        uuid: 1,
        url:
            'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg',
        createdAt: DateTime.now(),
        post_id: 1,
        member_id: 2);
    photo.value = Photo(
        photo_id: 1,
        uuid: 1,
        url:
            'https://cdn.class101.net/images/587ecdf0-4329-4447-ac00-f2b25b23eab8',
        createdAt: DateTime.now(),
        post_id: 1,
        member_id: 1);
  }
}
