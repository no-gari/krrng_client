// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'land.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Land _$LandFromJson(Map<String, dynamic> json) => Land(
      type: json['type'] as String,
      name: json['name'] as String,
      number1: json['number1'] as String,
      number2: json['number2'] as String,
      addition0:
          LandAddition.fromJson(json['addition0'] as Map<String, dynamic>),
      addition1:
          LandAddition.fromJson(json['addition1'] as Map<String, dynamic>),
      addition2:
          LandAddition.fromJson(json['addition2'] as Map<String, dynamic>),
      addition3:
          LandAddition.fromJson(json['addition3'] as Map<String, dynamic>),
      addition4:
          LandAddition.fromJson(json['addition4'] as Map<String, dynamic>),
      coords: Coords.fromJson(json['coords'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LandToJson(Land instance) => <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'number1': instance.number1,
      'number2': instance.number2,
      'addition0': instance.addition0,
      'addition1': instance.addition1,
      'addition2': instance.addition2,
      'addition3': instance.addition3,
      'addition4': instance.addition4,
      'coords': instance.coords,
    };
