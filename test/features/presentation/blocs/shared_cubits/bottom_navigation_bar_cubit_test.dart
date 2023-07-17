




import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:messenger/features/presentation/blocs/shared_cubit/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';


void main() {
  late BottomNavigationBarCubit bottomNavigationBarCubit;

  setUp(() {
    bottomNavigationBarCubit = BottomNavigationBarCubit();
  });

  test("initial state should be BottomNavigationBarState", () {
    // assert
    expect(bottomNavigationBarCubit.state, equals(const BottomNavigationBarState(ActiveIcon.icon1)));
  });

  blocTest<BottomNavigationBarCubit, BottomNavigationBarState>(
    'Should emit [BottomNavigationBarState] when data is gotten successfully',
    build: () => bottomNavigationBarCubit,
    act: (cubit) => cubit.setActiveIcon(ActiveIcon.icon1),
    expect: () => [
      const BottomNavigationBarState(ActiveIcon.icon1),
    ],
    verify: (cubit) => bottomNavigationBarCubit,
  );
}