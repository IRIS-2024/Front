// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Photo _$PhotoFromJson(Map<String, dynamic> json) => Photo(
      photo_id: json['photo_id'] as int,
      uuid: json['uuid'] as int?,
      url: json['url'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      post_id: json['post_id'] as int,
      member_id: json['member_id'] as int,
    );

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'photo_id': instance.photo_id,
      'uuid': instance.uuid,
      'url': instance.url,
      'createdAt': instance.createdAt.toIso8601String(),
      'post_id': instance.post_id,
      'member_id': instance.member_id,
    };
