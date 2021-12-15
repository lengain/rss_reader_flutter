import 'package:flutter/material.dart';
import 'dart:ui';

double kScreenWidth() {
  return window.physicalSize.width / window.devicePixelRatio;
}

double kScreenHeight() {
  return window.physicalSize.height / window.devicePixelRatio;
}

double kOnePix() {
  return 1.0 / window.devicePixelRatio;
}

double padding15() {
  return 15;
}
double padding10() {
  return 10;
}

class GlobalConfig {

  static const DEBUG = true;
  static const Page_Size = 20;

  static const MaterialColor mainColor = MaterialColor(
    _mainPrimaryValue,
    <int, Color>{
      50: Color(0xFFFCC102),
      100: Color(0xFFFCC102),
      200: Color(0xFFFCC102),
      300: Color(0xFFFCC102),
      400: Color(0xFFFCC102),
      500: Color(_mainPrimaryValue),
      600: Color(0xFFFCC102),
      700: Color(0xFFFCC102),
      800: Color(0xFFFCC102),
      900: Color(0xFFFCC102),
    },
  );
  static const int _mainPrimaryValue = 0xFFFCC102;
}

