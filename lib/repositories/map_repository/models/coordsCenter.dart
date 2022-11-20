import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coordsCenter.g.dart';

@JsonSerializable()
class CoordsCenter extends Equatable {
  const CoordsCenter({
    required this.crs,
    required this.x,
    required this.y
  });

  final String crs; // 좌표계 코드
  final double x;
  final double y;


  factory CoordsCenter.fromJson(Map<String, dynamic> json) => _$CoordsCenterFromJson(json);
  Map<String, dynamic> toJson() => _$CoordsCenterToJson(this);

  @override
  List<Object?> get props => [crs, x, y];

}
