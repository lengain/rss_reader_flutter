import 'dart:convert';
import 'package:webfeed/domain/media/category.dart';
import 'package:webfeed/domain/media/content.dart';
import 'package:webfeed/domain/media/copyright.dart';
import 'package:webfeed/domain/media/credit.dart';
import 'package:webfeed/domain/media/description.dart';
import 'package:webfeed/domain/media/embed.dart';
import 'package:webfeed/domain/media/group.dart';
import 'package:webfeed/domain/media/hash.dart';
import 'package:webfeed/domain/media/license.dart';
import 'package:webfeed/domain/media/media.dart';
import 'package:webfeed/domain/media/param.dart';
import 'package:webfeed/domain/media/peer_link.dart';
import 'package:webfeed/domain/media/player.dart';
import 'package:webfeed/domain/media/price.dart';
import 'package:webfeed/domain/media/rating.dart';
import 'package:webfeed/domain/media/restriction.dart';
import 'package:webfeed/domain/media/rights.dart';
import 'package:webfeed/domain/media/status.dart';
import 'package:webfeed/domain/media/text.dart';
import 'package:webfeed/domain/media/thumbnail.dart';
import 'package:webfeed/domain/media/title.dart';
import 'package:webfeed/domain/media/scene.dart';
import 'community_model_extension.dart';

extension MediaAdd on Media {

  static Media? fromJson(String json) => MediaAdd.fromMap(jsonDecode(json) as Map);
  static List<Media> fromMapList(List<dynamic> mapList) => mapList.map((e) => MediaAdd.fromMap(e)!).toList();
  static String? toJsonList(List<Media>? links) => jsonEncode(links?.map((e) => e.toMap()).toList());
  String toJson() => jsonEncode(toMap());

  static Media? fromMap(Map map) {
    if (map.isEmpty) return null;
    return Media(
      group: GroupAdd.fromJson(map["group"] ?? "{}"),
      contents: ContentAdd.fromMapList(jsonDecode(map["contents"] ?? "[]")),
      credits: CreditAdd.fromMapList(jsonDecode(map["credits"] ?? "[]")),
      category: CategoryAdd.fromJson(map["category"] ?? "{}"),
      rating: RatingAdd.fromJson(map["category"] ?? "{}"),
      title: TitleAdd.fromJson(map["title"] ?? "{}"),
      description: DescriptionAdd.fromJson(map["description"] ?? "{}"),
      keywords: map["keywords"],
      thumbnails: ThumbnailAdd.fromMapList(jsonDecode(map["thumbnails"] ?? "[]")),
      hash: HashAdd.fromJson(map["hash"] ?? "{}"),
      player: PlayerAdd.fromJson(map["player"] ?? "{}"),
      copyright: CopyrightAdd.fromJson(map["copyright"] ?? "{}"),
      text: TextAdd.fromJson(map["text"] ?? "{}"),
      restriction: RestrictionAdd.fromJson(map["restriction"] ?? "{}"),
      community: CommunityAdd.fromJson(map["community"] ?? "{}"),
      comments: map["comments"],
      embed: EmbedAdd.fromJson(map["embed"] ?? "{}"),
      responses: map["responses"],
      backLinks: map["backLinks"],
      status: StatusAdd.fromJson(map["status"] ?? "{}"),
      prices: PriceAdd.fromMapList(jsonDecode(map["prices"] ?? "[]")),
      license: LicenseAdd.fromJson(map["license"] ?? "{}"),
      peerLink: PeerLinkAdd.fromJson(map["peerLink"] ?? "{}"),
      rights: RightsAdd.fromJson(map["rights"] ?? "{}"),
      scenes: SceneAdd.fromMapList(jsonDecode(map["scenes"] ?? "[]")),
    );
  }


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["group"] = group?.toJson();
    map["contents"] = ContentAdd.toJsonList(contents);
    map["credits"] = CreditAdd.toJsonList(credits);
    map["category"] = category?.toJson();
    map["rating"] = rating?.toJson();
    map["title"] = title?.toJson();
    map["description"] = description?.toJson();
    map["keywords"] = keywords;
    map["thumbnails"] = ThumbnailAdd.toJsonList(thumbnails);
    map["hash"] = hash?.toJson();
    map["player"] = player?.toJson();
    map["copyright"] = copyright?.toJson();
    map["text"] = text?.toJson();
    map["restriction"] = restriction?.toJson();
    map["community"] = community?.toJson();
    map["comments"] = comments;
    map["embed"] = embed?.toJson();
    map["responses"] = responses;
    map["backLinks"] = backLinks;
    map["status"] = status?.toJson();
    map["prices"] = PriceAdd.toJsonList(prices);
    map["license"] = license?.toJson();
    map["peerLink"] = peerLink?.toJson();
    map["rights"] = rights?.toJson();
    map["scenes"] = SceneAdd.toJsonList(scenes);
    return map;
  }
}

