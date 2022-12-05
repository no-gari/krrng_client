// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      json['id'] as int?,
      json['sort'] as String?,
      json['title'] as String?,
      json['content'] as String?,
      json['timesince'] as String?,
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sort': instance.sort,
      'title': instance.title,
      'content': instance.content,
      'timesince': instance.timesince,
    };
