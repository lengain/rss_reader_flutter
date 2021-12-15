
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

CupertinoPageScaffold navigationViewController(Widget child,{String? title, Widget? rightBarItem,CupertinoNavigationBar? navigationBar}) {
  return CupertinoPageScaffold(
    navigationBar: navigationBar ?? CupertinoNavigationBar(
      backgroundColor: Colors.white,
      middle: Text(title ?? "",maxLines: 1,overflow: TextOverflow.ellipsis),
      trailing: rightBarItem,
    ),
    child: child,
  );
}