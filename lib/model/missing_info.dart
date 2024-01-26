import 'package:json_annotation/json_annotation.dart';

part 'missing_info.g.dart';

@JsonSerializable()
class MissingInfo {
  int post_id;
  int member_id;
  bool isDone;
  String missingName;
  String missingGender;
  String missingAge;
  String? missingHeight;
  String? missingWeight;
  String? missingLocation;
  String? missingClothes;
  String? detail;
  DateTime createdAt;
  DateTime? updatedAt;

  MissingInfo({
    required this.post_id,
    required this.member_id,
    required this.isDone,
    required this.missingName,
    required this.missingGender,
    required this.missingAge,
    this.missingHeight,
    this.missingWeight,
    this.missingLocation,
    this.missingClothes,
    this.detail,
    required this.createdAt,
    this.updatedAt
  });

  factory MissingInfo.fromJson(Map<String, dynamic> json) => _$MissingInfoFromJson(json);

  Map<String, dynamic> toJson() => _$MissingInfoToJson(this);
}
