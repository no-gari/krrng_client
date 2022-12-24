import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'available_animal.g.dart';

@JsonSerializable()
class AvailableAnimal extends Equatable {
  const AvailableAnimal({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;

  factory AvailableAnimal.fromJson(Map<String, dynamic> json) =>
      _$AvailableAnimalFromJson(json);
  Map<String, dynamic> toJson() => _$AvailableAnimalToJson(this);

  @override
  List<Object?> get props => [id, name];
}
