
import 'package:flutter/foundation.dart';
import 'package:rss_reader_flutter/Business/Data/database_manager.dart';
import 'package:rss_reader_flutter/global/network/network.dart';
import 'package:webfeed/domain/atom_feed.dart';
import 'package:webfeed/domain/atom_item.dart';
import '../Data/feed/atom_model_extension.dart';

class AtomNetworkProvider {

  static Future<bool> syncAtomFromNetwork() async {
    var feedList = await DatabaseManager().feedList();
    var updated = false;
    if (feedList != null) {
      for (var feed in feedList) {
        print("正在获取" + (feed.selfLink() ?? ""));
        NetworkResult result = await LNNetworkManager().get(feed.selfLink());
        if (result.success) {
          print("获取成功" + (feed.selfLink() ?? ""));
          try {
            var rssFeed = AtomFeed.parse(result.data);
            if (rssFeed.updated != feed.updated) {
              DatabaseManager().insertAtomItemFromFeed(rssFeed);
              updated = true;
            }
            print("更新结果：$updated");
          } catch(e) {
            if (kDebugMode) {
              print(e);
            }
          }
        }else {
          if (kDebugMode) {
            print(result.error.toString());
          }
        }
      }
    }
    return updated;
  }


}