extension GroupAdd on Group {
  static Group? fromJson(String json) => GroupAdd.fromMap(jsonDecode(json) as Map);
  static List<Group> fromMapList(List<dynamic> mapList) => mapList.map((e) => GroupAdd.fromMap(e)!).toList();
  static String? toJsonList(List<Group>? links) => jsonEncode(links?.map((e) => e.toMap()).toList());
  String toJson() => jsonEncode(toMap());

  static Group? fromMap(Map map) {
    if (map.isEmpty) return null;
    return Group(
        contents: map["Contents"],
        credits: map["credits"],
        category: CategoryAdd.fromMap(jsonDecode(map["category"])),
        rating: RatingAdd.fromMap(jsonDecode(map["rating"])),
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["contents"] = contents;
    map["credits"] = credits;
    map["category"] = category?.toJson();
    map["rating"] = rating?.toJson();
    return map;
  }
}

extension ContentAdd on Content {
  static Content? fromJson(String json) =>
      ContentAdd.fromMap(jsonDecode(json) as Map);

  static List<Content> fromMapList(List<dynamic> mapList) =>
      mapList.map((e) => ContentAdd.fromMap(e)!).toList();

  static String? toJsonList(List<Content>? links) =>
      jsonEncode(links?.map((e) => e.toMap()).toList());

  String toJson() => jsonEncode(toMap());

  static Content? fromMap(Map map) {
    if (map.isEmpty) return null;
    return Content(
      url : map["url"],
      type: map["type"],
      fileSize: map["fileSize"],
      medium: map["medium"],
      isDefault: map["isDefault"],
      expression: map["expression"],
      bitrate: map["bitrate"],
      framerate: map["framerate"],
      samplingrate: map["samplingrate"],
      channels: map["channels"],
      duration: map["duration"],
      height: map["height"],
      width: map["width"],
      lang: map["lang"],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["url"] = url;
    map["type"] = type;
    map["fileSize"] = fileSize;
    map["medium"] = medium;
    map["isDefault"] = isDefault;
    map["expression"] = expression;
    map["bitrate"] = bitrate;
    map["framerate"] = framerate;
    map["samplingrate"] = samplingrate;
    map["channels"] = channels;
    map["duration"] = duration;
    map["height"] = height;
    map["width"] = width;
    map["lang"] = lang;
    return map;
  }
}


extension CreditAdd on Credit {

  static Credit? fromJson(String json) =>
      CreditAdd.fromMap(jsonDecode(json) as Map);

  static List<Credit> fromMapList(List<dynamic> mapList) =>
      mapList.map((e) => CreditAdd.fromMap(e)!).toList();

  static String? toJsonList(List<Credit>? links) =>
      jsonEncode(links?.map((e) => e.toMap()).toList());

  String toJson() => jsonEncode(toMap());

  static Credit? fromMap(Map map) {
    if (map.isEmpty) return null;
    return Credit(
      role: map["role"],
      scheme: map["scheme"],
      value: map["value"],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["role"] = role;
    map["scheme"] = scheme;
    map["value"] = value;
    return map;
  }
}

extension CategoryAdd on Category {

  static Category? fromJson(String json) => CategoryAdd.fromMap(jsonDecode(json) as Map);
  String toJson() => jsonEncode(toMap());

  static Category? fromMap(Map map) {
    if (map.isEmpty) return null;
    return Category(
        scheme: map["scheme"], label: map["label"], value: map["value"]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["scheme"] = scheme;
    map["label"] = label;
    map["value"] = value;
    return map;
  }
}

extension RatingAdd on Rating {
  static Rating? fromJson(String json) => RatingAdd.fromMap(jsonDecode(json) as Map);
  String toJson() => jsonEncode(toMap());

