

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:messenger/features/presentation/widgets/chat_list_item.dart';
import 'package:messenger/features/presentation/widgets/message_list_item.dart';
import 'package:messenger/injection_container.dart';
import 'package:messenger/main.dart';

void main() {

  group("Chat Flow Test", () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets("MyApp Test", (tester) async {
      //arrange
      await initLocator();
      await tester.pumpWidget(const MyApp());
      //act
      Finder chatListItem = find.byType(ChatListItem).first;
      await tester.tap(chatListItem);
      await tester.pumpAndSettle();
      Finder messageTextField = find.byType(TextField);
      await tester.enterText(messageTextField, "Hi Dear!");
      Finder buttonSendMessage = find.byKey(const ValueKey("buttonSendMessageKey"));
      await tester.tap(buttonSendMessage);
      await tester.pumpAndSettle();
      Finder messageListItem = find.byType(MessageListItem).last;
      await tester.pumpAndSettle();
      //assert
      expect(messageListItem, findsWidgets);
    });
  });
}