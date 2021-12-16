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
      tabBar: _tabBarView(context),
    );
  }

  CupertinoTabBar _tabBarView(BuildContext context) {
    return CupertinoTabBar(
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      activeColor: Theme.of(context)
          .bottomNavigationBarTheme
          .selectedIconTheme
          ?.color, //选中
      inactiveColor: Theme.of(context)
          .bottomNavigationBarTheme
          .unselectedIconTheme!
          .color!, //未选中
      items: [
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.fromLTRB(0, 3.5, 0, 0),
            child: Icon(CupertinoIcons.eyeglasses,
                size: (Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedIconTheme
                    ?.size ??
                    28) + 2),
          ),
          label: "阅读",
          activeIcon: Container(
            padding: const EdgeInsets.fromLTRB(0, 3.5, 0, 0),
            child: Icon(
              CupertinoIcons.eyeglasses,
              size: (Theme.of(context)
                  .bottomNavigationBarTheme
                  .selectedIconTheme
                  ?.size ??
                  28) + 2,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.list_bullet,
              size: (Theme.of(context)
                  .bottomNavigationBarTheme
                  .unselectedIconTheme
                  ?.size ??
                  28) - 1),
          label: "关注",
          activeIcon: Icon(CupertinoIcons.list_bullet,
              size: (Theme.of(context)
                  .bottomNavigationBarTheme
                  .selectedIconTheme
                  ?.size ??
                  28) - 1),
        ),
        // BottomNavigationBarItem(
        //     icon: Icon(CupertinoIcons.person),
        //     label: "我的",
        //     activeIcon: Icon(CupertinoIcons.person_solid)),
      ],
    );
  }
}
