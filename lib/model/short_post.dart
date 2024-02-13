import 'package:json_annotation/json_annotation.dart';

part 'short_post.g.dart';

@JsonSerializable()
class ShortPost {
  int pid;
  String imgUrl;
  String name;
  int age;
  String address;
  String disappearedAt;
  String createdAt;
  String? updatedAt;
  bool bookmarked;

  ShortPost({
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

  factory ShortPost.fromJson(Map<String, dynamic> json) => _$ShortPostFromJson(json);

  Map<String, dynamic> toJson() => _$ShortPostToJson(this);
}