import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'area.g.dart';

@JsonSerializable()
class Area extends Equatable {
  const Area({
    required this.name,
    required this.coords,
    this.alias
  });

  final String name;
  final Coords coords;
  final String? alias;


  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);
  Map<String, dynamic> toJson() => _$AreaToJson(this);

  @override
  List<Object?> get props => [name, coords, alias];

}
