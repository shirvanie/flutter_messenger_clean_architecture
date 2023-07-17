part of 'message_list_cubit.dart';

class MessageListState extends Equatable {
  const MessageListState(this.messages);

  final List<MessageModel> messages;


  @override
  List<Object?> get props => [messages];
}
