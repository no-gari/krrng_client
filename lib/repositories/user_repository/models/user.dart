import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../animal_repository/models/animal.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  const User(
      {this.nickname,
      this.profileImage,
      this.birthday,
      this.sexChoices,
      this.animals});

  final String? nickname;
  final String? profileImage;
  final String? birthday;
  final String? sexChoices;
  final List<Animal>? animals;

  @override
  List<Object?> get props =>
      [nickname, profileImage, birthday, sexChoices, animals];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith(
      {String? nickname,
      String? profileImage,
      String? birthday,
      String? sexChoices,
      List<Animal>? animals}) {
    return User(
      nickname: nickname ?? this.nickname,
      profileImage: profileImage ?? this.profileImage,
      birthday: birthday ?? this.birthday,
      sexChoices: sexChoices ?? this.sexChoices,
      animals: animals ?? this.animals,
    );
  }

  static const empty = User();
}
