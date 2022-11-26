// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Point _$PointFromJson(Map<String, dynamic> json) => Point(
      json['id'] as int?,
      json['amount'] as int?,
      json['isExpanded'] as bool?,
      json['title'] as String?,
      json['reason'] as String?,
      json['createdAt'] as String?,
    );

Map<String, dynamic> _$PointToJson(Point instance) => <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'isExpanded': false,
      'title': instance.title,
      'reason': instance.reason,
      'createdAt': instance.createdAt,
    };
