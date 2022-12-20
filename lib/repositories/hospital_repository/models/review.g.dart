// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      nickname: json['nickname'] as String?,
      diagnosis: json['diagnosis'] as String?,
      rates: (json['rates'] as num?)?.toDouble(),
      content: json['content'] as String?,
      likes: json['likes'] as int?,
      reviewImage: (json['reviewImage'] as List<dynamic>?)
          ?.map((e) => ReviewImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'nickname': instance.nickname,
      'diagnosis': instance.diagnosis,
      'rates': instance.rates,
      'content': instance.content,
      'likes': instance.likes,
      'reviewImage': instance.reviewImage,
      'createdAt': instance.createdAt,
    };
