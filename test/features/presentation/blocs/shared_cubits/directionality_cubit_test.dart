




import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:messenger/features/presentation/blocs/shared_cubit/directionality_cubit/directionality_cubit.dart';


void main() {
  late DirectionalityCubit directionalityCubit;

  setUp(() {
    directionalityCubit = DirectionalityCubit();
  });

  test("initial state should be DirectionalityState", () {
    // assert
    expect(directionalityCubit.state, equals(const DirectionalityState(TextDirection.ltr, true)));
  });

  blocTest<DirectionalityCubit, DirectionalityState>(
    'Should emit [DirectionalityState] when data is gotten successfully',
    build: () => directionalityCubit,
    act: (cubit) => cubit.setDirectionality(TextDirection.rtl),
    expect: () => [
      const DirectionalityState(TextDirection.rtl, false),
    ],
    verify: (cubit) => directionalityCubit,
  );

  blocTest<DirectionalityCubit, DirectionalityState>(
    'Should emit [DirectionalityState] when data is gotten successfully',
    build: () => directionalityCubit,
    act: (cubit) => cubit.switchDirectionality(),
    expect: () => [
      const DirectionalityState(TextDirection.rtl, true),
    ],
    verify: (cubit) => directionalityCubit,
  );
}