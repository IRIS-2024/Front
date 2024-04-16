import 'package:json_annotation/json_annotation.dart';

import 'address.dart';

part 'document.g.dart';

@JsonSerializable()
class Document {
  Address? address;
  Address? road_address;

  Document({this.address, this.road_address});

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentToJson(this);
}
