import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  String address_name;
  String region_1depth_name;
  String region_2depth_name;

  Address({
    required this.address_name,
    required this.region_1depth_name,
    required this.region_2depth_name,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
