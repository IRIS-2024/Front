import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  int cid;
  String title;
  double latitude;
  double longitude;
  String? clothes;
  String? details;
  int? accuracy;
  List<String> images;
  String discoveredAt;
  String createdAt;
  String? updatedAt;

  Comment({
    required this.cid,
    required this.title,
    required this.latitude,
    required this.longitude,
    this.clothes,
    this.details,
    required this.images,
    this.accuracy,
    required this.discoveredAt,
    required this.createdAt,
    this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
