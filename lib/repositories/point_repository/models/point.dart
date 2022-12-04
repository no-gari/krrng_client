import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'point.g.dart';

@JsonSerializable()
class Point extends Equatable {
  const Point(this.id, this.amount, this.isExpanded, this.title, this.reason,
      this.createdAt);

  final int? id;
  final int? amount;
  final bool? isExpanded;
  final String? title;
  final String? reason;
  final String? createdAt;

  factory Point.fromJson(Map<String, dynamic> json) => _$PointFromJson(json);
  Map<String, dynamic> toJson() => _$PointToJson(this);

  @override
  List<Object?> get props => [id, title, isExpanded, amount, reason, createdAt];
}
