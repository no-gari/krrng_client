// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mapData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapData _$MapDataFromJson(Map<String, dynamic> json) => MapData(
      name: json['name'] as String,
      code: MapCode.fromJson(json['code'] as Map<String, dynamic>),
      region: Region.fromJson(json['region'] as Map<String, dynamic>),
      land: Land.fromJson(json['land'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MapDataToJson(MapData instance) => <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'land': instance.land,
      'region': instance.region,
    };
