import 'package:json_annotation/json_annotation.dart';
import 'comment.dart';

part 'my_comments_response.g.dart';

@JsonSerializable()
class MyCommentsResp {
  String name;
  String imgUrl;
  int age;
  bool gender;
  String address;
  List<Comment> commentList;

  MyCommentsResp(
      {required this.name,
      required this.imgUrl,
      required this.age,
      required this.gender,
      required this.address,
      required this.commentList});

  factory MyCommentsResp.fromJson(Map<String, dynamic> json) =>
      _$MyCommentsRespFromJson(json);

  Map<String, dynamic> toJson() => _$MyCommentsRespToJson(this);
}
