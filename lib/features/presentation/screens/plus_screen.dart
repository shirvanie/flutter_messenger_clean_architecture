
import 'package:flutter/material.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/features/data/models/user_model.dart';
import 'package:messenger/features/presentation/widgets/contact_list_item.dart';

class PlusScreen extends StatelessWidget {
  const PlusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: MaterialButton(
              padding: const EdgeInsets.all(0),
              splashColor: Theme
                  .of(context)
                  .colorScheme
                  .onSecondary
                  .withAlpha(80),
              highlightColor: Theme
                  .of(context)
                  .colorScheme
                  .onSecondary
                  .withAlpha(80),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                        width: 60,
                        height: 60,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .colorScheme
                              .primary,
                          borderRadius: const BorderRadius.all(Radius
                              .circular(60)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(50),
                              spreadRadius: 0.3,
                              blurRadius: 4.0,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.group, color: Colors.white,
                          size: 30,)
                    ),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 12),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(7)),
                              ),
                              child: Text("New Group", style: TextStyle(
                                fontSize: 16,
                                fontFamily: Constants.appFontHelveticaBold,
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .onBackground,),
                                overflow: TextOverflow.ellipsis,),
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(20, 10, 10, 5),
          child: Text("Contacts", style: TextStyle(
            fontSize: 20,
            fontFamily: Constants.appFontHelveticaBold,
            color: Theme.of(context).colorScheme.onBackground,),
            overflow: TextOverflow.ellipsis,),
        ),
        ContactListItem(
          user: UserModel(
            fullName: "Alexander Wilson",
            lastSeenDateTime: DateTime.now().toString(),
            userAvatar: "assets/images/avatars/man_avatar5.jpg",
          ),
          isOnline: true,
        ),
        ContactListItem(
          user: UserModel(
            fullName: "Ava White",
            lastSeenDateTime: DateTime.now().toString(),
            userAvatar: "assets/images/avatars/woman_avatar3.jpg",
          ),
        ),
        ContactListItem(
          user: UserModel(
            fullName: "Ava Williams",
            lastSeenDateTime: DateTime.now().toString(),
            userAvatar: "assets/images/avatars/woman_avatar1.jpg",
          ),
          isOnline: true,
        ),
        ContactListItem(
          user: UserModel(
            fullName: "Benjamin Davis",
            lastSeenDateTime: DateTime.now().toString(),
            userAvatar: "assets/images/avatars/man_avatar3.jpg",
          ),
        ),
        ContactListItem(
          user: UserModel(
            fullName: "Emma Wilson",
            lastSeenDateTime: DateTime.now().toString(),
            userAvatar: "assets/images/avatars/woman_avatar2.jpg",
          ),
          isOnline: true,
        ),
        ContactListItem(
          user: UserModel(
            fullName: "Isabella Thompson",
            lastSeenDateTime: DateTime.now().toString(),
            userAvatar: "assets/images/avatars/woman_avatar5.jpg",
          ),
          isOnline: true,
        ),
        ContactListItem(
          user: UserModel(
            fullName: "James Miller",
            lastSeenDateTime: DateTime.now().toString(),
            userAvatar: "assets/images/avatars/man_avatar4.jpg",
          ),
          isOnline: true,
        ),
        ContactListItem(
          user: UserModel(
            fullName: "Liam Harris",
            lastSeenDateTime: DateTime.now().toString(),
            userAvatar: "assets/images/avatars/man_avatar2.jpg",
          ),
        ),
        ContactListItem(
          user: UserModel(
            fullName: "Lily Thompson",
            lastSeenDateTime: DateTime.now().toString(),
            userAvatar: "assets/images/avatars/woman_avatar4.jpg",
          ),
        ),
        ContactListItem(
          user: UserModel(
            fullName: "Oliver Clark",
            lastSeenDateTime: DateTime.now().toString(),
            userAvatar: "assets/images/avatars/man_avatar1.jpg",
          ),
          isOnline: true,
        ),
      ],
    );
  }
}
