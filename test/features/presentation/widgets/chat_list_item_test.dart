


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:messenger/features/data/models/user_model.dart';
import 'package:messenger/features/presentation/widgets/chat_list_item.dart';


void main() {

  Widget makeTestableWidget() {
    return const MaterialApp(
      home: Scaffold(
          body: ChatListItem(
            user: UserModel(
              fullName: "",
              userAvatar: "assets/images/avatars/man_avatar1.jpg",
              lastMessageBody: "",
              lastSeenDateTime: "",
            ),)
      ),
    );
  }

  testWidgets("Test ChatListItem widget", (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    expect(find.byType(Container), findsWidgets,);
    expect(find.byType(MaterialButton), findsWidgets);
    expect(find.byType(Padding), findsWidgets);
    expect(find.byType(GestureDetector), findsWidgets);
    expect(find.byType(Image), findsWidgets);
    expect(find.byType(Expanded), findsWidgets);
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(Text), findsWidgets);
    expect(find.byType(Transform), findsWidgets);
  });
}