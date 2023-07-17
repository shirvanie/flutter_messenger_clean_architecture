


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:messenger/features/presentation/blocs/shared_cubit/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import 'package:messenger/features/presentation/widgets/main_bottom_navigation_bar.dart';

void main() {

  Widget makeTestableWidget() {
    return MaterialApp(
      home: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider<BottomNavigationBarCubit>(
              create: (context) => BottomNavigationBarCubit(),
            ),
          ],
          child: const MainBottomNavigationBar(height: 50),
        ),
      )
    );
  }

  testWidgets("Test MainBottomNavigationBar widget", (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    expect(find.byType(BottomAppBar), findsOneWidget,);
    expect(find.byType(Container), findsWidgets,);
    expect(find.byType(BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarState>), findsOneWidget);
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(IconButton), findsWidgets);
    expect(find.byType(Icon), findsWidgets);
  });
}