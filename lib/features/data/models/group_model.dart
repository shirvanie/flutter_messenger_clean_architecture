


import 'package:json_annotation/json_annotation.dart';
import 'package:messenger/features/domain/entities/group_entity.dart';

part 'group_model.g.dart';

@JsonSerializable()
class GroupModel extends GroupEntity {
  const GroupModel({
    id,
    groupId,
    groupCreatorUserPhoneNumber,
    groupName,
    groupAvatar,
    createDateTime,
    lastMessageSenderFullName,
    lastMessageBody,
    lastMessageDateTime,
    lastMessageCategory,
    lastMessageType,
    lastMessageIsReadByGroupUser,
    isConfirm,
    notReadMessageCount,
  }) : super(
    id: id,
    groupId: groupId,
    groupCreatorUserPhoneNumber: groupCreatorUserPhoneNumber,
    groupName: groupName,
    groupAvatar: groupAvatar,
    createDateTime: createDateTime,
    lastMessageSenderFullName: lastMessageSenderFullName,
    lastMessageBody: lastMessageBody,
    lastMessageDateTime: lastMessageDateTime,
    lastMessageCategory: lastMessageCategory,
    lastMessageType: lastMessageType,
    lastMessageIsReadByGroupUser: lastMessageIsReadByGroupUser,
    isConfirm: isConfirm,
    notReadMessageCount: notReadMessageCount,
  );

  factory GroupModel.fromJson(Map<String, dynamic> json) => _$GroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupModelToJson(this);
}
