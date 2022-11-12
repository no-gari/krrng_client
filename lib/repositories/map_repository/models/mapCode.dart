import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mapCode.g.dart';

@JsonSerializable()
class MapCode extends Equatable {
  const MapCode({required this.id, required this.mappingId, required this.type});

  final String id;
  final String mappingId;
  final String type;

  factory MapCode.fromJson(Map<String, dynamic> json) => _$MapCodeFromJson(json);
  Map<String, dynamic> toJson() => _$MapCodeToJson(this);

  @override
  List<Object?> get props => [id, mappingId, type];
}
