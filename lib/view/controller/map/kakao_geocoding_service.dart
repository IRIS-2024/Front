import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:iris_flutter/config/hidden_config.dart';
import 'package:iris_flutter/model/rev_geo_resp/address.dart';
import 'package:iris_flutter/model/rev_geo_resp/rev_geo_resp.dart';
import 'package:iris_flutter/view/comm/custom_snackbar.dart';

class KakaoGeocodingService {
  static Future<Address?> getAddrFromLatlng(double xLng, double yLat) async {
    // Revise Geocoding (convert latLng to Address) - Kakao REST API
    try {
      String kakaoRestApiKey = HiddenConfig.kakaoRestApiKey;
      const String url = 'https://dapi.kakao.com/v2/local/geo/coord2address.json';
      final Dio dio = Dio();
      dio.options.headers['Authorization'] = 'KakaoAK $kakaoRestApiKey';

      final response = await dio.get(url, queryParameters: {'x': xLng.toString(), 'y': yLat.toString()});

      log('response.statusCode: ${response.statusCode}');
      if (response.statusCode == 200) {
        log('response.data: ${response.data}');
        RevGeoResp resp = RevGeoResp.fromJson(response.data);

        if (resp.meta.total_count != 0) { // documents isNotEmpty
          if (resp.documents.first.address == null) {
            return resp.documents.first.road_address;
          } else {
            return resp.documents.first.address;
          }
        }
      }

      // 에러 처리

    } catch (error) {
      log('Error [$error] (getAddrFromLatlng)');
      return null;
    }
    // total_count == 0
    customErrorSnackBar(title: '반환된 주소 없음', message: '근처 위치로 다시 시도 해주세요.');
    return null;
  }
}