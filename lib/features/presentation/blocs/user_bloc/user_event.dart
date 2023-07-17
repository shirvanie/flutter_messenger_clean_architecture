part of 'user_bloc.dart';

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class ExistUserLocalEvent extends UserEvent {
  final String userPhoneNumber;
  const ExistUserLocalEvent(this.userPhoneNumber);

  @override
  List<Object> get props => [userPhoneNumber];
}

class GetAllUsersLocalEvent extends UserEvent {
  const GetAllUsersLocalEvent();

  @override
  List<Object> get props => [];
}

class GetAllUsersRemoteEvent extends UserEvent {
  const GetAllUsersRemoteEvent();

  @override
  List<Object> get props => [];
}

class GetUserLocalEvent extends UserEvent {
  final String userPhoneNumber;
  const GetUserLocalEvent(this.userPhoneNumber);

  @override
  List<Object> get props => [userPhoneNumber];
}

class GetUserRemoteEvent extends UserEvent {
  final String userPhoneNumber;
  const GetUserRemoteEvent(this.userPhoneNumber);

  @override
  List<Object> get props => [userPhoneNumber];
}

class RemoveUserLocalEvent extends UserEvent {
  final String userPhoneNumber;
  const RemoveUserLocalEvent(this.userPhoneNumber);

  @override
  List<Object> get props => [userPhoneNumber];
}

class SaveUserLocalEvent extends UserEvent {
  final UserEntity userItem;
  const SaveUserLocalEvent(this.userItem);

  @override
  List<Object> get props => [userItem];
}

class SaveUserRemoteEvent extends UserEvent {
  final UserEntity userItem;
  const SaveUserRemoteEvent(this.userItem);

  @override
  List<Object> get props => [userItem];
}

class SetUserLastSeenDateTimeRemoteEvent extends UserEvent {
  final String userPhoneNumber;
  final String lastSeenDateTime;

  const SetUserLastSeenDateTimeRemoteEvent(this.userPhoneNumber, this.lastSeenDateTime);

  @override
  List<Object> get props => [userPhoneNumber, lastSeenDateTime];
}

class SendSMSVerifyCodeRemoteEvent extends UserEvent {
  final SMSModel smsItem;
  const SendSMSVerifyCodeRemoteEvent(this.smsItem);

  @override
  List<Object> get props => [smsItem];
}
