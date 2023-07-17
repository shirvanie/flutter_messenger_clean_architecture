part of 'message_bloc.dart';

@immutable
abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object?> get props => [];
}

class InitMessageState extends MessageState {
  const InitMessageState();

  @override
  List<Object?> get props => [];
}

class LoadingMessageState extends MessageState {
  const LoadingMessageState();

  @override
  List<Object?> get props => [];
}

class EmptyMessageState extends MessageState {
  const EmptyMessageState();

  @override
  List<Object?> get props => [];
}

class ErrorMessageState extends MessageState {
  final String message;
  const ErrorMessageState({required this.message});

  @override
  List<Object?> get props => [message];
}

/// ////////////////////////////////////////////////////////////////////////////////////////////////

class ExistMessageLocalState extends MessageState {
  final bool hasExistMessage;
  const ExistMessageLocalState({required this.hasExistMessage});

  @override
  List<Object?> get props => [hasExistMessage];
}

class GetAllMessagesLocalState extends MessageState {
  final List<MessageEntity> messageItems;
  const GetAllMessagesLocalState({required this.messageItems});

  @override
  List<Object?> get props => [messageItems];
}

class GetAllMessagesRemoteState extends MessageState {
  final List<MessageEntity> messageItems;
  const GetAllMessagesRemoteState({required this.messageItems});

  @override
  List<Object?> get props => [messageItems];
}

class GetAllNotReadMessagesLocalState extends MessageState {
  final List<MessageEntity> messageItems;
  const GetAllNotReadMessagesLocalState({required this.messageItems});

  @override
  List<Object?> get props => [messageItems];
}

class GetAllUnsendMessagesLocalState extends MessageState {
  final List<MessageEntity> messageItems;
  const GetAllUnsendMessagesLocalState({required this.messageItems});

  @override
  List<Object?> get props => [messageItems];
}

class GetMessageLocalState extends MessageState {
  final MessageEntity messageItem;
  const GetMessageLocalState({required this.messageItem});

  @override
  List<Object?> get props => [messageItem];
}

class GetMessageRemoteState extends MessageState {
  final MessageEntity messageItem;
  const GetMessageRemoteState({required this.messageItem});

  @override
  List<Object?> get props => [messageItem];
}

class GetMissedMessagesRemoteState extends MessageState {
  final List<MessageEntity> messageItems;
  const GetMissedMessagesRemoteState({required this.messageItems});

  @override
  List<Object?> get props => [messageItems];
}

class RemoveMessageLocalState extends MessageState {
  final bool hasRemoved;
  const RemoveMessageLocalState({required this.hasRemoved});

  @override
  List<Object?> get props => [hasRemoved];
}

class RemoveMessageRemoteState extends MessageState {
  final bool hasRemoved;
  const RemoveMessageRemoteState({required this.hasRemoved});

  @override
  List<Object?> get props => [hasRemoved];
}

class SaveMessageLocalState extends MessageState {
  final bool hasSaved;
  const SaveMessageLocalState({required this.hasSaved});

  @override
  List<Object?> get props => [hasSaved];
}

class SaveMessageRemoteState extends MessageState {
  final bool hasSaved;
  const SaveMessageRemoteState({required this.hasSaved});

  @override
  List<Object?> get props => [hasSaved];
}

class UpdateAllMessagesRemoteState extends MessageState {
  final bool hasUpdate;
  const UpdateAllMessagesRemoteState({required this.hasUpdate});

  @override
  List<Object?> get props => [hasUpdate];
}
