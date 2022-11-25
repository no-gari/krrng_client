// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Animal _$AnimalFromJson(Map<String, dynamic> json) => Animal(
      id: json['id'] as int?,
      sort: json['sort'] as String?,
      birthday: json['birthday'] as String?,
      name: json['name'] as String?,
      weight: json['weight'] as String?,
      image: json['image'] as String?,
      kind: json['kind'] as String?,
      hospitalAddress: json['hospitalAddress'] as String?,
      hospitalAddressDetail: json['hospitalAddressDetail'] as String?,
      interestedDisease: json['interestedDisease'] as String?,
      neuterChoices: json['neuterChoices'] as String?,
      hasAlergy: json['hasAlergy'] as String?,
      sexChoices: json['sexChoices'] as String?,
    );

Map<String, dynamic> _$AnimalToJson(Animal instance) => <String, dynamic>{
      'id': instance.id,
      'sort': instance.sort,
      'birthday': instance.birthday,
      'name': instance.name,
      'weight': instance.weight,
      'image': instance.image,
      'kind': instance.kind,
      'hospitalAddress': instance.hospitalAddress,
      'hospitalAddressDetail': instance.hospitalAddressDetail,
      'interestedDisease': instance.interestedDisease,
      'neuterChoices': instance.neuterChoices,
      'hasAlergy': instance.hasAlergy,
      'sexChoices': instance.sexChoices,
    };