  static Rating? fromMap(Map map) {
    if (map.isEmpty) return null;
    return Rating(
        scheme: map["scheme"], value: map["value"]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["scheme"] = scheme;
    map["value"] = value;
    return map;
  }
}

extension TitleAdd on Title {
  static Title? fromJson(String json) => TitleAdd.fromMap(jsonDecode(json) as Map);
  String toJson() => jsonEncode(toMap());

  static Title? fromMap(Map map) {
    if (map.isEmpty) return null;
    return Title(
        type: map["type"], value: map["value"]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["type"] = type;
    map["value"] = value;
    return map;
  }
}

extension DescriptionAdd on Description {
  static Description? fromJson(String json) => DescriptionAdd.fromMap(jsonDecode(json) as Map);
  String toJson() => jsonEncode(toMap());

  static Description? fromMap(Map map) {
    if (map.isEmpty) return null;
    return Description(
        type: map["type"], value: map["value"]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["type"] = type;
    map["value"] = value;
    return map;
  }
}

extension ThumbnailAdd on Thumbnail {
  static Thumbnail? fromJson(String json) => ThumbnailAdd.fromMap(jsonDecode(json) as Map);
  static List<Thumbnail> fromMapList(List<dynamic> mapList) => mapList.map((e) => ThumbnailAdd.fromMap(e)!).toList();
  static String? toJsonList(List<Thumbnail>? links) => jsonEncode(links?.map((e) => e.toMap()).toList());
  String toJson() => jsonEncode(toMap());

  static Thumbnail? fromMap(Map map) {
    if (map.isEmpty) return null;
    return Thumbnail(
      url: map["url"],
      width: map["width"],
      height: map["height"],
      time: map["time"]
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["url"] = url;
    map["width"] = width;
    map["height"] = height;
    map["time"] = time;
    return map;
  }
}

extension HashAdd on Hash {
  static Hash? fromJson(String json) => HashAdd.fromMap(jsonDecode(json) as Map);
  String toJson() => jsonEncode(toMap());

  static Hash? fromMap(Map map) {
    if (map.isEmpty) return null;
    return Hash(
        algo: map["algo"], value: map["value"]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["algo"] = algo;
    map["value"] = value;
    return map;
  }
}

extension PlayerAdd on Player {
  static Player? fromJson(String json) => PlayerAdd.fromMap(jsonDecode(json) as Map);
  String toJson() => jsonEncode(toMap());

  static Player? fromMap(Map map) {
    if (map.isEmpty) return null;
    return Player(
        url: map["url"],
        width: map["width"],
        height: map["height"],
        value: map["value"]
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["url"] = url;
    map["width"] = width;
    map["height"] = height;
    map["value"] = value;
    return map;
  }
}

extension CopyrightAdd on Copyright {
  static Copyright? fromJson(String json) => CopyrightAdd.fromMap(jsonDecode(json) as Map);
  String toJson() => jsonEncode(toMap());

  static Copyright? fromMap(Map map) {
    if (map.isEmpty) return null;
    return Copyright(
        url: map["url"], value: map["value"]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["url"] = url;
    map["value"] = value;
    return map;
  }
}


extension TextAdd on Text {
  static Text? fromJson(String json) => TextAdd.fromMap(jsonDecode(json) as Map);
  String toJson() => jsonEncode(toMap());

  static Text? fromMap(Map map) {
    if (map.isEmpty) return null;
    return Text(
      type: map["type"],
      lang: map["lang"],
      start: map["start"],
      end: map["end"],
      value: map["value"],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["type"] = type;
    map["lang"] = lang;
    map["start"] = start;
    map["end"] = end;
    map["value"] = value;
    return map;
  }
}

extension RestrictionAdd on Restriction {
  static Restriction? fromJson(String json) => RestrictionAdd.fromMap(jsonDecode(json) as Map);
  String toJson() => jsonEncode(toMap());

  static Restriction? fromMap(Map map) {
    if (map.isEmpty) return null;
    return Restriction(relationship:map["relationship"],
        type: map["type"], value: map["value"]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["relationship"] = relationship;
    map["type"] = type;
    map["value"] = value;
    return map;
  }
}

extension EmbedAdd on Embed {
  static Embed? fromJson(String json) => EmbedAdd.fromMap(jsonDecode(json) as Map);
  String toJson() => jsonEncode(toMap());

