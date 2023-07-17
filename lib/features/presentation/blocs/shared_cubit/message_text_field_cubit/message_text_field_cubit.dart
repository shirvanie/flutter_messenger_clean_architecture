import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'message_text_field_state.dart';

class MessageTextFieldCubit extends Cubit<MessageTextFieldState> {

  MessageTextFieldCubit() : super(const MessageTextFieldState(false, false));

  void setState({required bool isShowEmoji, required bool isImagePicker}) async {
    emit(MessageTextFieldState(isShowEmoji, isImagePicker));
  }

}
