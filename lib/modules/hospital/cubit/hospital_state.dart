part of 'hospital_cubit.dart';

class HospitalState extends Equatable {
  const HospitalState({
    this.location,
    this.currentPlace,
    this.isLoaded,
    this.error,
    this.errorMessage
  });

  final LatLng? location;
  final String? currentPlace;
  final bool? isLoaded;
  final NetworkExceptions? error;
  final String? errorMessage;

  HospitalState copyWith({
    LatLng? location,
    String? currentPlace,
    bool? isLoaded,
    NetworkExceptions? error,
    String? errorMessage,
  }) {
    return HospitalState(
        location: location ?? this.location,
        currentPlace: currentPlace ?? this.currentPlace,
        isLoaded: isLoaded ?? this.isLoaded,
        error: error ?? this.error,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [
    location, currentPlace, isLoaded, error, errorMessage
  ];
}