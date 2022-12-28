part of 'hospital_cubit.dart';

class HospitalState extends Equatable {
  const HospitalState(
      {this.location,
      this.realLocation,
      this.currentPlace,
      this.realCurrentPlace,
      this.addressDetail,
      this.realAddressDetail,
      this.hospitals,
      this.hospitalDetail,
      this.selectedPart,
      this.selectedFilter,
      this.isLoaded,
      this.error,
      this.errorMessage});

  final LatLng? location;
  final LatLng? realLocation;
  final String? currentPlace;
  final String? realCurrentPlace;
  final String? addressDetail;
  final String? realAddressDetail;
  final List<Hospital>? hospitals;
  final HospitalDetail? hospitalDetail;
  final HospitalPart? selectedPart;
  final HospitalFilter? selectedFilter;
  final bool? isLoaded;
  final NetworkExceptions? error;
  final String? errorMessage;

  HospitalState copyWith({
    LatLng? location,
    LatLng? realLocation,
    String? currentPlace,
    String? realCurrentPlace,
    String? addressDetail,
    String? realAddressDetail,
    List<Hospital>? hospitals,
    HospitalDetail? hospitalDetail,
    HospitalPart? selectedPart,
    HospitalFilter? selectedFilter,
    bool? isLoaded,
    NetworkExceptions? error,
    String? errorMessage,
  }) {
    return HospitalState(
        location: location ?? this.location,
        realLocation: realLocation ?? this.realLocation,
        currentPlace: currentPlace ?? this.currentPlace,
        realCurrentPlace: realCurrentPlace ?? this.realCurrentPlace,
        addressDetail: addressDetail ?? this.addressDetail,
        realAddressDetail: realAddressDetail ?? this.realAddressDetail,
        hospitals: hospitals ?? this.hospitals,
        hospitalDetail: hospitalDetail ?? this.hospitalDetail,
        selectedPart: selectedPart ?? this.selectedPart,
        selectedFilter: selectedFilter ?? this.selectedFilter,
        isLoaded: isLoaded ?? this.isLoaded,
        error: error ?? this.error,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [
        location,
        realLocation,
        currentPlace,
        realCurrentPlace,
        addressDetail,
        realAddressDetail,
        hospitals,
        hospitalDetail,
        selectedPart,
        selectedFilter,
        isLoaded,
        error,
        errorMessage
      ];
}
