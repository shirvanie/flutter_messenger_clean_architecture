




import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:messenger/core/themes/app_theme.dart';
import 'package:messenger/features/presentation/blocs/shared_cubit/theme_cubit/theme_cubit.dart';


void main() {
  late ThemeCubit themeCubit;

  setUp(() {
    themeCubit = ThemeCubit();
  });

  test("initial state should be ThemeState", () {
    // assert
    expect(themeCubit.state, equals(ThemeState(AppTheme.darkTheme(), true)));
  });

  blocTest<ThemeCubit, ThemeState>(
    'Should emit [ThemeState] when data is gotten successfully',
    build: () => themeCubit,
    act: (cubit) => cubit.setThemeData(AppTheme.lightTheme(), false),
    expect: () => [
      ThemeState(AppTheme.lightTheme(), false),
    ],
    verify: (cubit) => themeCubit,
  );

  blocTest<ThemeCubit, ThemeState>(
    'Should emit [ThemeState] when data is gotten successfully',
    build: () => themeCubit,
    act: (cubit) => cubit.switchTheme(),
    expect: () => [
      ThemeState(AppTheme.lightTheme(), false),
    ],
    verify: (cubit) => themeCubit,
  );
}