import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rss_reader_flutter/global/global_handler.dart';
import 'package:rss_reader_flutter/global/notification_center.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:webfeed/domain/atom_feed.dart';
import 'article_item.dart';
import 'feed/atom_model_extension.dart';

const String dataBaseOpenNotification = "DataBaseOpenSuccess";

class DatabaseManager {

  final _lock = Lock();
  var _open = false;
  late Database _db;
  DatabaseManager._internal() {
    _initDB();
  }

  static final DatabaseManager _singleton = DatabaseManager._internal();
  factory DatabaseManager() => _singleton;
  static DatabaseManager defaultManager() => _singleton;

  Future<void> _initDB() async {
    try {
      _db = await openDatabase(
        join(await getDatabasesPath(), 'rss_internal.db'),
        version: 1,
        onOpen: (db) {
          print("onOpen DB");
          _open = true;
          Future.delayed(const Duration(seconds: 1),() {
            NotificationCenter.defaultCenter().postNotification(dataBaseOpenNotification);
          });
        },
        onCreate: (db,version) async {
          //feed表，存储Rss信息，即AtomFeed
          await db.execute("CREATE TABLE IF NOT EXISTS feed ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "feedId TEXT UNIQUE,"
              "feedIndex INTEGER,"
              "title TEXT,"
              "updated TEXT,"
              "icon TEXT,"
              "logo TEXT,"
              "rights TEXT,"
              "subtitle TEXT,"
              "links TEXT,"
              "authors TEXT,"
              "contributors TEXT,"
              "generator TEXT,"
              "categories TEXT)"
              );
          //article表，用来存储文章列表,即AtomItem
          //isRead标记是否已读
          //hide标记是否隐藏（删除即隐藏）
          await db.execute("CREATE TABLE IF NOT EXISTS article ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "isRead INTEGER DEFAULT 0,"
              "isFavorite INTEGER DEFAULT 0,"
              "isHide INTEGER DEFAULT 0,"
              "feedId TEXT,"
              "feedTitle TEXT,"
              "feedIcon TEXT,"
              "articleId TEXT UNIQUE,"
              "title TEXT,"
              "updated TEXT,"
              "authors TEXT,"
              "links TEXT,"
              "categories TEXT,"
              "contributors TEXT,"
              "source TEXT,"
              "published TEXT,"
              "content TEXT,"
              "summary TEXT,"
              "rights TEXT,"
              "media TEXT)");
          print("onCreate DB");
        }
      );
    } catch(e) {
      GlobalHandler.showToast(e.toString());
    }
  }

  Future<bool> insertFeed(AtomFeed feed) async {
    try {
      var queryList = await _db.rawQuery("SELECT COUNT(id) FROM feed");
      var count = queryList.first["COUNT(id)"] ?? 0;
      var feedMap = feed.toMap();
      feedMap["feedIndex"] = count;
      int result = await _db.insert("feed", feedMap,conflictAlgorithm: ConflictAlgorithm.ignore);
      if (kDebugMode) {
        print( "插入Feed结果:" + result.toString() + "\n" + feedMap.toString());
      }
      return result != 0;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  Future <bool> insertAtomItemFromFeed(AtomFeed feed) async {
    try {
      feed.items?.forEach((element) async {
        var articleMap = element.toMap();
        articleMap["feedId"] = feed.id;
        articleMap["feedTitle"] = feed.title;
        articleMap["feedIcon"] = feed.favicon();
        int result = await _db.insert("article", articleMap,conflictAlgorithm:ConflictAlgorithm.ignore);
        if (kDebugMode) {
          print( "插入文章结果:" + result.toString() + "\n" + articleMap.toString());
        }
      });
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  Future<List<AtomFeed>?> feedList() async {
    if (_open == false) return null;
    // List<Map> maps = await _db.query("feed", orderBy: "updated");
    List<Map> maps = await _db.rawQuery("SELECT * FROM feed ORDER BY feedIndex DESC");
    return AtomFeedAdd.fromMapList(maps);
  }

  Future<List <ArticleItem>?> articleList(int page,{int pageCount = 10}) async {
    if (kDebugMode) {
      print("获取ArticleList");
    }
    if (_open == false) return null;
    var offset = ((page >= 1 ? page : 1) - 1) * pageCount;
    var sql = "SELECT * FROM article WHERE isHide = 0 ORDER BY updated DESC LIMIT 10 OFFSET " + offset.toString();
    List<Map> maps = await _db.rawQuery(sql);
    if (kDebugMode) {
      maps.forEach((element) {
        print("获取Article:" + element["title"]);
      });
    }
    return ArticleItemAdd.fromMapList(maps);
  }

  Future<List <ArticleItem>?> favoriteArticleList(int page,{int pageCount = 10}) async {
    if (_open == false) return null;
    var offset = ((page >= 1 ? page : 1) - 1) * pageCount;
    var sql = "SELECT * FROM article WHERE isHide = 0 AND isFavorite = 1 ORDER BY updated DESC LIMIT 10 OFFSET " + offset.toString();
    List<Map> maps = await _db.rawQuery(sql);
    return ArticleItemAdd.fromMapList(maps);
  }

  Future<bool> markArticleToRead(String articleId) async{
    if (_open == false) return false;
    var sql = "UPDATE article SET isRead = ? WHERE articleId = ?";
    var count = await _db.rawUpdate(sql,['1',articleId]);
    return count == 1;
  }

  Future<bool> markArticleToFavorite(String articleId) async{
    if (_open == false) return false;
    var sql = "UPDATE article SET isFavorite = ? WHERE articleId = ?";
    var count = await _db.rawUpdate(sql,['1',articleId]);
    return count == 1;
  }

  Future<bool> removeFavoriteArticle(String articleId) async{
    if (_open == false) return false;
    var sql = "UPDATE article SET isFavorite = ? WHERE articleId = ?";
    var count = await _db.rawUpdate(sql,['0',articleId]);
    return count == 1;
  }

  Future<bool> hideArticle(String articleId) async{
    if (_open == false) return false;
    var sql = "UPDATE article SET isHide = ? WHERE articleId = ?";
    var count = await _db.rawUpdate(sql,['1',articleId]);
    return count == 1;
  }

  void clearArticle() async {
    await _db.execute("DELETE FROM article");
  }

}