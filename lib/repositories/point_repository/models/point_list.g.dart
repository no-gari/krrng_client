// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointList _$PointListFromJson(Map<String, dynamic> json) => PointList(
      (json['points'] as List<dynamic>?)
          ?.map((e) => Point.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['totalPoint'] as int?,
    );

Map<String, dynamic> _$PointListToJson(PointList instance) => <String, dynamic>{
      'points': instance.points,
      'totalPoint': instance.totalPoint,
    };
