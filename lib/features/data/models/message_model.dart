



import 'package:json_annotation/json_annotation.dart';
import 'package:messenger/features/domain/entities/message_entity.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel extends MessageEntity {
  const MessageModel({
    id,
    messageId,
    senderPhoneNumber,
    targetPhoneNumber,
    messageCategory,
    messageBody,
    messageDateTime,
    messageType,
    messageIsReadByTargetUser,
  }) : super(
      id: id,
      messageId: messageId,
      senderPhoneNumber: senderPhoneNumber,
      targetPhoneNumber: targetPhoneNumber,
      messageCategory: messageCategory,
      messageBody: messageBody,
      messageDateTime: messageDateTime,
      messageType: messageType,
      messageIsReadByTargetUser: messageIsReadByTargetUser,
  );

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
