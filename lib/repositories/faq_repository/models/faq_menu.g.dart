// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq_menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FAQMenu _$FAQMenuFromJson(Map<String, dynamic> json) => FAQMenu(
      json['name'] as String?,
      json['id'] as int?,
      (json['faq'] as List<dynamic>)
          .map((e) => FAQ.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FAQMenuToJson(FAQMenu instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'faq': instance.faq,
    };
