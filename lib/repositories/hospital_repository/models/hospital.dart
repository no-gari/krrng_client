import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hospital.g.dart';

@JsonSerializable()
class Hospital extends Equatable {
  const Hospital({
    required this.id,
    this.price,
    this.distance,
    this.reviewCount,
    this.image,
    this.name,
    this.address,
    this.addressDetail,
    this.recommend
  });

  final int id;
  final int? price;
  final int? distance;
  final int? reviewCount;
  final String? image;
  final String? name;
  final String? address;
  final String? addressDetail;
  final num? recommend;


  factory Hospital.fromJson(Map<String, dynamic> json) => _$HospitalFromJson(json);
  Map<String, dynamic> toJson() => _$HospitalToJson(this);

  @override
  List<Object?> get props => [id, price, distance, reviewCount, image, name, address, addressDetail, recommend];
}
