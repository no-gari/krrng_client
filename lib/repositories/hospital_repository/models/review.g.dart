// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      id: json['id'] as int?,
      nickname: json['nickname'] as String?,
      diagnosis: json['diagnosis'] as String?,
      rates: (json['rates'] as num?)?.toDouble(),
      content: json['content'] as String?,
      likes: json['likes'] as int?,
      reviewImage: (json['reviewImage'] as List<dynamic>?)
          ?.map((e) => ReviewImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
      isLike: json['isLike'] as bool?,
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'diagnosis': instance.diagnosis,
      'rates': instance.rates,
      'content': instance.content,
      'likes': instance.likes,
      'reviewImage': instance.reviewImage,
      'createdAt': instance.createdAt,
      'isLike': instance.isLike,
    };
