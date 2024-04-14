// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) => Document(
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      road_address: json['road_address'] == null
          ? null
          : Address.fromJson(json['road_address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'address': instance.address,
      'road_address': instance.road_address,
    };
