import 'package:krrng_client/repositories/hospital_repository/src/hospital_repository.dart';
import 'package:krrng_client/repositories/hospital_repository/models/hospital_detail.dart';
import 'package:krrng_client/repositories/hospital_repository/models/models.dart';
import 'package:krrng_client/repositories/map_repository/map_repository.dart';
import 'package:krrng_client/repositories/map_repository/models/mapData.dart';
import 'package:krrng_client/repositories/map_repository/models/models.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:equatable/equatable.dart';

part 'hospital_state.dart';

class HospitalCubit extends Cubit<HospitalState> {
  HospitalCubit(this._mapRepository, this._hospitalRepository)
      : super(const HospitalState(
            selectedPart: HospitalPart.everything,
            selectedFilter: HospitalFilter.distance,
            location: LatLng(37.490903970499, 127.03837557412),
            currentPlace: '강남구청역',
            addressDetail: '2번 출구',
            realLocation: LatLng(37.490903970499, 127.03837557412),
            realCurrentPlace: '강남구청역',
            isMap: false,
            realAddressDetail: '2번 출구'));

  final MapRepository _mapRepository;
  final HospitalRepository _hospitalRepository;

  void selectedFilter(String filter) {
    emit(state.copyWith(selectedFilter: HospitalFilter.getFilter(filter)));
  }

  void selectedPart(String part) {
    emit(state.copyWith(selectedPart: HospitalPart.getPart(part)));
  }

  Future<void> currentPosition() async {
    if (await Permission.location.request().isGranted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      var lat = position.latitude;
      var lon = position.longitude;

      emit(state.copyWith(location: LatLng(lat, lon)));
      currentLocation(LatLng(lat, lon));
    } else {
      var defaultLocation = LatLng(37.490903970499, 127.03837557412);
      emit(state.copyWith(location: defaultLocation));
      currentLocation(defaultLocation);
    }
  }

  Future<void> updatePosition(LatLng latLng) async {
    emit(state.copyWith(location: latLng));
    currentLocation(latLng);
  }

  Future<void> realCurrentLocation(LatLng latLng) async {
    var response = await _mapRepository.getCurruentLocation(state.location);

    response.when(success: (MapData? mapResponse) {
      final realCurrentPlace =
          "${mapResponse?.region.area1.name} ${mapResponse?.region.area2.name} ${mapResponse?.region.area3.name} ${mapResponse?.region.area4.name} ${mapResponse?.land.name} ${mapResponse?.land.number1}";
      final details = "${mapResponse?.land.name} ${mapResponse?.land.number1}";

      emit(state.copyWith(
          realLocation: latLng,
          realCurrentPlace: realCurrentPlace,
          realAddressDetail: details,
          isLoaded: true));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          error: error,
          errorMessage: NetworkExceptions.getErrorMessage(error!)));
    });
  }

  Future<void> currentLocation(LatLng latLng) async {
    var response = await _mapRepository.getCurruentLocation(state.location);

    response.when(success: (MapData? mapResponse) {
      final currentPlace =
          "${mapResponse?.region.area1.name} ${mapResponse?.region.area2.name} ${mapResponse?.region.area3.name} ${mapResponse?.region.area4.name} ${mapResponse?.land.name} ${mapResponse?.land.number1}";
      final details = "${mapResponse?.land.name} ${mapResponse?.land.number1}";

      emit(state.copyWith(
          location: latLng,
          currentPlace: currentPlace,
          addressDetail: details,
          isLoaded: true));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          location: latLng,
          isLoaded: true,
          error: error,
          errorMessage: NetworkExceptions.getErrorMessage(error!)));
    });
  }

  Future<void> getHosipitals(int disease) async {
    final location = state.realLocation;
    final selectedPart = HospitalPart.getIndex(state.selectedPart!);
    final selectedFilter = state.selectedFilter!;

    emit(state.copyWith(isLoaded: false));

    if (location != null) {
      var response = await _hospitalRepository.getHospitals(
          location, selectedPart, selectedFilter, disease);
      response.when(success: (List<Hospital>? hospitals) {
        emit(state.copyWith(isLoaded: true, hospitals: hospitals));
      }, failure: (NetworkExceptions? error) {
        emit(state.copyWith(
            error: error,
            errorMessage: NetworkExceptions.getErrorMessage(error!)));
      });
    }
  }

  Future<void> hospitalSearch(String keyword) async {
    final location = state.location;
    final selectedPart = HospitalPart.getIndex(state.selectedPart!);
    final selectedFilter = state.selectedFilter!;

    emit(state.copyWith(isLoaded: false));

    if (location != null) {
      var response = await _hospitalRepository.hospitalSearch(
          location, selectedPart, selectedFilter, keyword);
      response.when(success: (List<Hospital>? hospitals) {
        emit(state.copyWith(isLoaded: true, hospitals: hospitals));
      }, failure: (NetworkExceptions? error) {
        emit(state.copyWith(
            error: error,
            errorMessage: NetworkExceptions.getErrorMessage(error!)));
      });
    }
  }

  Future<void> getHospitalDetail(int id, bool isAuthenticated) async {
    final location = state.location;

    emit(state.copyWith(isLoaded: false));

    if (location != null) {
      var response = await _hospitalRepository.getHospitalDetail(
          location, id, isAuthenticated);
      response.when(success: (dynamic? hospital) {
        emit(state.copyWith(
            isLoaded: true, hospitalDetail: HospitalDetail.fromJson(hospital)));
      }, failure: (NetworkExceptions? error) {
        emit(state.copyWith(
            error: error,
            errorMessage: NetworkExceptions.getErrorMessage(error!)));
      });
    }
  }

  Future<void> updateIsLike(int id, bool isAuthenticated) async {
    ApiResult<dynamic> apiResult = await _hospitalRepository.updateIsLike(id);

    apiResult.when(success: (dynamic result) {
      getHospitalDetail(state.hospitalDetail!.id!, isAuthenticated);
    }, failure: (NetworkExceptions? error) {
      print(error);
    });
  }
}
