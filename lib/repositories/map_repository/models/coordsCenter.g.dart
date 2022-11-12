// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coordsCenter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoordsCenter _$CoordsCenterFromJson(Map<String, dynamic> json) => CoordsCenter(
      crs: json['crs'] as String,
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
    );

Map<String, dynamic> _$CoordsCenterToJson(CoordsCenter instance) =>
    <String, dynamic>{
      'crs': instance.crs,
      'x': instance.x,
      'y': instance.y,
    };
