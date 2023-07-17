part of 'group_bloc.dart';

@immutable
abstract class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object?> get props => [];
}

class InitGroupState extends GroupState {
  const InitGroupState();

  @override
  List<Object?> get props => [];
}

class LoadingGroupState extends GroupState {
  const LoadingGroupState();

  @override
  List<Object?> get props => [];
}

class EmptyGroupState extends GroupState {
  const EmptyGroupState();

  @override
  List<Object?> get props => [];
}

class ErrorGroupState extends GroupState {
  final String message;
  const ErrorGroupState({required this.message});

  @override
  List<Object?> get props => [message];
}

/// ////////////////////////////////////////////////////////////////////////////////////////////////

class GetAllGroupsLocalState extends GroupState {
  final List<GroupEntity> groupItems;
  const GetAllGroupsLocalState({required this.groupItems});

  @override
  List<Object?> get props => [groupItems];
}

class GetAllGroupsRemoteState extends GroupState {
  final List<GroupEntity> groupItems;
  const GetAllGroupsRemoteState({required this.groupItems});

  @override
  List<Object?> get props => [groupItems];
}

class GetGroupLocalState extends GroupState {
  final GroupEntity groupItem;
  const GetGroupLocalState({required this.groupItem});

  @override
  List<Object?> get props => [groupItem];
}

class GetGroupRemoteState extends GroupState {
  final GroupEntity groupItem;
  const GetGroupRemoteState({required this.groupItem});

  @override
  List<Object?> get props => [groupItem];
}

class RemoveGroupLocalState extends GroupState {
  final bool hasRemoved;
  const RemoveGroupLocalState({required this.hasRemoved});

  @override
  List<Object?> get props => [hasRemoved];
}

class SaveGroupLocalState extends GroupState {
  final bool hasSaved;
  const SaveGroupLocalState({required this.hasSaved});

  @override
  List<Object?> get props => [hasSaved];
}

class SaveGroupRemoteState extends GroupState {
  final bool hasSaved;
  const SaveGroupRemoteState({required this.hasSaved});

  @override
  List<Object?> get props => [hasSaved];
}
