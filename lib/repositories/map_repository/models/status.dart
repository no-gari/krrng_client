import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'status.g.dart';

@JsonSerializable()
class Status extends Equatable {
  const Status({
    required this.code,
    required this.name,
    required this.message
  });

  final int code;
  final String name;
  final String message;

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
  Map<String, dynamic> toJson() => _$StatusToJson(this);

  @override
  List<Object?> get props => [code, name, message];

}
