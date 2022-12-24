part of 'hospital_cubit.dart';

class HospitalState extends Equatable {
  const HospitalState(
      {this.location,
      this.currentPlace,
      this.tempCurrentPlace,
      this.addressDetail,
      this.hospitals,
      this.hospitalDetail,
      this.selectedPart,
      this.selectedFilter,
      this.isLoaded,
      this.error,
      this.errorMessage});

  final LatLng? location;
  final String? currentPlace;
  final String? tempCurrentPlace;
  final String? addressDetail;
  final List<Hospital>? hospitals;
  final HospitalDetail? hospitalDetail;
  final HospitalPart? selectedPart;
  final HospitalFilter? selectedFilter;
  final bool? isLoaded;
  final NetworkExceptions? error;
  final String? errorMessage;

  HospitalState copyWith({
    LatLng? location,
    String? currentPlace,
    String? tempCurrentPlace,
    String? addressDetail,
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
        currentPlace: currentPlace ?? this.currentPlace,
        tempCurrentPlace: tempCurrentPlace ?? this.tempCurrentPlace,
        addressDetail: addressDetail ?? this.addressDetail,
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
        currentPlace,
        tempCurrentPlace,
        addressDetail,
        hospitals,
        hospitalDetail,
        selectedPart,
        selectedFilter,
        isLoaded,
        error,
        errorMessage
      ];
}
