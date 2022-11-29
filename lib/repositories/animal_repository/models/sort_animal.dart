import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:krrng_client/repositories/animal_repository/models/kind.dart';

part 'sort_animal.g.dart';

@JsonSerializable()
class SortAnimal extends Equatable {
  const SortAnimal({this.sort, this.kinds});

  final String? sort;
  final List<Kind>? kinds;

  factory SortAnimal.fromJson(Map<String, dynamic> json) =>
      _$SortAnimalFromJson(json);

  Map<String, dynamic> toJson() => _$SortAnimalToJson(this);

  SortAnimal copyWith({
    String? sort,
    List<Kind>? kinds,
  }) {
    return SortAnimal(sort: sort ?? this.sort, kinds: kinds ?? this.kinds);
  }

  @override
  List<Object?> get props => [
        sort,
        kinds,
      ];
}
