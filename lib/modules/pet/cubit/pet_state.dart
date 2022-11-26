part of 'pet_cubit.dart';

class PetState extends Equatable {
  const PetState({
    this.id,
    this.image,
    this.sort,
    this.kind,
    this.name,
    this.birthday,
    this.weight,
    this.sex,
    this.hospitalAddress,
    this.hospitalAddressDetail,
    this.interestedDisease,
    this.allergicChoice,
    this.neutralizeChoice,
    this.error,
    this.errorMessage,
});

  final int? id;
  final String? image;
  final String? sort;
  final String? kind;
  final String? name;
  final String? birthday;
  final String? weight;
  final String? sex;
  final String? hospitalAddress;
  final String? hospitalAddressDetail;
  final String? interestedDisease;
  final String? allergicChoice;
  final String? neutralizeChoice;
  final NetworkExceptions? error;
  final String? errorMessage;

  PetState copyWith({
    int? id,
    String? image,
    String? sort,
    String? kind,
    String? name,
    String? birthday,
    String? weight,
    String? sex,
    String? hospitalAddress,
    String? hospitalAddressDetail,
    String? interestedDisease,
    String? allergicChoice,
    String? neutralizeChoice,
    NetworkExceptions? error,
    String? errorMessage,
  }) {
    return PetState(
      id: id ?? this.id,
      image: image ?? this.image,
      kind: kind ?? this.kind,
      sort: sort ?? this.sort,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      weight: weight ?? this.weight,
      sex: sex ?? this.sex,
      hospitalAddress: hospitalAddress ?? this.hospitalAddress,
      hospitalAddressDetail: hospitalAddressDetail ?? this.hospitalAddressDetail,
      interestedDisease: interestedDisease ?? this.interestedDisease,
      allergicChoice: allergicChoice ?? this.allergicChoice,
      neutralizeChoice: neutralizeChoice ?? this.neutralizeChoice,
      error: error ?? this.error,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [
    id, image, sort, kind, name, birthday, weight, sex,
    hospitalAddress, hospitalAddressDetail,
    interestedDisease, allergicChoice, neutralizeChoice,
    error, errorMessage
  ];
}