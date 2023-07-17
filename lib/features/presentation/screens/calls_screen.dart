

import 'package:flutter/material.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/utils/date_converter.dart';
import 'package:messenger/features/data/models/user_model.dart';
import 'package:messenger/features/presentation/widgets/call_list_item.dart';

class CallsScreen extends StatelessWidget {
  const CallsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(20, 0, 10, 5),
          child: Text("Calls", style: TextStyle(
            fontSize: 20,
            fontFamily: Constants.appFontHelveticaBold,
            color: Theme.of(context).colorScheme.onBackground,),
            overflow: TextOverflow.ellipsis,),
        ),
        CallListItem(
          user: UserModel(
            fullName: "Oliver Clark",
            userAvatar: "assets/images/avatars/man_avatar1.jpg",
            lastSeenDateTime: DateTime.now().toString(),
          ),
          callDateTime: DateConverter.getDateTimeWithMonth(DateTime.now()),
          isOnline: true,
          isCallReceived: true,
        ),
        CallListItem(
          user: UserModel(
            fullName: "Ava Williams",
            userAvatar: "assets/images/avatars/woman_avatar1.jpg",
            lastSeenDateTime: DateTime.now().toString(),
          ),
          callDateTime: DateConverter.getDateTimeWithMonth(DateTime.now()),
          isOnline: true,
        ),
        CallListItem(
          user: UserModel(
            fullName: "Liam Harris",
            userAvatar: "assets/images/avatars/man_avatar2.jpg",
            lastSeenDateTime: DateTime.now().toString(),
          ),
          callDateTime: DateConverter.getDateTimeWithMonth(DateTime.now()),
          isCallRejected: true,
        ),
        CallListItem(
          user: UserModel(
            fullName: "Emma Wilson",
            userAvatar: "assets/images/avatars/woman_avatar2.jpg",
            lastSeenDateTime: DateTime.now().toString(),
          ),
          callDateTime: DateConverter.getDateTimeWithMonth(DateTime.now()),
          isOnline: true,
          isCallReceived: true,
        ),
        CallListItem(
          user: UserModel(
            fullName: "Benjamin Davis",
            userAvatar: "assets/images/avatars/man_avatar3.jpg",
            lastSeenDateTime: DateTime.now().toString(),
          ),
          callDateTime: DateConverter.getDateTimeWithMonth(DateTime.now()),
          isCallRejected: true,
        ),
        CallListItem(
          user: UserModel(
            fullName: "Ava White",
            userAvatar: "assets/images/avatars/woman_avatar3.jpg",
            lastSeenDateTime: DateTime.now().toString(),
          ),
          callDateTime: DateConverter.getDateTimeWithMonth(DateTime.now()),
        ),
        CallListItem(
          user: UserModel(
            fullName: "James Miller",
            userAvatar: "assets/images/avatars/man_avatar4.jpg",
            lastSeenDateTime: DateTime.now().toString(),
          ),
          callDateTime: DateConverter.getDateTimeWithMonth(DateTime.now()),
          isOnline: true,
          isCallReceived: true,
        ),
        CallListItem(
          user: UserModel(
            fullName: "Lily Thompson",
            userAvatar: "assets/images/avatars/woman_avatar4.jpg",
            lastSeenDateTime: DateTime.now().toString(),
          ),
          callDateTime: DateConverter.getDateTimeWithMonth(DateTime.now()),
        ),
        CallListItem(
          user: UserModel(
            fullName: "Alexander Wilson",
            userAvatar: "assets/images/avatars/man_avatar5.jpg",
            lastSeenDateTime: DateTime.now().toString(),
          ),
          callDateTime: DateConverter.getDateTimeWithMonth(DateTime.now()),
          isOnline: true,
          isCallRejected: true,
        ),
        CallListItem(
          user: UserModel(
            fullName: "Isabella Thompson",
            userAvatar: "assets/images/avatars/woman_avatar5.jpg",
            lastSeenDateTime: DateTime.now().toString(),
          ),
          callDateTime: DateConverter.getDateTimeWithMonth(DateTime.now()),
          isOnline: true,
          isCallReceived: true,
        ),
      ],
    );
  }
}
