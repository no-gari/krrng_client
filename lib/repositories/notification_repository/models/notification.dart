import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notification extends Equatable {
  const Notification(
      this.id, this.sort, this.title, this.content, this.timesince);

  final int? id;
  final String? sort;
  final String? title;
  final String? content;
  final String? timesince;

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationToJson(this);

  @override
  List<Object?> get props => [id, sort, title, content, timesince];
}
