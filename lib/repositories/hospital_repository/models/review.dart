import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'review_image.dart';

part 'review.g.dart';

@JsonSerializable()
class Review extends Equatable {
  const Review({
    this.nickname,
    this.diagnosis,
    this.rates,
    this.content,
    this.likes,
    this.reviewImage,
    this.createdAt,
  });

  final String? nickname;
  final String? diagnosis;
  final double? rates;
  final String? content;
  final int? likes;
  final List<ReviewImage>? reviewImage;
  final String? createdAt;


  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  @override
  List<Object?> get props => [nickname, diagnosis, rates, content, likes, reviewImage, createdAt];
}
