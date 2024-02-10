import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  int pid;
  String address;
  double latitude;
  double longitude;
  String? clothes;
  String? details;
  List<String> images;
  DateTime discoveredAt;
  DateTime createdAt;
  DateTime? updatedAt;

  Comment({
    required this.pid,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.clothes,
    this.details,
    required this.images,
    required this.discoveredAt,
    required this.createdAt,
    this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
