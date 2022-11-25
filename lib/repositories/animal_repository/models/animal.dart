import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'animal.g.dart';

@JsonSerializable()
class Animal extends Equatable {
  const Animal(
      {this.id,
      this.sort,
      this.birthday,
      this.name,
      this.weight,
      this.image,
      this.kind,
      this.hospitalAddress,
      this.hospitalAddressDetail,
      this.interestedDisease,
      this.neuterChoices,
      this.hasAlergy,
      this.sexChoices});

  final int? id;
  final String? sort;
  final String? birthday;
  final String? name;
  final String? weight;
  final String? image;
  final String? kind;
  final String? hospitalAddress;
  final String? hospitalAddressDetail;
  final String? interestedDisease;
  final String? neuterChoices;
  final String? hasAlergy;
  final String? sexChoices;

  factory Animal.fromJson(Map<String, dynamic> json) => _$AnimalFromJson(json);

  Map<String, dynamic> toJson() => _$AnimalToJson(this);

  Animal copyWith(
      {int? id,
      String? sort,
      String? birthday,
      String? weight,
      String? name,
      String? kind,
      String? image,
      String? hospitalAddress,
      String? hospitalAddressDetail,
      String? interestedDisease,
      String? neuterChoices,
      String? hasAlergy,
      String? sexChoices}) {
    return Animal(
        id: id ?? this.id,
        sort: sort ?? this.sort,
        name: name ?? this.name,
        birthday: birthday ?? this.birthday,
        image: image ?? this.image,
        weight: weight ?? this.weight,
        kind: kind ?? this.kind,
        hospitalAddress: hospitalAddress ?? this.hospitalAddress,
        hospitalAddressDetail:
            hospitalAddressDetail ?? this.hospitalAddressDetail,
        interestedDisease: interestedDisease ?? this.interestedDisease,
        neuterChoices: neuterChoices ?? this.neuterChoices,
        hasAlergy: hasAlergy ?? this.hasAlergy,
        sexChoices: sexChoices ?? this.sexChoices);
  }

  @override
  List<Object?> get props => [
        id,
        sort,
        birthday,
        image,
        weight,
        kind,
        hospitalAddress,
        hospitalAddressDetail,
        interestedDisease,
        neuterChoices,
        hasAlergy,
        sexChoices
      ];
}
