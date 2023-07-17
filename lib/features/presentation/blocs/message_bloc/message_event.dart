part of 'message_bloc.dart';

@immutable
abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object?> get props => [];
}

class ExistMessageLocalEvent extends MessageEvent {
  final String messageId;
  const ExistMessageLocalEvent(this.messageId);

  @override
  List<Object> get props => [messageId];
}

class GetAllMessagesLocalEvent extends MessageEvent {
  final String senderPhoneNumber;
  final String targetPhoneNumber;
  const GetAllMessagesLocalEvent(this.senderPhoneNumber, this.targetPhoneNumber);

  @override
  List<Object> get props => [];
}

class GetAllMessagesRemoteEvent extends MessageEvent {
  final String senderPhoneNumber;
  final String targetPhoneNumber;
  const GetAllMessagesRemoteEvent(this.senderPhoneNumber, this.targetPhoneNumber);

  @override
  List<Object> get props => [];
}

class GetAllNotReadMessagesLocalEvent extends MessageEvent {
  final String senderPhoneNumber;
  final String targetPhoneNumber;
  const GetAllNotReadMessagesLocalEvent(this.senderPhoneNumber, this.targetPhoneNumber);

  @override
  List<Object> get props => [];
}

class GetAllUnsendMessagesLocalEvent extends MessageEvent {
  const GetAllUnsendMessagesLocalEvent();

  @override
  List<Object> get props => [];
}

class GetMessageLocalEvent extends MessageEvent {
  final String messageId;
  const GetMessageLocalEvent(this.messageId);

  @override
  List<Object> get props => [messageId];
}

class GetMessageRemoteEvent extends MessageEvent {
  final String messageId;
  const GetMessageRemoteEvent(this.messageId);

  @override
  List<Object> get props => [messageId];
}

class GetMissedMessagesRemoteEvent extends MessageEvent {
  final String targetPhoneNumber;
  const GetMissedMessagesRemoteEvent(this.targetPhoneNumber);

  @override
  List<Object> get props => [];
}

class RemoveMessageLocalEvent extends MessageEvent {
  final String messageId;
  const RemoveMessageLocalEvent(this.messageId);

  @override
  List<Object> get props => [messageId];
}

class RemoveMessageRemoteEvent extends MessageEvent {
  final String messageId;
  const RemoveMessageRemoteEvent(this.messageId);

  @override
  List<Object> get props => [messageId];
}

class SaveMessageLocalEvent extends MessageEvent {
  final MessageEntity messageItem;
  const SaveMessageLocalEvent(this.messageItem);

  @override
  List<Object> get props => [messageItem];
}

class SaveMessageRemoteEvent extends MessageEvent {
  final MessageEntity messageItem;
  const SaveMessageRemoteEvent(this.messageItem);

  @override
  List<Object> get props => [messageItem];
}

class UpdateAllMessagesRemoteEvent extends MessageEvent {
  final List<MessageEntity> messageItems;
  const UpdateAllMessagesRemoteEvent(this.messageItems);

  @override
  List<Object> get props => [messageItems];
}
