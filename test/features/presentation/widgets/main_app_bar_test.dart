


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:messenger/features/presentation/widgets/main_app_bar.dart';


void main() {

  Widget makeTestableWidget() {
    return const MaterialApp(
      home: Scaffold(
        body: MainAppBar()
      ),
    );
  }

  testWidgets("Test MainAppBar widget", (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    expect(find.byType(Container), findsWidgets,);
    expect(find.byType(MainAppBarListItem), findsWidgets);
    expect(find.byType(Icon), findsWidgets);
    expect(find.byType(Text), findsWidgets);
  });
}