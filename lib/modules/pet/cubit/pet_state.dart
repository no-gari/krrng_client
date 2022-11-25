part of 'pet_cubit.dart';

class PetState extends Equatable {
  const PetState({
    this.isEdit,
    this.id,
    this.image,
    this.name,
    this.birthday,
    this.weight,
    this.sex,
    this.allergicChoice,
    this.neutralizeChoice
});

  final bool? isEdit;
  final int? id;
  final String? image;
  final String? name;
  final String? birthday;
  final int? weight;
  final String? sex;
  final String? allergicChoice;
  final String? neutralizeChoice;

  PetState copyWith({
    bool? isEdit,
    int? id,
    String? image,
    String? name,
    String? birthday,
    int? weight,
    String? sex,
    String? allergicChoice,
    String? neutralizeChoice
  }) {
    return PetState(
      isEdit: isEdit ?? this.isEdit,
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      weight: weight ?? this.weight,
      sex: sex ?? this.sex,
      allergicChoice: allergicChoice ?? this.allergicChoice,
      neutralizeChoice: neutralizeChoice ?? this.neutralizeChoice
    );
  }

  @override
  List<Object?> get props => [
    isEdit, id, image, name, birthday, weight, sex, allergicChoice, neutralizeChoice
  ];
}