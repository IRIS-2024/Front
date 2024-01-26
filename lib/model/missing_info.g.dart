// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'missing_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissingInfo _$MissingInfoFromJson(Map<String, dynamic> json) => MissingInfo(
      post_id: json['post_id'] as int,
      member_id: json['member_id'] as int,
      isDone: json['isDone'] as bool,
      missingName: json['missingName'] as String,
      missingGender: json['missingGender'] as String,
      missingAge: json['missingAge'] as String,
      missingHeight: json['missingHeight'] as String?,
      missingWeight: json['missingWeight'] as String?,
      missingLocation: json['missingLocation'] as String?,
      missingClothes: json['missingClothes'] as String?,
      detail: json['detail'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$MissingInfoToJson(MissingInfo instance) =>
    <String, dynamic>{
      'post_id': instance.post_id,
      'member_id': instance.member_id,
      'isDone': instance.isDone,
      'missingName': instance.missingName,
      'missingGender': instance.missingGender,
      'missingAge': instance.missingAge,
      'missingHeight': instance.missingHeight,
      'missingWeight': instance.missingWeight,
      'missingLocation': instance.missingLocation,
      'missingClothes': instance.missingClothes,
      'detail': instance.detail,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
