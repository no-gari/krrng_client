import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'best_part.g.dart';

@JsonSerializable()
class BestPart extends Equatable {
  const BestPart({
    this.id,
    this.name,
    this.image,
  });

  final int? id;
  final String? name;
  final String? image;

  factory BestPart.fromJson(Map<String, dynamic> json) =>
      _$BestPartFromJson(json);
  Map<String, dynamic> toJson() => _$BestPartToJson(this);

  @override
  List<Object?> get props => [id, name, image];
}
