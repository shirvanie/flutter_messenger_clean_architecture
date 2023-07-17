part of 'group_message_type_bloc.dart';

@immutable
abstract class GroupMessageTypeEvent extends Equatable {
  const GroupMessageTypeEvent();

  @override
  List<Object?> get props => [];
}

class ExistGroupMessageTypeLocalEvent extends GroupMessageTypeEvent {
  final String messageId;
  const ExistGroupMessageTypeLocalEvent(this.messageId);

  @override
  List<Object> get props => [messageId];
}

class GetAllGroupMessageTypesLocalEvent extends GroupMessageTypeEvent {
  final String groupId;
  final String messageId;
  const GetAllGroupMessageTypesLocalEvent(this.groupId, this.messageId);

  @override
  List<Object> get props => [groupId, messageId];
}

class GetAllGroupMessageTypesRemoteEvent extends GroupMessageTypeEvent {
  final String groupId;
  final String messageId;
  const GetAllGroupMessageTypesRemoteEvent(this.groupId, this.messageId);

  @override
  List<Object> get props => [groupId, messageId];
}

class GetAllNotReadGroupMessageTypesLocalEvent extends GroupMessageTypeEvent {
  final String groupId;
  const GetAllNotReadGroupMessageTypesLocalEvent(this.groupId);

  @override
  List<Object> get props => [groupId];
}

class GetAllUnsendGroupMessageTypesLocalEvent extends GroupMessageTypeEvent {
  final String receiverPhoneNumber;
  const GetAllUnsendGroupMessageTypesLocalEvent(this.receiverPhoneNumber);

  @override
  List<Object> get props => [receiverPhoneNumber];
}

class GetGroupMessageTypeLocalEvent extends GroupMessageTypeEvent {
  final String messageId;
  const GetGroupMessageTypeLocalEvent(this.messageId);

  @override
  List<Object> get props => [messageId];
}

class GetGroupMessageTypeRemoteEvent extends GroupMessageTypeEvent {
  final String messageId;
  const GetGroupMessageTypeRemoteEvent(this.messageId);

  @override
  List<Object> get props => [messageId];
}

class RemoveGroupMessageTypeLocalEvent extends GroupMessageTypeEvent {
  final String messageId;
  const RemoveGroupMessageTypeLocalEvent(this.messageId);

  @override
  List<Object> get props => [messageId];
}

class RemoveGroupMessageTypeRemoteEvent extends GroupMessageTypeEvent {
  final String messageId;
  const RemoveGroupMessageTypeRemoteEvent(this.messageId);

  @override
  List<Object> get props => [messageId];
}

class SaveGroupMessageTypeLocalEvent extends GroupMessageTypeEvent {
  final GroupMessageTypeEntity groupMessageTypeItem;
  const SaveGroupMessageTypeLocalEvent(this.groupMessageTypeItem);

  @override
  List<Object> get props => [groupMessageTypeItem];
}

class SaveGroupMessageTypeRemoteEvent extends GroupMessageTypeEvent {
  final GroupMessageTypeEntity groupMessageTypeItem;
  const SaveGroupMessageTypeRemoteEvent(this.groupMessageTypeItem);

  @override
  List<Object> get props => [groupMessageTypeItem];
}

class UpdateAllGroupMessageTypesRemoteEvent extends GroupMessageTypeEvent {
  final List<GroupMessageTypeEntity> groupMessageTypeItems;
  const UpdateAllGroupMessageTypesRemoteEvent(this.groupMessageTypeItems);

  @override
  List<Object> get props => [groupMessageTypeItems];
}
