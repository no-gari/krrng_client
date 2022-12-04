import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';

part 'recent_search.g.dart';

@JsonSerializable()
class RecentSearch extends Equatable {
  const RecentSearch(this.id, this.keyword);

  final String? id, keyword;

  factory RecentSearch.fromJson(Map<String, dynamic> json) =>
      _$RecentSearchFromJson(json);

  Map<String, dynamic> toJson() => _$RecentSearchToJson(this);

  static Map<String, dynamic> toMap(RecentSearch recentSearch) => {
        'id': recentSearch.id,
        'keyword': recentSearch.keyword,
      };

  static String encode(List<RecentSearch> recentSearchList) => json.encode(
        recentSearchList
            .map<Map<String, dynamic>>((item) => RecentSearch.toMap(item))
            .toList(),
      );

  static List<RecentSearch> decode(String favoriteList) =>
      (json.decode(favoriteList) as List<dynamic>)
          .map<RecentSearch>((item) => RecentSearch.fromJson(item))
          .toList();

  @override
  List<Object?> get props => [id, keyword];
}
