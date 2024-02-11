import 'package:json_annotation/json_annotation.dart';

part 'missing_info.g.dart';

@JsonSerializable()
class MissingInfo {
  String name;
  bool gender;
  int age;
  int? height;
  int? weight;
  String address;
  double latitude;
  double longitude;
  String? clothes;
  String? details;
  bool bookmarked;
  List<String> images;
  String discoveredAt;
  String createdAt;
  String? updatedAt;

  MissingInfo({
    required this.name,
    required this.gender,
    required this.age,
    this.height,
    this.weight,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.clothes,
    this.details,
    required this.bookmarked,
    required this.images,
    required this.discoveredAt,
    required this.createdAt,
    this.updatedAt,
  });

  factory MissingInfo.fromJson(Map<String, dynamic> json) => _$MissingInfoFromJson(json);

  Map<String, dynamic> toJson() => _$MissingInfoToJson(this);
}
