part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class InitUserState extends UserState {
  const InitUserState();

  @override
  List<Object?> get props => [];
}

class LoadingUserState extends UserState {
  const LoadingUserState();

  @override
  List<Object?> get props => [];
}

class EmptyUserState extends UserState {
  const EmptyUserState();

  @override
  List<Object?> get props => [];
}

class ErrorUserState extends UserState {
  final String? message;
  const ErrorUserState({this.message});

  @override
  List<Object?> get props => [message];
}

/// ////////////////////////////////////////////////////////////////////////////////////////////////

class ExistUserLocalState extends UserState {
  final bool hasExistUser;
  const ExistUserLocalState({required this.hasExistUser});

  @override
  List<Object?> get props => [hasExistUser];
}

class GetAllUserLocalState extends UserState {
  final List<UserEntity> userItems;
  const GetAllUserLocalState({required this.userItems});

  @override
  List<Object?> get props => [userItems];
}

class GetAllUserRemoteState extends UserState {
  final List<UserEntity> userItems;
  const GetAllUserRemoteState({required this.userItems});

  @override
  List<Object?> get props => [userItems];
}

class GetUserLocalState extends UserState {
  final UserEntity userItem;
  const GetUserLocalState({required this.userItem});

  @override
  List<Object?> get props => [userItem];
}

class GetUserRemoteState extends UserState {
  final UserEntity userItem;
  const GetUserRemoteState({required this.userItem});

  @override
  List<Object?> get props => [userItem];
}

class RemoveUserLocalState extends UserState {
  final bool hasRemoved;
  const RemoveUserLocalState({required this.hasRemoved});

  @override
  List<Object?> get props => [hasRemoved];
}

class SaveUserLocalState extends UserState {
  final bool hasSaved;
  const SaveUserLocalState({required this.hasSaved});

  @override
  List<Object?> get props => [hasSaved];
}

class SaveUserRemoteState extends UserState {
  final bool hasSaved;
  const SaveUserRemoteState({required this.hasSaved});

  @override
  List<Object?> get props => [hasSaved];
}

class SendSMSVerifyCodeRemoteState extends UserState {
  final bool hasSent;
  const SendSMSVerifyCodeRemoteState({required this.hasSent});

  @override
  List<Object?> get props => [hasSent];
}

class SetUserLastSeenDateTimeRemoteState extends UserState {
  final bool hasSet;
  const SetUserLastSeenDateTimeRemoteState({required this.hasSet});

  @override
  List<Object?> get props => [hasSet];
}
