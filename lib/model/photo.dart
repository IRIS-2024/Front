import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart';

@JsonSerializable()
class Photo {
  int photo_id;
  int? uuid;
  String? url;
  DateTime createdAt;
  int post_id;
  int member_id;

  Photo({
    required this.photo_id,
    this.uuid,
    this.url,
    required this.createdAt,
    required this.post_id,
    required this.member_id,

  });

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}
