import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:messenger/features/data/models/message_model.dart';

part 'message_list_state.dart';

class MessageListCubit extends Cubit<MessageListState> {

  MessageListCubit() : super(const MessageListState([]));

  Future addAllMessages(List<MessageModel> messages) async {
    final list = messages.toList();
    emit(MessageListState(list));
  }

  Future addMessage(MessageModel messageItem) async {
    List<MessageModel> list = state.messages.toList();
    list.add(messageItem);
    emit(MessageListState(list));
  }

  Future removeMessage(String messageId) async {
    try{
      MessageModel messageItem = state.messages.firstWhere((e) => e.messageId.toString() == messageId);
      state.messages.remove(messageItem);
      emit(MessageListState(state.messages));
    } catch (e) { return; }
  }
}
