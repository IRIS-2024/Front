// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rev_geo_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RevGeoResp _$RevGeoRespFromJson(Map<String, dynamic> json) => RevGeoResp(
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      documents: (json['documents'] as List<dynamic>)
          .map((e) => Document.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RevGeoRespToJson(RevGeoResp instance) =>
    <String, dynamic>{
      'meta': instance.meta.toJson(),
      'documents': instance.documents.map((e) => e.toJson()).toList(),
    };
