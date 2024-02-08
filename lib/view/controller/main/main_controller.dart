import 'package:get/get.dart';
import 'package:iris_flutter/model/missing_info.dart';

class MainController {
  RxList<MissingInfo> missingInfoList = <MissingInfo>[].obs;

  setTmpData() {
    missingInfoList.value = [
      MissingInfo(name: '김말순',
          gender: true,
          age: 85,
          height: 160,
          weight: 45,
          address: '용산구 갈월동',
          latitude: 37.545144,
          longitude: 126.964381,
          clothes: '빨간 숏패딩, 검은 슬랙스, 분홍색 운동화',
          details: '치매가 있으십니다. 보통 모두를 언니라고 칭합니다.',
          images: [
            'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg',
          ]),
      MissingInfo(name: '김실종',
          gender: false,
          age: 7,
          height: 120,
          weight: 43,
          address: '용산구 왕왕동',
          latitude: 37.545144,
          longitude: 126.964381,
          clothes: '빨간 반팔, 청바지, 은색 운동화, 파랑 캡모자',
          details: '축구 공을 가지고 놀고 있었습니다. 또래에 비해 체구가 작습니다. 강아지를 쫓아다니는 특이행동을 합니다. 실종 당시 강아지를 쫓아가다 실종 되었습니다.',
          images: [
            'https://cdn.class101.net/images/587ecdf0-4329-4447-ac00-f2b25b23eab8',
            'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg',
          ]),
    ];
  }
}
