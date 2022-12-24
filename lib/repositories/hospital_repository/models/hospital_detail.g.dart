// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HospitalDetail _$HospitalDetailFromJson(Map<String, dynamic> json) =>
    HospitalDetail(
      id: json['id'] as int?,
      distance: json['distance'] as int?,
      reviewCount: json['reviewCount'] as int?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      rate: json['rate'] as num?,
      priceList: (json['priceList'] as List<dynamic>?)
          ?.map((e) => Price.fromJson(e as Map<String, dynamic>))
          .toList(),
      availableAnimal: (json['availableAnimal'] as List<dynamic>?)
          ?.map((e) => AvailableAnimal.fromJson(e as Map<String, dynamic>))
          .toList(),
      bestPart: (json['bestPart'] as List<dynamic>?)
          ?.map((e) => BestPart.fromJson(e as Map<String, dynamic>))
          .toList(),
      hospitalReview: (json['hospitalReview'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
      number: json['number'] as String?,
      intro: json['intro'] as String?,
      availableTime: json['availableTime'] as String?,
      restDate: json['restDate'] as String?,
      address: json['address'] as String?,
      addressDetail: json['addressDetail'] as String?,
    );

Map<String, dynamic> _$HospitalDetailToJson(HospitalDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'distance': instance.distance,
      'reviewCount': instance.reviewCount,
      'images': instance.images,
      'rate': instance.rate,
      'priceList': instance.priceList,
      'availableAnimal': instance.availableAnimal,
      'bestPart': instance.bestPart,
      'hospitalReview': instance.hospitalReview,
      'name': instance.name,
      'number': instance.number,
      'intro': instance.intro,
      'availableTime': instance.availableTime,
      'restDate': instance.restDate,
      'address': instance.address,
      'addressDetail': instance.addressDetail,
    };
