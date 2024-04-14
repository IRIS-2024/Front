import 'package:json_annotation/json_annotation.dart';

import 'document.dart';
import 'meta.dart';

part 'rev_geo_resp.g.dart';

@JsonSerializable(explicitToJson: true)
class RevGeoResp {
  Meta meta;
  List<Document> documents;

  RevGeoResp({
    required this.meta,
    required this.documents,
  });

  factory RevGeoResp.fromJson(Map<String, dynamic> json) => _$RevGeoRespFromJson(json);

  Map<String, dynamic> toJson() => _$RevGeoRespToJson(this);
}

