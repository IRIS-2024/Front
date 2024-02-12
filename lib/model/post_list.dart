import 'package:json_annotation/json_annotation.dart';

part 'post_list.g.dart';

@JsonSerializable()
class PostList {
  int pid;
  String imgUrl;
  String name;
  int age;
  String address;
  String disappearedAt;
  String createdAt;
  String? updatedAt;
  bool bookmarked;

  PostList({
    required this.pid,
    required this.imgUrl,
    required this.name,
    required this.age,
    required this.address,
    required this.disappearedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.bookmarked,
  });

  factory PostList.fromJson(Map<String, dynamic> json) =>
      _$PostListFromJson(json);

  Map<String, dynamic> toJson() => _$PostListToJson(this);
}
