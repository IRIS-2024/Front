import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:iris_flutter/config/hidden_config.dart';
import 'package:iris_flutter/model/rev_geo_resp/address.dart';
import 'package:iris_flutter/model/rev_geo_resp/rev_geo_resp.dart';
import 'package:iris_flutter/repository/reverse_geocoding_repository.dart';

class ReverseGeocodingService {
  static Future<Address?> getAddrFromLatlng(double xLng, double yLat) async {
    // Revise Geocoding (convert latLng to Address) - Kakao REST API
    final Dio dio = Dio();
    ReverseGeocodingRepository revGeoRepository = ReverseGeocodingRepository(dio);
    try {
      RevGeoResp resp = await revGeoRepository.getRevGeo(xLng, yLat, 'KakaoAK ${HiddenConfig.kakaoRestApiKey}');

      if (resp.meta.total_count != 0) {
        if (resp.documents.first.address == null) {
          return resp.documents.first.road_address;
        } else {
          return resp.documents.first.address;
        }
      }
    } catch (error) {
      log('Error [$error] (getAddrFromLatlng)');
    }
    return null;
  }
}
