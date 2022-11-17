import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {this.nickname, this.profileImage, this.points});

  final String? nickname;
  final String? profileImage;
  final int? points;

  @override
  List<Object?> get props => [nickname, profileImage, points];

  User copyWith({String? nickname,
      String? profileImage,
      int? points
      }) {
    return User(
      nickname: nickname ?? this.nickname,
      profileImage: profileImage ?? this.profileImage,
      points: points ?? this.points,
    );
  }

  static const empty = User();
}
