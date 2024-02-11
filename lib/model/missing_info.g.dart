// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'missing_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissingInfo _$MissingInfoFromJson(Map<String, dynamic> json) => MissingInfo(
      name: json['name'] as String,
      gender: json['gender'] as bool,
      age: json['age'] as int,
      height: json['height'] as int?,
      weight: json['weight'] as int?,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      clothes: json['clothes'] as String?,
      details: json['details'] as String?,
      bookmarked: json['bookmarked'] as bool,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      discoveredAt: DateTime.parse(json['discoveredAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$MissingInfoToJson(MissingInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'gender': instance.gender,
      'age': instance.age,
      'height': instance.height,
      'weight': instance.weight,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'clothes': instance.clothes,
      'details': instance.details,
      'images': instance.images,
      'bookmarked': instance.bookmarked,
      'discoveredAt': instance.discoveredAt.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
