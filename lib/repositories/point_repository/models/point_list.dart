import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:krrng_client/repositories/point_repository/models/point.dart';

part 'point_list.g.dart';

@JsonSerializable()
class PointList extends Equatable {
  const PointList(this.points, this.totalPoint);

  final List<Point>? points;
  final int? totalPoint;

  factory PointList.fromJson(Map<String, dynamic> json) =>
      _$PointListFromJson(json);
  Map<String, dynamic> toJson() => _$PointListToJson(this);

  @override
  List<Object?> get props => [points, totalPoint];
}
