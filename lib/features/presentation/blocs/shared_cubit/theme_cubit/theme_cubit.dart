import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:messenger/core/themes/app_theme.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {

  ThemeCubit() : super(ThemeState(AppTheme.darkTheme(), true));

  void setThemeData(ThemeData themeData, bool isDark) async {
    emit(ThemeState(themeData, isDark));
  }

  void switchTheme() {
    ThemeData themeData = state.isDark ? AppTheme.lightTheme() : AppTheme.darkTheme();
    emit(ThemeState(themeData, !state.isDark));
  }

}
