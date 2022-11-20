// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Animal _$AnimalFromJson(Map<String, dynamic> json) => Animal(
      id: json['id'] as String?,
      sort: json['sort'] as String?,
      birthday: json['birthday'] as String?,
      weight: json['weight'] as String?,
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
      'weight': instance.weight,
      'hospitalAddress': instance.hospitalAddress,
      'hospitalAddressDetail': instance.hospitalAddressDetail,
      'interestedDisease': instance.interestedDisease,
      'neuterChoices': instance.neuterChoices,
      'hasAlergy': instance.hasAlergy,
      'sexChoices': instance.sexChoices,
    };
