part of 'group_message_bloc.dart';


@immutable
abstract class GroupMessageEvent extends Equatable {
  const GroupMessageEvent();

  @override
  List<Object?> get props => [];
}

class ExistGroupMessageLocalEvent extends GroupMessageEvent {
  final String messageId;
  const ExistGroupMessageLocalEvent(this.messageId);

  @override
  List<Object> get props => [messageId];
}

class GetAllGroupMessagesLocalEvent extends GroupMessageEvent {
  final String groupId;
  const GetAllGroupMessagesLocalEvent(this.groupId);

  @override
  List<Object> get props => [];
}

class GetAllGroupMessagesRemoteEvent extends GroupMessageEvent {
  final String groupId;
  const GetAllGroupMessagesRemoteEvent(this.groupId);

  @override
  List<Object> get props => [];
}

class GetAllUnsendGroupMessagesLocalEvent extends GroupMessageEvent {
  final String senderPhoneNumber;
  const GetAllUnsendGroupMessagesLocalEvent(this.senderPhoneNumber);

  @override
  List<Object> get props => [];
}

class GetGroupMessageLocalEvent extends GroupMessageEvent {
  final String messageId;
  const GetGroupMessageLocalEvent(this.messageId);

  @override
  List<Object> get props => [messageId];
}

class GetGroupMessageRemoteEvent extends GroupMessageEvent {
  final String messageId;
  const GetGroupMessageRemoteEvent(this.messageId);

  @override
  List<Object> get props => [messageId];
}

class GetMissedGroupMessagesRemoteEvent extends GroupMessageEvent {
  final String groupId;
  final String receiverPhoneNumber;
  const GetMissedGroupMessagesRemoteEvent(this.groupId, this.receiverPhoneNumber);

  @override
  List<Object> get props => [];
}

class RemoveGroupMessageLocalEvent extends GroupMessageEvent {
  final String messageId;
  const RemoveGroupMessageLocalEvent(this.messageId);

  @override
  List<Object> get props => [messageId];
}

class RemoveGroupMessageRemoteEvent extends GroupMessageEvent {
  final String messageId;
  const RemoveGroupMessageRemoteEvent(this.messageId);

  @override
  List<Object> get props => [messageId];
}

class SaveGroupMessageLocalEvent extends GroupMessageEvent {
  final GroupMessageEntity groupMessageItem;
  const SaveGroupMessageLocalEvent(this.groupMessageItem);

  @override
  List<Object> get props => [groupMessageItem];
}

class SaveGroupMessageRemoteEvent extends GroupMessageEvent {
  final GroupMessageEntity groupMessageItem;
  const SaveGroupMessageRemoteEvent(this.groupMessageItem);

  @override
  List<Object> get props => [groupMessageItem];
}

class UpdateAllGroupMessagesRemoteEvent extends GroupMessageEvent {
  final List<GroupMessageEntity> groupMessageItems;
  const UpdateAllGroupMessagesRemoteEvent(this.groupMessageItems);

  @override
  List<Object> get props => [groupMessageItems];
}
