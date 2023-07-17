import 'package:flutter/material.dart';

@immutable
abstract class AppColor {
  const AppColor();

  static const Color mainAppBarGradient1 = Color(0xff5F44B9);
  static const Color mainAppBarGradient2 = Color(0xff8F5BE3);
  static const Color mainAppBarGradient3 = Color(0xff9869e3);
  static const Color mainAppBarGradient4 = Color(0xff8768DD);
  static const Color mainAppBarGradient5 = Color(0xff7659d5);
  static const Color mainAppBarGradient6 = Color(0xff5F44B9);
  static const Color snackBarSuccess = Color(0xff01E47A);
  static const Color snackBarFailed = Color(0xffFE5151);
  static const Color transparent = Colors.transparent;

  /// light
  static const Color backgroundColorLight = Color(0xffffffff);
  static const Color onBackgroundColorLight = Color(0xff121212);
  static const Color bottomNavigationBarLight = Color(0xffffffff);
  static const Color primaryLight = Color(0xff7050d9);
  static const Color onPrimaryLight = Color(0xfffefefe);
  static const Color secondaryLight = Color(0xff8768DD);
  static const Color onSecondaryLight = Color(0xff8596A0);
  static const Color borderLight = Color(0xff5F44B9);
  static const Color errorLight = Colors.redAccent;
  static const Color onErrorLight = Color(0xffffffff);
  static const Color surfaceLight = Color(0xff7050d9);
  static const Color onSurfaceLight = Color(0xffffffff);
  static const Color bottomNavigationBarDividerColorLight = Color(0xffeeeeee);
  static const Color chatPageSystemNavigationBarColorLight = Color(0xff5F44B9);
  static const Color rightMessageColorLight = Color(0xffcecbff);
  static const Color leftMessageColorLight = Color(0xffffffff);
  static const Color rightMessageTextColorLight = Color(0xff222222);
  static const Color leftMessageTextColorLight = Color(0xff222222);

  /// dark
  static const Color backgroundColorDark = Color(0xff121212);
  static const Color onBackgroundColorDark = Color(0xffffffff);
  static const Color bottomNavigationBarDark = Color(0xff121212);
  static const Color primaryDark = Color(0xff443463);
  static const Color onPrimaryDark = Color(0xffaaa1c2);
  static const Color secondaryDark = Color(0xff774efa);
  static const Color onSecondaryDark = Color(0xffBBB7C6);
  static const Color borderDark = Color(0xff5F44B9);
  static const Color errorDark = Colors.redAccent;
  static const Color onErrorDark = Color(0xffffffff);
  static const Color surfaceDark = Color(0xff7050d9);
  static const Color onSurfaceDark = Color(0xffBBB7C6);
  static const Color bottomNavigationBarDividerColorDark = Color(0xff222222);
  static const Color chatPageSystemNavigationBarColorDark = Color(0xFF2F2653);
  static const Color rightMessageColorDark = Color(0xff5F44B9);
  static const Color leftMessageColorDark = Color(0xff443463);
  static const Color rightMessageTextColorDark = Color(0xffeeeeee);
  static const Color leftMessageTextColorDark = Color(0xffeeeeee);
}
