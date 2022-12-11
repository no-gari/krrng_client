import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:krrng_client/repositories/hospital_repository/models/models.dart';
import 'package:krrng_client/repositories/hospital_repository/src/hospital_repository.dart';
import 'package:krrng_client/repositories/map_repository/map_repository.dart';
import 'package:krrng_client/repositories/map_repository/models/mapData.dart';
import 'package:krrng_client/repositories/map_repository/models/models.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';

part 'hospital_state.dart';

class HospitalCubit extends Cubit<HospitalState> {
  HospitalCubit(this._mapRepository, this._hospitalRepository) : super(const HospitalState());

  final MapRepository _mapRepository;
  final HospitalRepository _hospitalRepository;

  Future<void> currentPosition() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var lon = position.longitude;

    emit(state.copyWith(
      location: LatLng(lat, lon)
    ));
    currentLocation(LatLng(lat, lon));
  }

  Future<void> updatePosition(LatLng latLng) async {
    emit(state.copyWith(
      location: latLng
    ));
    currentLocation(latLng);
  }

  Future<void> currentLocation(LatLng latLng) async {
    var response = await _mapRepository.getCurruentLocation(state.location);

    response.when(success: (MapData? mapResponse) {
      final currentPlace = "${mapResponse?.region.area1.name} ${mapResponse?.region.area2.name} ${mapResponse?.region.area3.name} ${mapResponse?.land.name}";
      final details = "${mapResponse?.land.name}";

      emit(state.copyWith(
          currentPlace: currentPlace,
          addressDetail: details,
          isLoaded: true
      ));

    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          error: error,
          errorMessage: NetworkExceptions.getErrorMessage(error!)));
    });
  }

  Future<void> getHosipitals() async {
    final location = state.location;
    final selectedPart = state.selectedPart ?? HospitalPart.allDay;
    final selectedFilter = state.selectedFilter ?? HospitalFilter.distance;
    if (location != null) {
      var response = await _hospitalRepository.getHospitals(location, selectedPart, selectedFilter);

      response.when(success: (List<Hospital>? hospitals) {
        emit(state.copyWith(
          hospitals: hospitals,
          selectedPart: selectedPart,
          selectedFilter: selectedFilter
        ));
      }, failure: (NetworkExceptions? error) {
        emit(state.copyWith(
            error: error,
            errorMessage: NetworkExceptions.getErrorMessage(error!)));
      });
    }

  }
}