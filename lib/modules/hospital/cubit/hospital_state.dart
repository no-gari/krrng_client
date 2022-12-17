part of 'hospital_cubit.dart';

class HospitalState extends Equatable {
  const HospitalState({
    this.location,
    this.currentPlace,
    this.addressDetail,
    this.hospitals,
    this.selectedPart,
    this.selectedFilter,
    this.isLoaded,
    this.error,
    this.errorMessage
  });

  final LatLng? location;
  final String? currentPlace;
  final String? addressDetail;
  final List<Hospital>? hospitals;
  final HospitalPart? selectedPart;
  final HospitalFilter? selectedFilter;
  final bool? isLoaded;
  final NetworkExceptions? error;
  final String? errorMessage;

  HospitalState copyWith({
    LatLng? location,
    String? currentPlace,
    String? addressDetail,
    List<Hospital>? hospitals,
    HospitalPart? selectedPart,
    HospitalFilter? selectedFilter,
    bool? isLoaded,
    NetworkExceptions? error,
    String? errorMessage,
  }) {
    return HospitalState(
        location: location ?? this.location,
        currentPlace: currentPlace ?? this.currentPlace,
        addressDetail: addressDetail ?? this.addressDetail,
        hospitals: hospitals ?? this.hospitals,
        selectedPart: selectedPart ?? this.selectedPart,
        selectedFilter: selectedFilter ?? this.selectedFilter,
        isLoaded: isLoaded ?? this.isLoaded,
        error: error ?? this.error,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [
    location, currentPlace, addressDetail, hospitals, selectedPart, selectedFilter, isLoaded, error, errorMessage
  ];
}