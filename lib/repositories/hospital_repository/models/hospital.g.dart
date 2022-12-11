// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hospital _$HospitalFromJson(Map<String, dynamic> json) => Hospital(
      id: json['id'] as int,
      price: json['price'] as int?,
      distance: json['distance'] as int?,
      reviewCount: json['reviewCount'] as int?,
      image: json['image'] as String?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      addressDetail: json['addressDetail'] as String?,
      recommend: json['recommend'] as num?,
    );

Map<String, dynamic> _$HospitalToJson(Hospital instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'distance': instance.distance,
      'reviewCount': instance.reviewCount,
      'image': instance.image,
      'name': instance.name,
      'address': instance.address,
      'addressDetail': instance.addressDetail,
      'recommend': instance.recommend,
    };
