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

  Widget _rssListCell(BuildContext context, int index) {
    var item = widget.atomFeed?.items?[index];
    return Container(
      color: Theme.of(context).unselectedWidgetColor,
      width: kScreenWidth(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          uiLabel(item?.title, style: Theme.of(context).textTheme.subtitle1),
          const SizedBox(height: 8),
          uiLabel(item?.updated.toString(),
              style: Theme.of(context).textTheme.bodyText2),
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
          return _rssListCell(context, index);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return navigationViewController(_rssView(), context,
        title: widget.atomFeed?.title ?? "RSS预览",
        rightBarItem: CupertinoButton(
          padding: const EdgeInsets.all(0),
          onPressed: () {
            if (widget.atomFeed != null) {
              DatabaseManager().insertFeed(widget.atomFeed!);
              DatabaseManager().insertAtomItemFromFeed(widget.atomFeed!);
            }
            Future.delayed(const Duration(milliseconds: 500), () {
              NotificationCenter.defaultCenter()
                  .postNotification(followUpdateNotification);
            });

            Navigator.of(context).popUntil(ModalRoute.withName('/'));
          },
          child: Text(
            "添加",
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Theme.of(context).primaryColor,
              fontSize: 16,
            ),
          ),
        ));
  }
}
