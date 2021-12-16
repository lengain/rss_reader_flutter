import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rss_reader_flutter/global/global_handler.dart';

CupertinoPageScaffold navigationViewController(
    Widget child, BuildContext context,
    {String? title,
    Widget? rightBarItem,
    CupertinoNavigationBar? navigationBar,
    bool hideBackButton = false}) {
  return CupertinoPageScaffold(
    backgroundColor: Theme.of(context).backgroundColor,
    navigationBar: navigationBar ??
        CupertinoNavigationBar(
          brightness: Theme.of(context).brightness,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          middle: Text(
            title ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          trailing: rightBarItem,
          leading: hideBackButton
              ? null
              : CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Icon(Icons.arrow_back_ios,
                      size: 20, color: Theme.of(context).primaryColor),
                  onPressed: () {
                    GlobalHandler.popViewController(context);
                  }),
        ),
    child: child,
  );
}
