part of 'group_message_bloc.dart';

@immutable
abstract class GroupMessageState extends Equatable {
  const GroupMessageState();

  @override
  List<Object?> get props => [];
}

class InitGroupMessageState extends GroupMessageState {
  const InitGroupMessageState();

  @override
  List<Object?> get props => [];
}

class LoadingGroupMessageState extends GroupMessageState {
  const LoadingGroupMessageState();

  @override
  List<Object?> get props => [];
}

class EmptyGroupMessageState extends GroupMessageState {
  const EmptyGroupMessageState();

  @override
  List<Object?> get props => [];
}

class ErrorGroupMessageState extends GroupMessageState {
  final String message;
  const ErrorGroupMessageState({required this.message});

  @override
  List<Object?> get props => [message];
}

/// ////////////////////////////////////////////////////////////////////////////////////////////////

class ExistGroupMessageLocalState extends GroupMessageState {
  final bool hasExistGroupMessage;
  const ExistGroupMessageLocalState({required this.hasExistGroupMessage});

  @override
  List<Object?> get props => [hasExistGroupMessage];
}

class GetAllGroupMessagesLocalState extends GroupMessageState {
  final List<GroupMessageEntity> groupMessageItems;
  const GetAllGroupMessagesLocalState({required this.groupMessageItems});

  @override
  List<Object?> get props => [groupMessageItems];
}

class GetAllGroupMessagesRemoteState extends GroupMessageState {
  final List<GroupMessageEntity> groupMessageItems;
  const GetAllGroupMessagesRemoteState({required this.groupMessageItems});

  @override
  List<Object?> get props => [groupMessageItems];
}

class GetAllUnsendGroupMessagesLocalState extends GroupMessageState {
  final List<GroupMessageEntity> groupMessageItems;
  const GetAllUnsendGroupMessagesLocalState({required this.groupMessageItems});

  @override
  List<Object?> get props => [groupMessageItems];
}

class GetGroupMessageLocalState extends GroupMessageState {
  final GroupMessageEntity groupMessageItem;
  const GetGroupMessageLocalState({required this.groupMessageItem});

  @override
  List<Object?> get props => [groupMessageItem];
}

class GetGroupMessageRemoteState extends GroupMessageState {
  final GroupMessageEntity groupMessageItem;
  const GetGroupMessageRemoteState({required this.groupMessageItem});

  @override
  List<Object?> get props => [groupMessageItem];
}

class GetMissedGroupMessagesRemoteState extends GroupMessageState {
  final List<GroupMessageEntity> groupMessageItems;
  const GetMissedGroupMessagesRemoteState({required this.groupMessageItems});

  @override
  List<Object?> get props => [groupMessageItems];
}

class RemoveGroupMessageLocalState extends GroupMessageState {
  final bool hasRemoved;
  const RemoveGroupMessageLocalState({required this.hasRemoved});

  @override
  List<Object?> get props => [hasRemoved];
}

class RemoveGroupMessageRemoteState extends GroupMessageState {
  final bool hasRemoved;
  const RemoveGroupMessageRemoteState({required this.hasRemoved});

  @override
  List<Object?> get props => [hasRemoved];
}

class SaveGroupMessageLocalState extends GroupMessageState {
  final bool hasSaved;
  const SaveGroupMessageLocalState({required this.hasSaved});

  @override
  List<Object?> get props => [hasSaved];
}

class SaveGroupMessageRemoteState extends GroupMessageState {
  final bool hasSaved;
  const SaveGroupMessageRemoteState({required this.hasSaved});

  @override
  List<Object?> get props => [hasSaved];
}

class UpdateAllGroupMessagesRemoteState extends GroupMessageState {
  final bool hasUpdate;

  const UpdateAllGroupMessagesRemoteState({required this.hasUpdate});

  @override
  List<Object?> get props => [hasUpdate];
}
