// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Area _$AreaFromJson(Map<String, dynamic> json) => Area(
      name: json['name'] as String,
      coords: Coords.fromJson(json['coords'] as Map<String, dynamic>),
      alias: json['alias'] as String?,
    );

Map<String, dynamic> _$AreaToJson(Area instance) => <String, dynamic>{
      'name': instance.name,
      'coords': instance.coords,
      'alias': instance.alias,
    };
