import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({this.nickname, this.profileImage, this.birthday, this.sexChoices});

  final String? nickname;
  final String? profileImage;
  final String? birthday;
  final String? sexChoices;

  @override
  List<Object?> get props => [nickname, profileImage, birthday, sexChoices];

  User copyWith({String? nickname, String? profileImage, String? birthday, String? sexChoices})
  {
    return User(
      nickname: nickname ?? this.nickname,
      profileImage: profileImage ?? this.profileImage,
      birthday: birthday ?? this.birthday,
      sexChoices: sexChoices ?? this.sexChoices,
    );
  }

  static const empty = User();
}
