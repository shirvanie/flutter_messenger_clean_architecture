part of 'group_message_type_bloc.dart';

@immutable
abstract class GroupMessageTypeState extends Equatable {
  const GroupMessageTypeState();

  @override
  List<Object?> get props => [];
}

class InitGroupMessageTypeState extends GroupMessageTypeState {
  const InitGroupMessageTypeState();

  @override
  List<Object?> get props => [];
}

class LoadingGroupMessageTypeState extends GroupMessageTypeState {
  const LoadingGroupMessageTypeState();

  @override
  List<Object?> get props => [];
}

class EmptyGroupMessageTypeState extends GroupMessageTypeState {
  const EmptyGroupMessageTypeState();

  @override
  List<Object?> get props => [];
}

class ErrorGroupMessageTypeState extends GroupMessageTypeState {
  final String message;
  const ErrorGroupMessageTypeState({required this.message});

  @override
  List<Object?> get props => [message];
}

/// ////////////////////////////////////////////////////////////////////////////////////////////////

class ExistGroupMessageTypeLocalState extends GroupMessageTypeState {
  final bool hasExistGroupMessageType;
  const ExistGroupMessageTypeLocalState({required this.hasExistGroupMessageType});

  @override
  List<Object?> get props => [hasExistGroupMessageType];
}

class GetAllGroupMessageTypesLocalState extends GroupMessageTypeState {
  final List<GroupMessageTypeEntity> groupMessageTypeItems;
  const GetAllGroupMessageTypesLocalState({required this.groupMessageTypeItems});

  @override
  List<Object?> get props => [groupMessageTypeItems];
}

class GetAllGroupMessageTypesRemoteState extends GroupMessageTypeState {
  final List<GroupMessageTypeEntity> groupMessageTypeItems;
  const GetAllGroupMessageTypesRemoteState({required this.groupMessageTypeItems});

  @override
  List<Object?> get props => [groupMessageTypeItems];
}

class GetAllNotReadGroupMessageTypesLocalState extends GroupMessageTypeState {
  final List<GroupMessageTypeEntity> groupMessageTypeItems;
  const GetAllNotReadGroupMessageTypesLocalState({required this.groupMessageTypeItems});

  @override
  List<Object?> get props => [groupMessageTypeItems];
}

class GetAllUnsendGroupMessageTypesLocalState extends GroupMessageTypeState {
  final List<GroupMessageTypeEntity> groupMessageTypeItems;
  const GetAllUnsendGroupMessageTypesLocalState({required this.groupMessageTypeItems});

  @override
  List<Object?> get props => [groupMessageTypeItems];
}

class GetGroupMessageTypeLocalState extends GroupMessageTypeState {
  final GroupMessageTypeEntity groupMessageTypeItem;
  const GetGroupMessageTypeLocalState({required this.groupMessageTypeItem});

  @override
  List<Object?> get props => [groupMessageTypeItem];
}

class GetGroupMessageTypeRemoteState extends GroupMessageTypeState {
  final GroupMessageTypeEntity groupMessageTypeItem;
  const GetGroupMessageTypeRemoteState({required this.groupMessageTypeItem});

  @override
  List<Object?> get props => [groupMessageTypeItem];
}

class RemoveGroupMessageTypeLocalState extends GroupMessageTypeState {
  final bool hasRemoved;
  const RemoveGroupMessageTypeLocalState({required this.hasRemoved});

  @override
  List<Object?> get props => [hasRemoved];
}

class RemoveGroupMessageTypeRemoteState extends GroupMessageTypeState {
  final bool hasRemoved;
  const RemoveGroupMessageTypeRemoteState({required this.hasRemoved});

  @override
  List<Object?> get props => [hasRemoved];
}

class SaveGroupMessageTypeLocalState extends GroupMessageTypeState {
  final bool hasSaved;
  const SaveGroupMessageTypeLocalState({required this.hasSaved});

  @override
  List<Object?> get props => [hasSaved];
}

class SaveGroupMessageTypeRemoteState extends GroupMessageTypeState {
  final bool hasSaved;
  const SaveGroupMessageTypeRemoteState({required this.hasSaved});

  @override
  List<Object?> get props => [hasSaved];
}

class UpdateAllGroupMessageTypesRemoteState extends GroupMessageTypeState {
  final bool hasUpdate;

  const UpdateAllGroupMessageTypesRemoteState({required this.hasUpdate});

  @override
  List<Object?> get props => [hasUpdate];
}
