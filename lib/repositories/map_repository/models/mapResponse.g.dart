// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mapResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapResponse _$MapResponseFromJson(Map<String, dynamic> json) => MapResponse(
      status: Status.fromJson(json['status'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>)
          .map((e) => MapData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MapResponseToJson(MapResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'results': instance.results,
    };
