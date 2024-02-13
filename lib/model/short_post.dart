import 'package:json_annotation/json_annotation.dart';

part 'short_post.g.dart';

@JsonSerializable()
class shortPost {
  int pid;
  String imgUrl;
  String name;
  int age;
  String address;
  String disappearedAt;
  String createdAt;
  String updatedAt;
  bool bookmarked;

  shortPost({
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

  factory shortPost.fromJson(Map<String, dynamic> json) =>
      _$shortPostFromJson(json);

  Map<String, dynamic> toJson() => _$shortPostToJson(this);
}
