import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rss_reader_flutter/Business/Data/database_manager.dart';
import 'package:rss_reader_flutter/Business/FollowList/follow_view_controller.dart';
import 'package:rss_reader_flutter/Business/FollowList/rss_view_controller.dart';
import 'package:rss_reader_flutter/global/global_config.dart';
import 'package:rss_reader_flutter/global/global_handler.dart';
import 'package:rss_reader_flutter/global/network/network.dart';
import 'package:rss_reader_flutter/global/notification_center.dart';
import 'package:webfeed/domain/atom_feed.dart';
import '../navigation_controller.dart';

CupertinoPageScaffold addRssNavigationController() {
  return navigationViewController(const AddRssViewController(),title:"添加RSS");
}

class AddRssViewController extends StatefulWidget {
  const AddRssViewController({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => AddRssViewControllerState();
}

class AddRssViewControllerState extends State <AddRssViewController> {

  final TextEditingController _controller = TextEditingController();

  Future<void> checkAvailable(String rss, VoidCallback callback) async {
      GlobalHandler.showLoading(context);
      if (!RegExp("[a-zA-z]+://[^\\s]*").hasMatch(rss)) {
        GlobalHandler.showToast("请输入正确的网址");
      }
      NetworkResult result = await LNNetworkManager().get(rss);
      if (result.success) {
        try {
          GlobalHandler.dismissLoading(context);
          var rssFeed = AtomFeed.parse(result.data);
          GlobalHandler.pushViewController(context, RssViewController(atomFeed: rssFeed));
        } catch(e) {
          GlobalHandler.dismissLoading(context);
          GlobalHandler.showToast(e.toString());
        }
      }else {
        GlobalHandler.dismissLoading(context);
        GlobalHandler.showToast(result.error.toString());
      }
  }

  void complete(String rss) {
      checkAvailable(rss, () {

      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 44,
            child: CupertinoTextField(
              clearButtonMode:OverlayVisibilityMode.editing,
              keyboardType: TextInputType.url,
              controller: _controller,
              autofocus: true,
              placeholder: "请输入Rss网址",
              onSubmitted: (rss) {
                complete(rss);
              },
            ),
          ),
          SizedBox.fromSize(size: const Size(0,20)),
          SizedBox(
            width: kScreenWidth() - 30,
            height: 44,
            child: FloatingActionButton(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              isExtended: true,
              onPressed: (){
                //传入空的焦点，隐藏键盘
                FocusScope.of(context).requestFocus(FocusNode());
                complete(_controller.text);
              },
              child: const Text("下一步"),
            ),
          ),
          SizedBox.fromSize(size: const Size(0,10)),
          uiLabel("github.com等网址可能需要多次重试\n外网无法访问或翻墙后访问",textColor: CupertinoColors.systemGrey,fontSize: 12),
        ],
      ),
      color: Colors.white,
    );
  }
}
