import 'package:intl/intl.dart';
import 'package:webfeed/domain/atom_category.dart';
import 'package:webfeed/domain/atom_feed.dart';
import 'package:webfeed/domain/atom_generator.dart';
import 'package:webfeed/domain/atom_item.dart';
import 'package:webfeed/domain/atom_link.dart';
import 'package:webfeed/domain/atom_person.dart';
import 'package:webfeed/domain/atom_source.dart';
import 'package:webfeed/util/datetime.dart';
import 'dart:convert';
import 'media_model_extension.dart';
import '../article_item.dart';

extension AtomFeedAdd on AtomFeed {
  String favicon() {
    var icon = "";
    for (var link in links!) {
      if (link.rel == "self") {
        var uri = Uri.parse(link.href!);
        icon = uri.scheme + "://" + uri.host + "/favicon.ico";
      }
    }
    return icon;
  }

  String? selfLink() {
    for (var link in links!) {
      if (link.rel == "self") {
        return link.href!;
      }
    }
    return null;
  }

  String? updateTime() {
    if (updated != null) {
      return DateFormat("yyyy-MM-dd HH:mm:ss").format(updated!);
    }else {
      return "未知时间";
    }
  }

  static AtomFeed? fromJson(String json) =>
      AtomFeedAdd.fromMap(jsonDecode(json) as Map);

  static List<AtomFeed> fromMapList(List<dynamic> mapList) =>
      mapList.map((e) => AtomFeedAdd.fromMap(e)!).toList();

  String toJson() => jsonEncode(toMap());

  static AtomFeed? fromMap(Map map) {
    if (map.isEmpty) return null;
    return AtomFeed(
      id: map["feedId"],
      title: map["title"],
      updated: parseDateTime(map["updated"]),
      links: AtomLinkAdd.fromMapList(jsonDecode(map["links"] ?? "[]")),
      authors: AtomPersonAdd.fromMapList(jsonDecode(map["authors"] ?? "[]")),
      contributors: AtomPersonAdd.fromMapList(jsonDecode(map["contributors"] ?? "[]")),
      categories:
          AtomCategoryAdd.fromMapList(jsonDecode(map["categories"] ?? "[]")),
      generator: AtomGeneratorAdd.fromMap(jsonDecode(map["generator"] ?? "{}")),
      icon: map["icon"],
      logo: map["logo"],
      rights: map["rights"],
      subtitle: map["subtitle"],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["feedId"] = id;
    map["title"] = title;
    map["updated"] = updated.toString();
    map["links"] = AtomLinkAdd.toJsonList(links);
    map["authors"] = AtomPersonAdd.toJsonList(authors);
    map["contributors"] = AtomPersonAdd.toJsonList(contributors);
    map["categories"] = AtomCategoryAdd.toJsonList(categories);
    map["generator"] = generator?.toJson();
    map["icon"] = icon;
    map["logo"] = logo;
    map["rights"] = rights;
    map["subtitle"] = subtitle;
    return map;
  }
}

extension AtomItemAdd on AtomItem {
  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() {

    var publishedTime = parseDateTime(published);
    var map = <String, dynamic>{};
    map["articleId"] = id;
    map["title"] = title;
    map["updated"] = publishedTime == null ? updated.toString() : publishedTime.toString();
    map["authors"] = AtomPersonAdd.toJsonList(authors);
    map["links"] = AtomLinkAdd.toJsonList(links);
    map["categories"] = AtomCategoryAdd.toJsonList(categories);
    map["contributors"] = AtomPersonAdd.toJsonList(contributors);
    map["source"] = source?.toJson();
    map["published"] = published;
    map["content"] = content;
    map["summary"] = summary;
    map["rights"] = rights;
    map["media"] = rights;
    return map;
  }
}

extension ArticleItemAdd on ArticleItem {
  static ArticleItem? fromJson(String json) =>
      ArticleItemAdd.fromMap(jsonDecode(json) as Map);

  static List<ArticleItem> fromMapList(List<dynamic> mapList) =>
      mapList.map((e) => ArticleItemAdd.fromMap(e)!).toList();

