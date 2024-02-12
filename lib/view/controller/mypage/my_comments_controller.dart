import 'package:get/get.dart';
import 'package:iris_flutter/model/comment.dart';
import 'package:iris_flutter/model/my_comments_response.dart';

class MyCommentsController extends GetxController {
  RxList<MyCommentsResp> commentsList = <MyCommentsResp>[].obs;
  RxInt currentIndex = 0.obs;

  void loadData() {
    print("작성한 제보 댓글 - loadData");
    List<MyCommentsResp> tmpdata = [
      MyCommentsResp(
          name: "실종자1",
          age: 1,
          imgUrl:
              'https://images.unsplash.com/photo-1612825173281-9a193378527e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=499&q=80',
          gender: true,
          address: "서울시 동대문구 한천로 1길 11",
          commentList: [
            Comment(
                cid: 1,
                title: "서울시 청파동 1가 11",
                latitude: 37.545176,
                longitude: 126.962722,
                images: [
                  'https://images.unsplash.com/photo-1612825173281-9a193378527e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=499&q=80',
                  'https://images.unsplash.com/photo-1580654712603-eb43273aff33?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'
                ],
                accuracy: 78,
                clothes: "옷차림1은 이렇습니다.",
                details:
                    "발견 당시 특이사항1은 이랬습니다. 친구와 같이 있는 듯 보였는데 큰 이상은 없어보여서 긴가민가했습니다. 지나고보니 맞을수도 있다고 생각해서 제보를 올립니다.",
                discoveredAt: "2024-02-09T07:11:42.069Z",
                createdAt: "2024-02-09T07:11:42.069Z"),
            Comment(
                cid: 2,
                title: "서울시 청파동 2가 21",
                latitude: 37.545176,
                longitude: 126.962722,
                images: [
                  'https://images.unsplash.com/photo-1522037576655-7a93ce0f4d10?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                  'https://images.unsplash.com/photo-1570829053985-56e661df1ca2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'
                ],
                accuracy: 88,
                clothes: "옷차림2은 이렇습니다.",
                details:
                    "발견 당시 특이사항2은 이랬습니다. 친구와 같이 있는 듯 보였는데 큰 이상은 없어보여서 긴가민가했습니다. 지나고보니 맞을수도 있다고 생각해서 제보를 올립니다.",
                discoveredAt: "2024-02-09T07:11:42.069Z",
                createdAt: "2024-02-09T07:11:42.069Z")
          ]),
      MyCommentsResp(
          name: "실종자2",
          age: 2,
          imgUrl:
              'https://images.unsplash.com/photo-1580654712603-eb43273aff33?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
          gender: true,
          address: "서울시 동대문구 한천로 2길 22",
          commentList: [
            Comment(
                cid: 3,
                title: "서울시 청파동 3가 33",
                latitude: 37.545176,
                longitude: 126.962722,
                images: [
                  'https://images.unsplash.com/photo-1580654712603-eb43273aff33?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                  'https://images.unsplash.com/photo-1627916607164-7b20241db935?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
                ],
                accuracy: 80,
                clothes: "옷차림3은 이렇습니다.",
                details:
                    "발견 당시 특이사항3는 이랬습니다. 친구와 같이 있는 듯 보였는데 큰 이상은 없어보여서 긴가민가했습니다. 지나고보니 맞을수도 있다고 생각해서 제보를 올립니다.",
                discoveredAt: "2024-02-09T07:11:42.069Z",
                createdAt: "2024-02-09T07:11:42.069Z")
          ])
    ];

    commentsList.value = tmpdata;
  }

  void changeImgSlideIdx(int index) {
    currentIndex.value = index;
  }
}
