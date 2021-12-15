
import 'package:webfeed/domain/media/community.dart';
import 'dart:convert';
import 'package:webfeed/domain/media/star_rating.dart';
import 'package:webfeed/domain/media/statistics.dart';
import 'package:webfeed/domain/media/tags.dart';

extension CommunityAdd on Community {

  static Community? fromJson(String json) => CommunityAdd.fromMap(jsonDecode(json) as Map);
  String toJson() => jsonEncode(toMap());

  static Community? fromMap(Map map) {
    if (map.isEmpty) return null;
    return Community(
      starRating: StarRatingAdd.fromJson(map["starRating"] ?? "{}"),
      statistics: StatisticsAdd.fromJson(map["statistics"] ?? "{}"),
      tags: TagsAdd.fromJson(map["tags"] ?? "{}"),
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["starRating"] = starRating?.toJson();
    map["statistics"] = statistics?.toJson();
    map["tags"] = tags?.toJson();
    return map;
  }
}

extension StarRatingAdd on StarRating {

  static StarRating? fromJson(String json) => StarRatingAdd.fromMap(jsonDecode(json) as Map);
  String toJson() => jsonEncode(toMap());

  static StarRating? fromMap(Map map) {
    if (map.isEmpty) return null;
    return StarRating(
      average: map["average"],
      count: map["count"],
      min: map["min"],
      max: map["max"],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["average"] = average;
    map["count"] = count;
    map["min"] = min;
    map["max"] = max;
    return map;
  }
}


extension StatisticsAdd on Statistics {

  static Statistics? fromJson(String json) => StatisticsAdd.fromMap(jsonDecode(json) as Map);
  String toJson() => jsonEncode(toMap());

  static Statistics? fromMap(Map map) {
    if (map.isEmpty) return null;
    return Statistics(
      views: map["views"],
      favorites: map["favorites"],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["views"] = views;
    map["favorites"] = favorites;
    return map;
  }
}

extension TagsAdd on Tags {

  static Tags? fromJson(String json) => TagsAdd.fromMap(jsonDecode(json) as Map);
  String toJson() => jsonEncode(toMap());

  static Tags? fromMap(Map map) {
    if (map.isEmpty) return null;
    return Tags(
      tags: map["tags"],
      weight: map["weight"],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["tags"] = tags;
    map["weight"] = weight;
    return map;
  }
}