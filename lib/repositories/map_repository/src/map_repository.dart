import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:krrng_client/repositories/map_repository/models/models.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/dio_client.dart';
import 'package:krrng_client/support/networks/map_client.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';

class MapRepository {
  MapRepository(this._mapClient);

  final MapClient _mapClient;

  // MARK: static json으로 api 요청 대체
  Future<ApiResult<MapData?>> getCurruentLocation(LatLng? latLng) async {
    // try {
    var lat = latLng?.latitude.toString() ?? "";
    var lon = latLng?.longitude.toString() ?? "";

    var response = await _mapClient.get(
        '/map-reversegeocode/v2/gc?request=coordsToaddr&coords=${lon},${lat}&sourcecrs=epsg:4326&orders=roadaddr&output=json');
    var mapResponse = MapResponse.fromJson(response);

    if (mapResponse.status.code == 0) {
      return ApiResult.success(data: mapResponse.results.first);
    } else {
      return ApiResult.failure(
          error: NetworkExceptions.defaultError(mapResponse.status.message));
    }
  }
}
