import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'mapResponse.g.dart';

@JsonSerializable()
class MapResponse extends Equatable {
  const MapResponse({
    required this.status,
    required this.results
  });

  final Status status;
  final List<MapData> results;

  factory MapResponse.fromJson(Map<String, dynamic> json) => _$MapResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MapResponseToJson(this);

  @override
  List<Object?> get props => [status, results];

}
