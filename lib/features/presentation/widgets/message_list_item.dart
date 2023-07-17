

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:messenger/core/colors/app_color.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/utils/date_converter.dart';
import 'package:messenger/features/domain/entities/message_entity.dart';
import 'package:messenger/main.dart';

class MessageListItem extends StatefulWidget {
  const MessageListItem({super.key, required this.messageItem});

  final MessageEntity messageItem;

  @override
  State<MessageListItem> createState() => _MessageListItemState();
}

class _MessageListItemState extends State<MessageListItem> {
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
        child: Row(
          mainAxisAlignment: widget.messageItem.messageType ==
              MessageTypeModel.received
              ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(
                minWidth: 50,
                maxWidth: MediaQuery
                    .of(context)
                    .size
                    .width / 1.2,
              ),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: widget.messageItem.messageType ==
                    MessageTypeModel.received
                    ? isDark ? AppColor.leftMessageColorDark : AppColor
                    .leftMessageColorLight
                    : isDark ? AppColor.rightMessageColorDark : AppColor
                    .rightMessageColorLight,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(40),
                    spreadRadius: 0.1,
                    blurRadius: 1.0,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: _getMessageBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getMessageBody() {
    if(widget.messageItem.messageCategory == MessageCategoryModel.text) {
      return Wrap(
        alignment: WrapAlignment.end,
        crossAxisAlignment: WrapCrossAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
            child: Text(
              widget.messageItem.messageBody!,
              textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
              style: TextStyle(
                fontSize: 15,
                color: widget.messageItem.messageType ==
                    MessageTypeModel.received
                    ? isDark
                    ? AppColor.leftMessageTextColorDark
                    : AppColor.leftMessageTextColorLight
                    : isDark
                    ? AppColor.rightMessageTextColorDark
                    : AppColor.rightMessageTextColorLight,

              ),
            ),
          ),
          getMessageInfo(),

        ],
      );
    } else if(widget.messageItem.messageCategory == MessageCategoryModel.image) {
      Image image;
      if(File(widget.messageItem.messageBody!).existsSync()){
        image = Image.file(File(widget.messageItem.messageBody!));
      } else {
        image = Image.asset(widget.messageItem.messageBody!);
      }
      double maxWidth = MediaQuery.of(context).size.width / 1.4;
      double maxHeight = MediaQuery.of(context).size.height / 2;

      return Padding(
        padding: const EdgeInsets.all(3),
        child: Container(
            clipBehavior: Clip.antiAlias,
            constraints: BoxConstraints(
              maxWidth: maxWidth,
              maxHeight: maxHeight,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Stack(
              children: [
                image,
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(5)),
                    ),
                    child: Text(DateConverter
                        .getTimeString(widget.messageItem.messageDateTime!),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),),
                  ),
                )
              ],
            )
        ),
      );
    }
    if(widget.messageItem.messageCategory == MessageCategoryModel.video) {

    }
    return Container();
  }

  Widget getMessageInfo() {
    Color textColor = widget.messageItem.messageType ==
        MessageTypeModel.received
        ? isDark ? AppColor.leftMessageTextColorDark.withAlpha(180)
        : AppColor.leftMessageTextColorLight.withAlpha(180)
        : isDark ? AppColor.rightMessageTextColorDark.withAlpha(180)
        : AppColor.rightMessageTextColorLight.withAlpha(180);
    //
    Widget messageTypeIcon = Container();
    switch(widget.messageItem.messageType!){
      case MessageTypeModel.sending:
        messageTypeIcon = Container(
            padding: const EdgeInsets.fromLTRB(3, 0, 1, 0),
            child: const Icon(Icons.access_time_rounded, size: 16,)
        );
        break;
      case MessageTypeModel.send:
        messageTypeIcon = Container(
            padding: const EdgeInsets.fromLTRB(3, 0, 1, 0),
            child: const Icon(Icons.done_rounded, size: 17)
        );
        break;
      case MessageTypeModel.sent:
        messageTypeIcon = Container(
          padding: const EdgeInsets.fromLTRB(3, 0, 1, 0),
          child: Icon(Icons.done_all_rounded, size: 17,
          color: isDark ? Colors.white : Colors.purple,)
        );
        break;
    }
    //
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 5, 1),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(DateConverter
            .getTimeString(widget.messageItem.messageDateTime!),
          style: TextStyle(
            fontSize: 12,
            color: textColor,
          ),),
          messageTypeIcon,
        ],
      ),
    );
  }


}
