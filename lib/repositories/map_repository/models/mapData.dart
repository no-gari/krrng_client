import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'mapData.g.dart';

@JsonSerializable()
class MapData extends Equatable {
  const MapData({
    required this.name,
    required this.code,
    required this.region,
    required this.land
  });

  final String name;
  final MapCode code;
  final Land land;
  final Region region;


  factory MapData.fromJson(Map<String, dynamic> json) => _$MapDataFromJson(json);
  Map<String, dynamic> toJson() => _$MapDataToJson(this);

  @override
  List<Object?> get props => [name, code, land, region];

}
