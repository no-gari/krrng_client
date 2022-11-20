// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Region _$RegionFromJson(Map<String, dynamic> json) => Region(
      area0: Area.fromJson(json['area0'] as Map<String, dynamic>),
      area1: Area.fromJson(json['area1'] as Map<String, dynamic>),
      area2: Area.fromJson(json['area2'] as Map<String, dynamic>),
      area3: Area.fromJson(json['area3'] as Map<String, dynamic>),
      area4: Area.fromJson(json['area4'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegionToJson(Region instance) => <String, dynamic>{
      'area0': instance.area0,
      'area1': instance.area1,
      'area2': instance.area2,
      'area3': instance.area3,
      'area4': instance.area4,
    };
