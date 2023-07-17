
import 'package:flutter/material.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/routes/animated_page_route.dart';

import '../colors/app_color.dart';


class AppTheme {
  const AppTheme();

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CustomOpenUpwardsPageTransitionsBuilder(),
        },
      ),
      fontFamily: Constants.appFontHelvetica,
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: AppColor.bottomNavigationBarLight
      ),
      colorScheme: const ColorScheme(
        background: AppColor.backgroundColorLight,
        onBackground: AppColor.onBackgroundColorLight,
        brightness: Brightness.light,
        primary: AppColor.primaryLight,
        onPrimary: AppColor.onPrimaryLight,
        secondary: AppColor.secondaryLight,
        onSecondary: AppColor.onSecondaryLight,
        error: AppColor.errorLight,
        onError: AppColor.onErrorLight,
        surface: AppColor.surfaceLight,
        onSurface: AppColor.onSurfaceLight,
      )
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CustomOpenUpwardsPageTransitionsBuilder(),
        },
      ),
      fontFamily: Constants.appFontHelvetica,
      navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: AppColor.bottomNavigationBarDark
      ),
      colorScheme: const ColorScheme(
        background: AppColor.backgroundColorDark,
        onBackground: AppColor.onBackgroundColorDark,
        brightness: Brightness.dark,
        primary: AppColor.primaryDark,
        onPrimary: AppColor.onPrimaryDark,
        secondary: AppColor.secondaryDark,
        onSecondary: AppColor.onSecondaryDark,
        error: AppColor.errorDark,
        onError: AppColor.onErrorDark,
        surface: AppColor.surfaceDark,
        onSurface: AppColor.onSurfaceDark,
      )
    );
  }
}
