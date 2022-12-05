import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../animal_repository/models/animal.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  const User(
      {this.noti,
      this.nickname,
      this.profileImage,
      this.birthday,
      this.sexChoices,
      this.animals,
      this.phone,
      this.email});

  final bool? noti;
  final String? nickname;
  final String? profileImage;
  final String? birthday;
  final String? sexChoices;
  final List<Animal>? animals;
  final String? phone;
  final String? email;

  @override
  List<Object?> get props => [
        noti,
        nickname,
        profileImage,
        birthday,
        sexChoices,
        animals,
        phone,
        email
      ];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    bool? noti,
    String? nickname,
    String? profileImage,
    String? birthday,
    String? sexChoices,
    List<Animal>? animals,
    String? phone,
    String? email,
  }) {
    return User(
      noti: noti ?? this.noti,
      nickname: nickname ?? this.nickname,
      profileImage: profileImage ?? this.profileImage,
      birthday: birthday ?? this.birthday,
      sexChoices: sexChoices ?? this.sexChoices,
      animals: animals ?? this.animals,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }

  static const empty = User();
}
