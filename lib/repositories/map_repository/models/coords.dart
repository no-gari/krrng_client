import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:krrng_client/repositories/map_repository/models/coordsCenter.dart';

part 'coords.g.dart';

@JsonSerializable()
class Coords extends Equatable {
  const Coords({
    required this.center
  });

  final CoordsCenter center;


  factory Coords.fromJson(Map<String, dynamic> json) => _$CoordsFromJson(json);
  Map<String, dynamic> toJson() => _$CoordsToJson(this);

  @override
  List<Object?> get props => [center];

}
