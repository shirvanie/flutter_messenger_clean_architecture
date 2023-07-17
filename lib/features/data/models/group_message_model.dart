

import 'package:json_annotation/json_annotation.dart';
import 'package:messenger/features/domain/entities/group_message_entity.dart';

part 'group_message_model.g.dart';

@JsonSerializable()
class GroupMessageModel extends GroupMessageEntity {
  const GroupMessageModel({
    id,
    messageId,
    groupId,
    senderPhoneNumber,
    messageCategory,
    messageBody,
    messageDateTime,
  }) : super(
    id: id,
    messageId: messageId,
    groupId: groupId,
    senderPhoneNumber: senderPhoneNumber,
    messageCategory: messageCategory,
    messageBody: messageBody,
    messageDateTime: messageDateTime,
  );

  factory GroupMessageModel.fromJson(Map<String, dynamic> json) => _$GroupMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupMessageModelToJson(this);
}
