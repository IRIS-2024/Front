// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      address_name: json['address_name'] as String,
      region_1depth_name: json['region_1depth_name'] as String,
      region_2depth_name: json['region_2depth_name'] as String,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'address_name': instance.address_name,
      'region_1depth_name': instance.region_1depth_name,
      'region_2depth_name': instance.region_2depth_name,
    };
