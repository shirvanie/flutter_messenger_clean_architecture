part of 'group_user_bloc.dart';


@immutable
abstract class GroupUserEvent extends Equatable {
  const GroupUserEvent();

  @override
  List<Object?> get props => [];
}

class GetAllGroupUsersLocalEvent extends GroupUserEvent {
  final String groupId;
  const GetAllGroupUsersLocalEvent(this.groupId);

  @override
  List<Object> get props => [];
}

class GetAllGroupUsersRemoteEvent extends GroupUserEvent {
  final String groupId;
  const GetAllGroupUsersRemoteEvent(this.groupId);

  @override
  List<Object> get props => [];
}

class GetAllGroupUsersByPhoneNumberRemoteEvent extends GroupUserEvent {
  final String userPhoneNumber;
  const GetAllGroupUsersByPhoneNumberRemoteEvent(this.userPhoneNumber);

  @override
  List<Object> get props => [];
}

class GetGroupUserLocalEvent extends GroupUserEvent {
  final String groupId;
  final String userPhoneNumber;
  const GetGroupUserLocalEvent(this.groupId, this.userPhoneNumber);

  @override
  List<Object> get props => [groupId, userPhoneNumber];
}

class RemoveGroupUserLocalEvent extends GroupUserEvent {
  final String groupId;
  final String userPhoneNumber;
  const RemoveGroupUserLocalEvent(this.groupId, this.userPhoneNumber);

  @override
  List<Object> get props => [groupId, userPhoneNumber];
}

class RemoveGroupUserRemoteEvent extends GroupUserEvent {
  final String groupId;
  final String userPhoneNumber;
  const RemoveGroupUserRemoteEvent(this.groupId, this.userPhoneNumber);

  @override
  List<Object> get props => [groupId, userPhoneNumber];
}

class SaveGroupUserLocalEvent extends GroupUserEvent {
  final GroupUserEntity groupUserItem;
  const SaveGroupUserLocalEvent(this.groupUserItem);

  @override
  List<Object> get props => [groupUserItem];
}

class SaveGroupUserRemoteEvent extends GroupUserEvent {
  final GroupUserEntity groupUserItem;
  const SaveGroupUserRemoteEvent(this.groupUserItem);

  @override
  List<Object> get props => [groupUserItem];
}
