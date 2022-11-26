import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'faq.g.dart';

@JsonSerializable()
class FAQ extends Equatable {
  const FAQ(this.name, this.content, this.id, this.isExpanded);

  final int? id;
  final String? name;
  final String? content;
  final bool? isExpanded;

  factory FAQ.fromJson(Map<String, dynamic> json) => _$FAQFromJson(json);
  Map<String, dynamic> toJson() => _$FAQToJson(this);

  @override
  List<Object?> get props => [name, content, id, isExpanded];
}
