import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'landAddition.g.dart';

// 상세주소 정보
@JsonSerializable()
class LandAddition extends Equatable {
  const LandAddition({
    required this.type,
    required this.value,
  });

  final String type;
  final String value;


  factory LandAddition.fromJson(Map<String, dynamic> json) => _$LandAdditionFromJson(json);
  Map<String, dynamic> toJson() => _$LandAdditionToJson(this);

  @override
  List<Object?> get props => [type, value];

}
