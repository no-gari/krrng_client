import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review_image.g.dart';

@JsonSerializable()
class ReviewImage extends Equatable {
  const ReviewImage({
    this.id,
    this.image,
  });

  final int? id;
  final String? image;

  factory ReviewImage.fromJson(Map<String, dynamic> json) => _$ReviewImageFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewImageToJson(this);

  @override
  List<Object?> get props => [id, image];
}