  static ArticleItem? fromMap(Map map) {
    if (map.isEmpty) return null;

    return ArticleItem(
      map["isRead"] == 1 ? true : false,
      map["isFavorite"] == 1 ? true : false,
      id: map["feedId"],
      title: map["title"],
      updated: parseDateTime(map["updated"]),
      authors: AtomPersonAdd.fromMapList(jsonDecode(map["authors"] ?? "[]")),
      links: AtomLinkAdd.fromMapList(jsonDecode(map["links"] ?? "[]")),
      categories:
          AtomCategoryAdd.fromMapList(jsonDecode(map["categories"] ?? "[]")),
      contributors:
          AtomPersonAdd.fromMapList(jsonDecode(map["contributors"] ?? "[]")),
      source: AtomSourceAdd.fromMap(jsonDecode(map["source"] ?? "{}")),
      published: map["published"],
      content: map["content"],
      summary: map["summary"],
      rights: map["rights"],
    );
  }
}

extension AtomLinkAdd on AtomLink {
  static AtomLink? fromJson(String json) =>
      AtomLinkAdd.fromMap(jsonDecode(json) as Map);

  static List<AtomLink> fromMapList(List<dynamic> mapList) =>
      mapList.map((e) => AtomLinkAdd.fromMap(e)!).toList();

  static String? toJsonList(List<AtomLink>? links) =>
      jsonEncode(links?.map((e) => e.toMap()).toList());

  String toJson() => jsonEncode(toMap());

  static AtomLink? fromMap(Map map) {
    if (map.isEmpty) return null;
    return AtomLink(map["href"], map["rel"], map["type"], map["hreflang"],
        map["title"], map["length"]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["href"] = href;
    map["rel"] = rel;
    map["type"] = type;
    map["hreflang"] = hreflang;
    map["title"] = title;
    map["length"] = length;
    return map;
  }
}

extension AtomPersonAdd on AtomPerson {
  static AtomPerson? fromJson(String json) =>
      AtomPersonAdd.fromMap(jsonDecode(json) as Map);

  static List<AtomPerson> fromMapList(List<dynamic> mapList) =>
      mapList.map((e) => AtomPersonAdd.fromMap(e)!).toList();

  static String? toJsonList(List<AtomPerson>? links) =>
      jsonEncode(links?.map((e) => e.toMap()).toList());

  String toJson() => jsonEncode(toMap());

  static AtomPerson? fromMap(Map map) {
    if (map.isEmpty) return null;
    return AtomPerson(name: map["name"], uri: map["uri"], email: map["email"]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["uri"] = uri;
    map["email"] = email;
    return map;
  }
}

extension AtomCategoryAdd on AtomCategory {
  static AtomCategory? fromJson(String json) =>
      AtomCategoryAdd.fromMap(jsonDecode(json) as Map);

  static List<AtomCategory>? fromMapList(List<dynamic> mapList) =>
      mapList.map((e) => AtomCategoryAdd.fromMap(e)!).toList();

  static String? toJsonList(List<AtomCategory>? links) =>
      jsonEncode(links?.map((e) => e.toMap()).toList());

  String toJson() => jsonEncode(toMap());

  static AtomCategory? fromMap(Map map) {
    if (map.isEmpty) return null;
    return AtomCategory(map["term"], map["scheme"], map["label"]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["term"] = term;
    map["scheme"] = scheme;
    map["label"] = label;
    return map;
  }
}

extension AtomGeneratorAdd on AtomGenerator {
  static AtomGenerator? fromJson(String json) =>
      AtomGeneratorAdd.fromMap(jsonDecode(json) as Map);

  static String? toJsonList(List<AtomGenerator>? links) =>
      jsonEncode(links?.map((e) => e.toMap()).toList());

  String toJson() => jsonEncode(toMap());

  static AtomGenerator? fromMap(Map map) {
    if (map.isEmpty) return null;
    return AtomGenerator(map["uri"], map["version"], map["value"]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["uri"] = uri;
    map["version"] = version;
    map["value"] = value;
    return map;
  }
}

extension AtomSourceAdd on AtomSource {
  static AtomSource? fromJson(String json) =>
      AtomSourceAdd.fromMap(jsonDecode(json) as Map);

  static String? toJsonList(List<AtomSource>? links) =>
      jsonEncode(links?.map((e) => e.toMap()).toList());

  String toJson() => jsonEncode(toMap());

  static AtomSource? fromMap(Map map) {
    if (map.isEmpty) return null;
    return AtomSource(
        id: map["id"], title: map["title"], updated: map["updated"]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["title"] = title;
    map["updated"] = updated;
    return map;
  }
}
