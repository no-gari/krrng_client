import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable()
class Image extends Equatable {
  const Image({
    this.id,
    this.name,
    this.image,
  });

  final int? id;
  final String? name;
  final String? image;

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
  Map<String, dynamic> toJson() => _$ImageToJson(this);

  @override
  List<Object?> get props => [id, name, image];
}