  static Embed? fromMap(Map map) {
    if (map.isEmpty) return null;
    return Embed(
        url: map["url"],
        width: map["width"],
        height: map["height"],
        params: ParamAdd.fromMapList(jsonDecode(map["params"] ?? "[]"))
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["url"] = url;
    map["width"] = width;
    map["height"] = height;
    map["params"] = ParamAdd.toJsonList(params);
    return map;
  }
}

extension ParamAdd on Param {
  static Param? fromJson(String json) => ParamAdd.fromMap(jsonDecode(json) as Map);
  static List<Param> fromMapList(List<dynamic> mapList) => mapList.map((e) => ParamAdd.fromMap(e)!).toList();
  static String? toJsonList(List<Param>? links) => jsonEncode(links?.map((e) => e.toMap()).toList());
  String toJson() => jsonEncode(toMap());

  static Param? fromMap(Map map) {
    if (map.isEmpty) return null;
    return Param(
        name: map["name"], value: map["value"]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["value"] = value;
    return map;
  }
}

extension StatusAdd on Status {
  static Status? fromJson(String json) => StatusAdd.fromMap(jsonDecode(json) as Map);
  String toJson() => jsonEncode(toMap());

  static Status? fromMap(Map map) {
    if (map.isEmpty) return null;
    return Status(
        state: map["state"], reason: map["reason"]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["state"] = state;
    map["reason"] = reason;
    return map;
  }
}

extension PriceAdd on Price {
  static Price? fromJson(String json) => PriceAdd.fromMap(jsonDecode(json) as Map);
  static List<Price> fromMapList(List<dynamic> mapList) => mapList.map((e) => PriceAdd.fromMap(e)!).toList();
  static String? toJsonList(List<Price>? links) => jsonEncode(links?.map((e) => e.toMap()).toList());
  String toJson() => jsonEncode(toMap());

  static Price? fromMap(Map map) {
    if (map.isEmpty) return null;
    return Price(
        price: map["price"],
        type: map["type"],
        info: map["info"],
        currency: map["currency"]
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["price"] = price;
    map["type"] = type;
    map["info"] = info;
    map["currency"] = currency;
    return map;
  }
}

extension LicenseAdd on License {
  static License? fromJson(String json) => LicenseAdd.fromMap(jsonDecode(json) as Map);
  String toJson() => jsonEncode(toMap());

  static License? fromMap(Map map) {
    if (map.isEmpty) return null;
    return License(
        type: map["type"], href: map["href"], value: map["value"]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["type"] = type;
    map["href"] = href;
    map["value"] = value;
    return map;
  }
}

extension PeerLinkAdd on PeerLink {
  static PeerLink? fromJson(String json) => PeerLinkAdd.fromMap(jsonDecode(json) as Map);
  String toJson() => jsonEncode(toMap());

  static PeerLink? fromMap(Map map) {
    if (map.isEmpty) return null;
    return PeerLink(
        type: map["type"], href: map["href"], value: map["value"]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["type"] = type;
    map["href"] = href;
    map["value"] = value;
    return map;
  }
}

extension RightsAdd on Rights {
  static Rights? fromJson(String json) => RightsAdd.fromMap(jsonDecode(json) as Map);
  String toJson() => jsonEncode(toMap());

  static Rights? fromMap(Map map) {
    if (map.isEmpty) return null;
    return Rights(
        status: map["status"]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["status"] = status;
    return map;
  }
}

extension SceneAdd on Scene {
  static Scene? fromJson(String json) => SceneAdd.fromMap(jsonDecode(json) as Map);
  static List<Scene> fromMapList(List<dynamic> mapList) => mapList.map((e) => SceneAdd.fromMap(e)!).toList();
  static String? toJsonList(List<Scene>? links) => jsonEncode(links?.map((e) => e.toMap()).toList());
  String toJson() => jsonEncode(toMap());

  static Scene? fromMap(Map map) {
    if (map.isEmpty) return null;
    return Scene(
        title: map["title"],
        description: map["description"],
        startTime: map["startTime"],
        endTime: map["endTime"]
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["title"] = title;
    map["description"] = description;
    map["startTime"] = startTime;
    map["endTime"] = endTime;
    return map;
  }
}