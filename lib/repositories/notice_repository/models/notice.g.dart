// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notice _$NoticeFromJson(Map<String, dynamic> json) => Notice(
      json['isExpanded'] as bool?,
      json['name'] as String?,
      json['content'] as String?,
      json['createdAt'] as String?,
    );

Map<String, dynamic> _$NoticeToJson(Notice instance) => <String, dynamic>{
      'isExpanded': instance.isExpanded,
      'name': instance.name,
      'content': instance.content,
      'createdAt': instance.createdAt,
    };
