import 'package:json_annotation/json_annotation.dart';

part 'noti_setting.g.dart';

@JsonSerializable()
class NotiSetting {
  String? region;
  String? deviceToken;

  NotiSetting({
    this.region,
    this.deviceToken,
  });

  factory NotiSetting.fromJson(Map<String, dynamic> json) => _$NotiSettingFromJson(json);

  Map<String, dynamic> toJson() => _$NotiSettingToJson(this);
}
