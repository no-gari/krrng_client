import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'disease.g.dart';

@JsonSerializable()
class Disease extends Equatable {
  const Disease(this.name, this.id);

  final int? id;
  final String? name;

  factory Disease.fromJson(Map<String, dynamic> json) =>
      _$DiseaseFromJson(json);
  Map<String, dynamic> toJson() => _$DiseaseToJson(this);

  @override
  List<Object?> get props => [name, id];
}
