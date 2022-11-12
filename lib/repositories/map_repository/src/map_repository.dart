import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:krrng_client/repositories/map_repository/models/models.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/map_client.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';

class MapRepository {
  MapRepository(this._mapClient);

  final MapClient _mapClient;

}