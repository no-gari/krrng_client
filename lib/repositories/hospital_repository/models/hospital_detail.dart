import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'available_animal.dart';
import 'best_part.dart';
import 'image.dart';
import 'price.dart';
import 'review.dart';

part 'hospital_detail.g.dart';

@JsonSerializable()
class HospitalDetail extends Equatable {
  const HospitalDetail({
    this.id,
    this.distance,
    this.reviewCount,
    this.images,
    this.rate,
    this.priceList,
    this.availableAnimal,
    this.bestPart,
    this.hospitalReview,
    this.name,
    this.number,
    this.intro,
    this.availableTime,
    this.restDate,
    this.address,
    this.addressDetail,
  });

  final int? id;
  final int? distance;
  final int? reviewCount;
  final List<Image>? images;
  final num? rate;
  final List<Price>? priceList;
  final List<AvailableAnimal>? availableAnimal;
  final List<BestPart>? bestPart;
  final List<Review>? hospitalReview;
  final String? name;
  final String? number;
  final String? intro;
  final String? availableTime;
  final String? restDate;
  final String? address;
  final String? addressDetail;

  factory HospitalDetail.fromJson(Map<String, dynamic> json) =>
      _$HospitalDetailFromJson(json);
  Map<String, dynamic> toJson() => _$HospitalDetailToJson(this);

  @override
  List<Object?> get props => [
        id,
        distance,
        reviewCount,
        images,
        rate,
        priceList,
        availableAnimal,
        bestPart,
        hospitalReview,
        name,
        number,
        intro,
        availableTime,
        restDate,
        address,
        addressDetail
      ];
}
