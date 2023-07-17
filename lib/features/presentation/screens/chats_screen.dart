

import 'package:flutter/material.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/features/data/models/user_model.dart';
import 'package:messenger/features/presentation/widgets/chat_list_item.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(20, 0, 10, 5),
          child: Text("Chats", style: TextStyle(
            fontSize: 20,
            fontFamily: Constants.appFontHelveticaBold,
            color: Theme.of(context).colorScheme.onBackground,),
            overflow: TextOverflow.ellipsis,),
        ),
        ChatListItem(
          user: UserModel(
            fullName: "Oliver Clark",
            lastMessageBody: "I'm good too. I just wanted to chat with you.",
            lastSeenDateTime: DateTime.now().toString(),
            userAvatar: "assets/images/avatars/man_avatar1.jpg",
          ),
          notSeenCount: "1",
          isOnline: true,
        ),
        ChatListItem(
          user: UserModel(
            fullName: "Ava Williams",
            lastMessageBody: "That's great! I'm happy to talk to you. What's up?",
            lastSeenDateTime: DateTime.now().toString(),
            userAvatar: "assets/images/avatars/woman_avatar1.jpg",
          ),
          notSeenCount: "3",
          isOnline: true,
        ),
        ChatListItem(
          user: UserModel(
            fullName: "Liam Harris",
            lastMessageBody: "Take a look at this picture",
            lastSeenDateTime: DateTime.now().toString(),
            userAvatar: "assets/images/avatars/man_avatar2.jpg",
          ),
        ),
        ChatListItem(
          user: UserModel(
            fullName: "Emma Wilson",
            lastMessageBody: "Wow! What a beautiful view! I really enjoyed it. It seems like you had an amazing trip",
            lastSeenDateTime: DateTime.now().toString(),
            userAvatar: "assets/images/avatars/woman_avatar2.jpg",
          ),
          notSeenCount: "10",
          isOnline: true,
        ),
        ChatListItem(
          user: UserModel(
            fullName: "Benjamin Davis",
            lastMessageBody: "Yes, being in nature and its tranquility was truly delightful. I felt a sense of freedom in the fresh air.",
            lastSeenDateTime: DateTime.now().toString(),
            userAvatar: "assets/images/avatars/man_avatar3.jpg",
          ),
        ),
        ChatListItem(
          user: UserModel(
            fullName: "Ava White",
            lastMessageBody: "That's awesome that you had a great time. Where else did you go?",
            lastSeenDateTime: DateTime.now().toString(),
            userAvatar: "assets/images/avatars/woman_avatar3.jpg",
          ),
        ),
        ChatListItem(
          user: UserModel(
            fullName: "James Miller",
            lastMessageBody: "After the forest, I visited a small village. The people there were very hospitable, and the local food was amazing.",
            lastSeenDateTime: DateTime.now().toString(),
            userAvatar: "assets/images/avatars/man_avatar4.jpg",
          ),
          notSeenCount: "5",
          isOnline: true,
        ),
        ChatListItem(
          user: UserModel(
            fullName: "Lily Thompson",
            lastMessageBody: "It sounds like a wonderful experience. I hope I can visit those areas someday.",
            lastSeenDateTime: DateTime.now().toString(),
            userAvatar: "assets/images/avatars/woman_avatar4.jpg",
          ),
        ),
        ChatListItem(
          user: UserModel(
            fullName: "Alexander Wilson",
            lastMessageBody: "Definitely! I believe you'll also enjoy these beautiful trips. Do you have any plans for another trip?",
            lastSeenDateTime: DateTime.now().toString(),
            userAvatar: "assets/images/avatars/man_avatar5.jpg",
          ),
          notSeenCount: "2",
          isOnline: true,
        ),
        ChatListItem(
          user: UserModel(
            fullName: "Isabella Thompson",
            lastMessageBody: "I don't have any specific plans at the moment, but I'd love to go on more trips.",
            lastSeenDateTime: DateTime.now().toString(),
            userAvatar: "assets/images/avatars/woman_avatar5.jpg",
          ),
          notSeenCount: "7",
          isOnline: true,
        ),
      ],
    );
  }
}

