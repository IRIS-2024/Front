import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  int pid;
  String discoverAt;
  String address;
  double latitude;
  double longitude;
  String? clothes;
  String? detail;
  List<String> images;

  Comment({
    required this.pid,
    required this.discoverAt,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.clothes,
    this.detail,
    required this.images,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
