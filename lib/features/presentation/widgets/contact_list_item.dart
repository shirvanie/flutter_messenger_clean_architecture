

import 'package:flutter/material.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/utils/date_converter.dart';
import 'package:messenger/features/data/models/user_model.dart';
import 'package:messenger/features/presentation/screens/chat_screen.dart';
import 'package:messenger/features/presentation/screens/profile_screen.dart';
import 'package:messenger/main.dart';

class ContactListItem extends StatelessWidget {
  const ContactListItem({
    super.key,
    required this.user,
    this.isOnline = false,
  });

  final UserModel user;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xff202020) : const Color(0xffeeeeee),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
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
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                ChatScreen(user: user, isOnline: isOnline),));
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ProfileScreen(user: user),));
                  },
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .onBackground
                                .withAlpha(60),
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
                          child: Image.asset(
                            user.userAvatar!, width: 60, height: 60,)
                      ),
                      if(isOnline) Container(
                        width: 12,
                        height: 12,
                        margin: const EdgeInsets.only(right: 4, bottom: 2),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(5)),
                            border: Border.all(
                              width: 2,
                              color: isDark
                                  ? const Color(0xff202020)
                                  : const Color(0xffeeeeee),
                            )
                        ),
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          child: Text(user.fullName!, style: TextStyle(
                            fontSize: 16,
                            fontFamily: Constants.appFontHelveticaBold,
                            color: Theme
                                .of(context)
                                .colorScheme
                                .onBackground,),
                            overflow: TextOverflow.ellipsis,),
                        ),
                        if(user.lastSeenDateTime != null) Container(
                          margin: const EdgeInsets.only(left: 10, top: 0),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          child: Text(
                            isOnline ? "Online" : "last seen ${DateConverter
                                .getTimeString(user.lastSeenDateTime!)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: Constants.appFontHelvetica,
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .onSecondary,),
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
    );
  }

}
