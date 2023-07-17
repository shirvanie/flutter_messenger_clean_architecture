part of 'group_user_bloc.dart';


@immutable
abstract class GroupUserState extends Equatable {
  const GroupUserState();

  @override
  List<Object?> get props => [];
}

class InitGroupUserState extends GroupUserState {
  const InitGroupUserState();

  @override
  List<Object?> get props => [];
}

class LoadingGroupUserState extends GroupUserState {
  const LoadingGroupUserState();

  @override
  List<Object?> get props => [];
}

class EmptyGroupUserState extends GroupUserState {
  const EmptyGroupUserState();

  @override
  List<Object?> get props => [];
}

class ErrorGroupUserState extends GroupUserState {
  final String message;
  const ErrorGroupUserState({required this.message});

  @override
  List<Object?> get props => [message];
}

/// ////////////////////////////////////////////////////////////////////////////////////////////////

class GetAllGroupUsersLocalState extends GroupUserState {
  final List<GroupUserEntity> groupUserItems;
  const GetAllGroupUsersLocalState({required this.groupUserItems});

  @override
  List<Object?> get props => [groupUserItems];
}

class GetAllGroupUsersRemoteState extends GroupUserState {
  final List<GroupUserEntity> groupUserItems;
  const GetAllGroupUsersRemoteState({required this.groupUserItems});

  @override
  List<Object?> get props => [groupUserItems];
}

class GetAllGroupUsersByPhoneNumberRemoteState extends GroupUserState {
  final List<GroupUserEntity> groupUserItems;
  const GetAllGroupUsersByPhoneNumberRemoteState({required this.groupUserItems});

  @override
  List<Object?> get props => [groupUserItems];
}

class GetGroupUserLocalState extends GroupUserState {
  final GroupUserEntity groupUserItem;
  const GetGroupUserLocalState({required this.groupUserItem});

  @override
  List<Object?> get props => [groupUserItem];
}

class RemoveGroupUserLocalState extends GroupUserState {
  final bool hasRemoved;
  const RemoveGroupUserLocalState({required this.hasRemoved});

  @override
  List<Object?> get props => [hasRemoved];
}

class RemoveGroupUserRemoteState extends GroupUserState {
  final bool hasRemoved;
  const RemoveGroupUserRemoteState({required this.hasRemoved});

  @override
  List<Object?> get props => [hasRemoved];
}

class SaveGroupUserLocalState extends GroupUserState {
  final bool hasSaved;
  const SaveGroupUserLocalState({required this.hasSaved});

  @override
  List<Object?> get props => [hasSaved];
}

class SaveGroupUserRemoteState extends GroupUserState {
  final bool hasSaved;
  const SaveGroupUserRemoteState({required this.hasSaved});

  @override
  List<Object?> get props => [hasSaved];
}
