import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'notice.g.dart';

@JsonSerializable()
class Notice extends Equatable {
  const Notice(this.isExpanded, this.name, this.content, this.createdAt);

  final bool? isExpanded;
  final String? name;
  final String? content;
  final String? createdAt;

  factory Notice.fromJson(Map<String, dynamic> json) => _$NoticeFromJson(json);
  Map<String, dynamic> toJson() => _$NoticeToJson(this);

  @override
  List<Object?> get props => [isExpanded, name, content, createdAt];
}
