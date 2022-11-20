import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'land.g.dart';

// 상세주소 정보
@JsonSerializable()
class Land extends Equatable {
  const Land({
    required this.type,
    required this.name,
    required this.number1,
    required this.number2,
    required this.addition0,
    required this.addition1,
    required this.addition2,
    required this.addition3,
    required this.addition4,
    required this.coords
  });

  final String type;
  final String name;
  // - 상세 번호 1 예) 대한민국 지번 주소인 경우 토지 본번호 대한민국 도로명 주소인 경우 상세주소
  final String number1;
  // - 상세 번호 2 예) 대한민국 지번 주소인 경우 토지 부번호 대한민국 도로명 주소인 경우 reserved
  final String number2;
  final LandAddition addition0;
  final LandAddition addition1;
  final LandAddition addition2;
  final LandAddition addition3;
  final LandAddition addition4;
  final Coords coords;


  factory Land.fromJson(Map<String, dynamic> json) => _$LandFromJson(json);
  Map<String, dynamic> toJson() => _$LandToJson(this);

  @override
  List<Object?> get props => [type, name, number1, number2, addition0, addition1, addition2, addition3, addition4, coords];

}
