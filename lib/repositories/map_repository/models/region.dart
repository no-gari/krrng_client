import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'region.g.dart';

@JsonSerializable()
class Region extends Equatable {
  const Region({
    required this.area0,
    required this.area1,
    required this.area2,
    required this.area3,
    required this.area4
  });

  final Area area0;
  final Area area1;
  final Area area2;
  final Area area3;
  final Area area4;

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
  Map<String, dynamic> toJson() => _$RegionToJson(this);

  @override
  List<Object?> get props => [area0, area1, area2, area3, area4];

}
