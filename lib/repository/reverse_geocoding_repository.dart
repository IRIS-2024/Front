import 'package:iris_flutter/model/rev_geo_resp/rev_geo_resp.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'reverse_geocoding_repository.g.dart';

@RestApi()
abstract class ReverseGeocodingRepository {
  factory ReverseGeocodingRepository(Dio dio, {String baseUrl}) = _ReverseGeocodingRepository;

  @GET('https://dapi.kakao.com/v2/local/geo/coord2address.json')
  Future<RevGeoResp> getRevGeo(@Query('x') double xLng, @Query('y') double yLat, @Header('Authorization') String authorization);
}