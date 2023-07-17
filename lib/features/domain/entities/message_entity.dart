
import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';


@Entity()
class MessageEntity extends Equatable {
  const MessageEntity({
    this.id,
    this.messageId,
    this.senderPhoneNumber,
    this.targetPhoneNumber,
    this.messageCategory,
    this.messageBody,
    this.messageDateTime,
    this.messageType,
    this.messageIsReadByTargetUser,
  });

  @Id(assignable: true)
  final int? id;
  final String? messageId;
  final String? senderPhoneNumber;
  final String? targetPhoneNumber;
  final String? messageCategory; /// MessageCategoryModel => Text, Image, Video, ...
  final String? messageBody;
  final String? messageDateTime;
  final String? messageType; /// MessageTypeModel => Received, Send, Sending, Sent, ...
  final bool? messageIsReadByTargetUser;

  @override
  List<Object?> get props => [
    id,
    messageId,
    senderPhoneNumber,
    targetPhoneNumber,
    messageCategory,
    messageBody,
    messageDateTime,
    messageType,
    messageIsReadByTargetUser,
  ];

}
