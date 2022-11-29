import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'kind.g.dart';

@JsonSerializable()
class Kind extends Equatable {
  const Kind({this.id, this.kind});

  final int? id;
  final String? kind;

  factory Kind.fromJson(Map<String, dynamic> json) => _$KindFromJson(json);

  Map<String, dynamic> toJson() => _$KindToJson(this);

  Kind copyWith({int? id, String? kind}) {
    return Kind(id: id ?? this.id, kind: kind ?? this.kind);
  }

  @override
  List<Object?> get props => [
        id,
        kind,
      ];
}
