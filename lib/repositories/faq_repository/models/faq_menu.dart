import 'package:krrng_client/repositories/faq_repository/models/faq.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'faq_menu.g.dart';

@JsonSerializable()
class FAQMenu extends Equatable {
  const FAQMenu(this.name, this.id, this.faq);

  final int? id;
  final String? name;
  final List<FAQ> faq;

  factory FAQMenu.fromJson(Map<String, dynamic> json) =>
      _$FAQMenuFromJson(json);
  Map<String, dynamic> toJson() => _$FAQMenuToJson(this);

  @override
  List<Object?> get props => [name, id, faq];
}
