

import 'package:json_annotation/json_annotation.dart';
import 'package:messenger/features/domain/entities/group_message_type_entity.dart';

part 'group_message_type_model.g.dart';

@JsonSerializable()
class GroupMessageTypeModel extends GroupMessageTypeEntity {
  const GroupMessageTypeModel({
    id,
    groupId,
    messageId,
    receiverPhoneNumber,
    messageType,
    messageIsReadByGroupUser,
  }) : super(
    id: id,
    groupId: groupId,
    messageId: messageId,
    receiverPhoneNumber: receiverPhoneNumber,
    messageType: messageType,
    messageIsReadByGroupUser: messageIsReadByGroupUser,
  );

  factory GroupMessageTypeModel.fromJson(Map<String, dynamic> json) => _$GroupMessageTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupMessageTypeModelToJson(this);
}
