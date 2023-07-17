


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:messenger/features/presentation/widgets/blur.dart';


void main() {

  Widget makeTestableWidget() {
    return MaterialApp(
      home: Scaffold(
        body: Blur(
          sigmaX: 1.2,
          sigmaY: 1.2,
          child: Container(
            height: 85,
          ),
        ),
      ),
    );
  }

  testWidgets("Test Blur widget", (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    expect(find.byType(Stack), findsWidgets,);
    expect(find.byType(ClipRect), findsOneWidget);
  });
}