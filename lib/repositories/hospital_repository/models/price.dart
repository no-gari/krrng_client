import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'price.g.dart';

@JsonSerializable()
class Price extends Equatable {
  const Price({
    this.id,
    this.name,
    this.price,
  });

  final int? id;
  final String? name;
  final int? price;

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
  Map<String, dynamic> toJson() => _$PriceToJson(this);

  @override
  List<Object?> get props => [id, name, price];
}
