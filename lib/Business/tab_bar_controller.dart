import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rss_reader_flutter/Business/Data/database_manager.dart';
import 'package:rss_reader_flutter/Business/ReadList/read_list_view_controller.dart';
import 'FollowList/follow_view_controller.dart';

class TabBarController extends StatefulWidget {
  const TabBarController({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TabBarControllerState();
}

class TabBarControllerState extends State<TabBarController> {

  @override
  void initState() {
    //初始化数据库
    DatabaseManager();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: CupertinoTabController(initialIndex: 0),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          defaultTitle: "rss",
          routes: {
            "/readList": (context) => const ReadListViewController(),
            "/follow": (context) => const FollowViewController(),
          },
          builder: (context) {
            switch (index) {
              case 0:
                return const ReadListViewController();
              case 1:
                return const FollowViewController();
              // case 2:
              //   return _navigationViewController(
              //       const UserCenterViewController(), "我的");
              default:
                return Container();
            }
          },
        );
      },
      tabBar: _tabBarView(),
    );
  }

  CupertinoTabBar _tabBarView() {
    return CupertinoTabBar(
      backgroundColor: Colors.white,
      activeColor: Colors.amber, //选中
      inactiveColor: Colors.amberAccent, //未选中
      items: const [
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.book),
            label: "阅读",
            activeIcon: Icon(CupertinoIcons.book_solid)),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.rectangle_split_3x1),
            label: "关注",
            activeIcon: Icon(CupertinoIcons.rectangle_split_3x1_fill)),
        // BottomNavigationBarItem(
        //     icon: Icon(CupertinoIcons.person),
        //     label: "我的",
        //     activeIcon: Icon(CupertinoIcons.person_solid)),
      ],
    );
  }
}
