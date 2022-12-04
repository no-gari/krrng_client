// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_animal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SortAnimal _$SortAnimalFromJson(Map<String, dynamic> json) => SortAnimal(
      sort: json['sort'] as String?,
      kinds: (json['kinds'] as List<dynamic>?)
          ?.map((e) => Kind.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SortAnimalToJson(SortAnimal instance) =>
    <String, dynamic>{
      'sort': instance.sort,
      'kinds': instance.kinds,
    };
