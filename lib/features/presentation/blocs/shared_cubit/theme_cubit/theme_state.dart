part of 'theme_cubit.dart';

class ThemeState extends Equatable{
  final ThemeData themeData;
  final bool isDark;

  const ThemeState(this.themeData, this.isDark);

  @override
  List<Object?> get props => [themeData, isDark];

}