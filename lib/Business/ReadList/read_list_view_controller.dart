import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rss_reader_flutter/Business/Data/article_item.dart';
import 'package:rss_reader_flutter/Business/Data/atom_network_provider.dart';
import 'package:rss_reader_flutter/Business/Data/database_manager.dart';
import 'package:rss_reader_flutter/Business/FollowList/add_rss_view_controller.dart';
import 'package:rss_reader_flutter/Business/ReadList/read_web_view_controller.dart';
import 'package:rss_reader_flutter/global/global_config.dart';
import 'package:rss_reader_flutter/global/global_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import '../navigation_controller.dart';
import 'package:rss_reader_flutter/global/notification_center.dart';

const String articleListUpdateNotification = "articleListUpdate";

class ReadListViewController extends StatefulWidget {
  const ReadListViewController({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ReadListViewControllerState();
}

class ReadListViewControllerState extends State<ReadListViewController> {
  var _page = 1;
  var dataLists = <ArticleItem>[];
  bool hasLoadData = false;

  @override
  Widget build(BuildContext context) {
    return navigationViewController(
        hasLoadData
            ? (dataLists.isNotEmpty ? _refreshArticleListView(context) : _emptyView())
            : GlobalHandler.loadingView(context),
        context,
        title: "阅读",
      hideBackButton: true,
    );
  }

  @override
  void dispose() {
    //移除所有通知
    NotificationCenter.defaultCenter()
        .removeNotification(associatedObject: widget);
    super.dispose();
  }

  @override
  void initState() {
    //添加通知
    NotificationCenter.defaultCenter()
        .addNotification(articleListUpdateNotification, widget, (arg) {
      update();
    });

    NotificationCenter.defaultCenter()
        .addNotification(dataBaseOpenNotification, widget, (arg) {
      update();
    });
    super.initState();
    update();
  }

  void update() async {
    _page = 1;
    loadData();
    if (await AtomNetworkProvider.syncAtomFromNetwork()) {
      _page = 1;
      loadData();
    }
  }

  void loadMore() {
    _page++;
    loadData();
  }

  void loadData() async {
    print("loadData");
    var list = await DatabaseManager.defaultManager().articleList(_page);
    if (_page == 1) {
      dataLists.clear();
    }
    list?.forEach((element) {
      dataLists.add(element);
    });
    hasLoadData = true;
    setState(() {});
  }

  void _addRssAction() {
    GlobalHandler.pushViewController(context, addRssNavigationController(context));
  }

  Widget _refreshArticleListView(BuildContext context) {
    if (Platform.isIOS) {
      return CustomScrollView(
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              return update();
            },
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                if (index == dataLists.length - 1) {
                  return _articleCell(context,index);
                }else {
                  return Column(
                    children: [
                      _articleCell(context,index),
                      _separatorView(context),
                    ],
                  );
                }
              },
              childCount: dataLists.length,
            ),
          ),
        ],
      );
    } else {
      return RefreshIndicator(
          displacement: 30,
          color: CupertinoColors.link,
          child: _articleListView(),
          onRefresh: () async {
            return update();
          });
    }
  }

  Widget _separatorView(BuildContext context) {
    return Row(
      children: [
        SizedBox.fromSize(size: Size(20, kOnePix())),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          height: kOnePix(),
          width: kScreenWidth() - 20,
          color: Theme.of(context).dividerColor,
        ),
      ],
    );
  }

  Widget _articleListView() {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return _separatorView(context);
        },
        itemCount: dataLists.length,
        itemBuilder: (BuildContext context, int index) {
          return _articleCell(context,index);
        });
  }

  Widget _articleCell(BuildContext context, int index) {
    var article = dataLists[index];
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: Theme.of(context).unselectedWidgetColor,
          width: kScreenWidth(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              uiLabel(article.title,
                  style: Theme.of(context).textTheme.subtitle1, maxLines: 3),
              const SizedBox(height: 8),
              uiLabel(article.updateTime(),
                  style: Theme.of(context).textTheme.bodyText2),
            ],
          )),
      onTapUp: (TapUpDetails details) async {
        var articleItem = dataLists[index];
        var url = articleItem.articleUrl();
        if (url != null) {
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            GlobalHandler.pushViewController(
                context, ReadWebViewController(articleItem));
          }
        } else {
          GlobalHandler.pushViewController(
              context, ReadWebViewController(articleItem));
        }
      },
    );
  }

  Widget _emptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          uiLabel("空空如也", textColor: CupertinoColors.systemGrey),
          SizedBox(
            width: 200,
            height: 40,
            child: CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: _addRssAction,
              child: uiLabel("去添加RSS", textColor: CupertinoColors.activeBlue),
            ),
          )
        ],
      ),
    );
  }
}
