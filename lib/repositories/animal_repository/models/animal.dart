import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'animal.g.dart';

@JsonSerializable()
class Animal extends Equatable {

  const Animal(
      {this.id,
      this.sort,
      this.birthday,
      this.weight,
      this.hospitalAddress,
      this.hospitalAddressDetail,
      this.interestedDisease,
      this.neuterChoices,
      this.hasAlergy,
      this.sexChoices});

  final String? id;
  final String? sort;
  final String? birthday;
  final String? weight;
  final String? hospitalAddress;
  final String? hospitalAddressDetail;
  final String? interestedDisease;
  final String? neuterChoices;
  final String? hasAlergy;
  final String? sexChoices;

  factory Animal.fromJson(Map<String, dynamic> json) => _$AnimalFromJson(json);

  Map<String, dynamic> toJson() => _$AnimalToJson(this);

  Animal copyWith({
    String? id,
    String? sort,
    String? birthday,
    String? weight,
    String? hospitalAddress,
    String? hospitalAddressDetail,
    String? interestedDisease,
    String? neuterChoices,
    String? hasAlergy,
    String? sexChoices
}) {
    return Animal(
      id: id ?? this.id,
      sort: sort ?? this.sort,
      birthday: birthday ?? this.birthday,
      hospitalAddress: hospitalAddress ?? this.hospitalAddress,
      hospitalAddressDetail: hospitalAddressDetail ?? this.hospitalAddressDetail,
      interestedDisease: interestedDisease ?? this.interestedDisease,
      neuterChoices: neuterChoices ?? this.neuterChoices,
      hasAlergy: hasAlergy ?? this.hasAlergy,
      sexChoices: sexChoices ?? this.sexChoices
    );
}

  @override
  List<Object?> get props => [
    id, sort, birthday, weight, hospitalAddress, hospitalAddressDetail, interestedDisease, neuterChoices, hasAlergy, sexChoices
  ];
}