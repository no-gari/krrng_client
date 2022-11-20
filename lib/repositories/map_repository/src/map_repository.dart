import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:krrng_client/repositories/map_repository/models/models.dart';
import 'package:krrng_client/support/networks/api_result.dart';
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

      // var response = await _mapClient.get('/map-reversegeocode/v2/gc?request=coordsToaddr&coords=${lon},${lat}&sourcecrs=epsg:4326&orders=roadaddr&output=json');
      var response = {"status":{"code":0,"name":"ok","message":"done"},"results":[{"name":"roadaddr","code":{"id":"4113510300","type":"L","mappingId":"02135103"},"region":{"area0":{"name":"kr","coords":{"center":{"crs":"","x":0.0,"y":0.0}}},"area1":{"name":"경기도","coords":{"center":{"crs":"EPSG:4326","x":127.550802,"y":37.4363177}},"alias":"경기"},"area2":{"name":"성남시 분당구","coords":{"center":{"crs":"EPSG:4326","x":127.1189255,"y":37.3828195}}},"area3":{"name":"정자동","coords":{"center":{"crs":"EPSG:4326","x":127.1115333,"y":37.3614503}}},"area4":{"name":"","coords":{"center":{"crs":"","x":0.0,"y":0.0}}}},"land":{"type":"","number1":"19","number2":"","addition0":{"type":"building","value":""},"addition1":{"type":"zipcode","value":"13610"},"addition2":{"type":"roadGroupCode","value":"411354340042"},"addition3":{"type":"","value":""},"addition4":{"type":"","value":""},"name":"느티로51번길","coords":{"center":{"crs":"","x":0.0,"y":0.0}}}}]};
      var mapResponse = MapResponse.fromJson(response);

      if (mapResponse.status.code == 0) {
        return ApiResult.success(data: mapResponse.results.first);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(mapResponse.status.message));
      }

    // } catch (e) {
    //   return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    // }
  }
}