import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rss_reader_flutter/Business/Data/database_manager.dart';
import 'package:rss_reader_flutter/global/global_config.dart';
import 'package:rss_reader_flutter/global/global_handler.dart';
import 'package:rss_reader_flutter/global/notification_center.dart';
import 'package:webfeed/domain/atom_feed.dart';
import '../navigation_controller.dart';
import 'follow_view_controller.dart';

class RssViewController extends StatefulWidget {
  final AtomFeed? atomFeed;

  const RssViewController({Key? key, this.atomFeed}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RssViewControllerState();
}

class RssViewControllerState extends State<RssViewController> {
  void update() {
    setState(() {});
  }

  Widget _rssListCell(int index) {
    var item = widget.atomFeed?.items?[index];
    return Container(
      width: kScreenWidth(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          uiLabel(item?.title,fontSize: 16,textColor: Colors.black87),
          const SizedBox(height: 8),
          uiLabel(
              item?.updated.toString(),
              fontSize: 14,
            textColor: CupertinoColors.systemGrey,
            fontWeight: FontWeight.normal
          ),
        ],
      ),
    );
  }

  Widget _rssView() {
    if (widget.atomFeed?.items == null) {
      return const Center(
        child: Text("无数据"),
      );
    } else {
      return ListView.builder(
        // shrinkWrap: true,
        itemCount: widget.atomFeed?.items?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return _rssListCell(index);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return navigationViewController(_rssView(),
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Colors.white,
          middle: Text(widget.atomFeed?.title ?? "RSS预览"),
          trailing: CupertinoButton(
            padding: const EdgeInsets.all(0),
            onPressed: () {
              if (widget.atomFeed != null) {
                DatabaseManager().insertFeed(widget.atomFeed!);
                DatabaseManager().insertAtomItemFromFeed(widget.atomFeed!);
              }
              Future.delayed(const Duration(milliseconds: 500), (){
                NotificationCenter.defaultCenter().postNotification(followUpdateNotification);
              });

              Navigator.of(context).popUntil(ModalRoute.withName('/'));
            },
            child: const Text(
              "添加",
              style: TextStyle(
                decoration: TextDecoration.none,
                color: CupertinoColors.activeBlue,
                fontSize: 16,
              ),
            ),
          ),
        ));
  }
}
