part of 'group_bloc.dart';

@immutable
abstract class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object?> get props => [];
}

class GetAllGroupsLocalEvent extends GroupEvent {
  const GetAllGroupsLocalEvent();

  @override
  List<Object> get props => [];
}

class GetAllGroupsRemoteEvent extends GroupEvent {
  const GetAllGroupsRemoteEvent();

  @override
  List<Object> get props => [];
}

class GetGroupLocalEvent extends GroupEvent {
  final String groupId;
  const GetGroupLocalEvent(this.groupId);

  @override
  List<Object> get props => [groupId];
}

class GetGroupRemoteEvent extends GroupEvent {
  final String groupId;
  const GetGroupRemoteEvent(this.groupId);

  @override
  List<Object> get props => [groupId];
}

class RemoveGroupLocalEvent extends GroupEvent {
  final String groupId;
  const RemoveGroupLocalEvent(this.groupId);

  @override
  List<Object> get props => [groupId];
}

class SaveGroupLocalEvent extends GroupEvent {
  final GroupEntity groupItem;
  const SaveGroupLocalEvent(this.groupItem);

  @override
  List<Object> get props => [groupItem];
}

class SaveGroupRemoteEvent extends GroupEvent {
  final GroupEntity groupItem;
  const SaveGroupRemoteEvent(this.groupItem);

  @override
  List<Object> get props => [groupItem];
}
