import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rss_reader_flutter/Business/Data/database_manager.dart';
import 'package:rss_reader_flutter/global/global_config.dart';
import 'package:rss_reader_flutter/global/global_handler.dart';
import 'package:rss_reader_flutter/global/notification_center.dart';
import 'package:webfeed/domain/atom_feed.dart';
import '../navigation_controller.dart';
import 'add_rss_view_controller.dart';
import '../Data/feed/atom_model_extension.dart';

const String followUpdateNotification = "FollowViewControllerUpdate";

class FollowViewController extends StatefulWidget {
  const FollowViewController({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FollowViewControllerState();
}

class FollowViewControllerState extends State<FollowViewController> {
  
  bool hasLoadData = false;

  @override
  void dispose() {
    //移除所有通知
    NotificationCenter.defaultCenter().removeNotification(associatedObject: widget);
    super.dispose();
  }
  
  @override
  void initState() {
    //添加通知
    NotificationCenter.defaultCenter()
        .addNotification(followUpdateNotification, widget, (arg) {
      update();
    });

    NotificationCenter.defaultCenter()
        .addNotification(dataBaseOpenNotification, widget, (arg) {
      update();
    });
    super.initState();
    update();
  }

  var dataLists = <AtomFeed>[];
  void update() async{
    dataLists.clear();
    var list = await DatabaseManager.defaultManager().feedList();
    list?.forEach((element) {
      dataLists.add(element);
    });
    hasLoadData = true;
    var documentPath = await getApplicationDocumentsDirectory();
    setState(() {

    });
  }

  Widget _atomFeedListView() {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              SizedBox.fromSize(size: Size(20,kOnePix())),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                height: kOnePix(),
                width: kScreenWidth() - 20,
                color: CupertinoColors.separator,
              ),
            ],
          );
        },
        itemCount: dataLists.length,
        itemBuilder: (BuildContext context, int index) {
      return _rssFeedCell(index);
      }
    );
  }

  Widget _rssFeedCell(int index) {
    var atomFeed = dataLists[index];
    return Container(
      width: kScreenWidth(),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CachedNetworkImage(
            placeholder:(context,url) {
              return const Icon(Icons.eleven_mp);
            },
            imageUrl:atomFeed.favicon(),
          ),
          const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              uiLabel(atomFeed.title,fontSize: 16,textColor: Colors.black87),
              const SizedBox(height: 8),
              uiLabel(
                  atomFeed.updated.toString(),
                  fontSize: 14,
                  textColor: CupertinoColors.systemGrey,
                  fontWeight: FontWeight.normal
              ),
            ],
          )
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return navigationViewController(
        hasLoadData ? (dataLists.isNotEmpty ? _atomFeedListView() : _emptyView()) : GlobalHandler.loadingView(),
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Colors.white,
          middle: const Text("关注"),
          trailing: CupertinoButton(
            onPressed:_addRssAction,
            child: const Icon(CupertinoIcons.add),
          ),
        ));
  }

  void _addRssAction() {
    GlobalHandler.pushViewController(
        context, addRssNavigationController());
  }

  Widget _emptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          uiLabel("空空如也",textColor: CupertinoColors.systemGrey),
          SizedBox(
            width: 200,
            height: 40,
            child: CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: _addRssAction,
              child: uiLabel("去添加RSS",textColor: CupertinoColors.activeBlue),
            ),
          )
        ],
      ),
    );
  }
}
