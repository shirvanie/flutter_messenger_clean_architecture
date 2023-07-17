


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/features/data/models/message_model.dart';
import 'package:messenger/features/presentation/widgets/message_list_item.dart';


void main() {

  Widget makeTestableTextWidget() {
    return const MaterialApp(
      home: Scaffold(
        body: MessageListItem(
          messageItem: MessageModel(
            messageCategory: MessageCategoryModel.text,
            messageBody: "Hi Dear!",
            messageDateTime: "2023-01-01 12:00:00",
            messageType: MessageTypeModel.sent,
          ),)
      ),
    );
  }

  Widget makeTestableImageWidget() {
    return const MaterialApp(
      home: Scaffold(
          body: MessageListItem(
            messageItem: MessageModel(
              messageCategory: MessageCategoryModel.image,
              messageBody: "assets/images/avatars/man_avatar1.jpg",
              messageDateTime: "2023-01-01 12:00:00",
              messageType: MessageTypeModel.sent,
            ),)
      ),
    );
  }


  testWidgets("Test MessageListItem(Text) widget", (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableTextWidget());
    expect(find.byType(GestureDetector), findsWidgets);
    expect(find.byType(Container), findsWidgets,);
    expect(find.byType(Row), findsWidgets);
    expect(find.byType(Wrap), findsWidgets);
    expect(find.byType(Padding), findsWidgets);
    expect(find.byType(Text), findsWidgets);
  });

  testWidgets("Test MessageListItem(Image) widget", (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableImageWidget());
    expect(find.byType(GestureDetector), findsWidgets);
    expect(find.byType(Container), findsWidgets,);
    expect(find.byType(Row), findsWidgets);
    expect(find.byType(Image), findsWidgets);
  });
}