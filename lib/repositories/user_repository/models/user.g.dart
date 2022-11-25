// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      nickname: json['nickname'] as String?,
      profileImage: json['profileImage'] as String?,
      birthday: json['birthday'] as String?,
      sexChoices: json['sexChoices'] as String?,
      animals: (json['animals'] as List<dynamic>?)
          ?.map((e) => Animal.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'nickname': instance.nickname,
      'profileImage': instance.profileImage,
      'birthday': instance.birthday,
      'sexChoices': instance.sexChoices,
      'animals': instance.animals,
    };
