import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:rss_reader_flutter/Business/tab_bar_controller.dart';

void main() {
  runApp(const MyApp());
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  ThemeData _lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: CupertinoColors.activeBlue,
      //整体背景色
      backgroundColor: CupertinoColors.systemGroupedBackground,
      //主控件背景色
      unselectedWidgetColor: CupertinoColors.systemBackground,
      //分割线背景色
      dividerColor: CupertinoColors.separator,
      //导航栏
      appBarTheme: const AppBarTheme(
        //导航栏背景色
        backgroundColor: Colors.white,
        //导航栏标题
        titleTextStyle: TextStyle(
            color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      //底部选择栏
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          unselectedIconTheme: IconThemeData(color: Colors.grey, size: 28),
          selectedIconTheme:
              IconThemeData(color: CupertinoColors.activeBlue, size: 28)),
      //文本
      textTheme: const TextTheme(
        //列表标题
        subtitle1: TextStyle(
            color: Colors.black87, fontSize: 16, fontWeight: FontWeight.normal),
        //列表内容灰色
        bodyText2: TextStyle(
            color: CupertinoColors.systemGrey,
            fontSize: 14,
            fontWeight: FontWeight.normal),
      ),
    );
  }

  ThemeData _darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: CupertinoColors.white,
      //整体背景色
      backgroundColor: CupertinoColors.darkBackgroundGray,
      //主控件背景色
      unselectedWidgetColor: CupertinoColors.black,
      //分割线背景色
      dividerColor: CupertinoColors.systemGrey,
      //导航栏
      appBarTheme: const AppBarTheme(
        //导航栏背景色
        backgroundColor: Colors.black,
        //导航栏标题
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      //底部选择栏
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          unselectedIconTheme: IconThemeData(color: Colors.grey, size: 28),
          selectedIconTheme:
          IconThemeData(color: CupertinoColors.white, size: 28)),
      //文本
      textTheme: const TextTheme(
        //列表标题
        subtitle1: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),
        //列表内容灰色
        bodyText2: TextStyle(
            color: CupertinoColors.systemGrey,
            fontSize: 14,
            fontWeight: FontWeight.normal),
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rss Reader',
      theme: _lightTheme(),
      darkTheme: _darkTheme() ,
      home: const TabBarController(),
    );
  }
}
