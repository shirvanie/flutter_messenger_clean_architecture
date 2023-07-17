part of 'message_text_field_cubit.dart';


class MessageTextFieldState extends Equatable{
  const MessageTextFieldState(this.isShowEmoji, this.isImagePicker);

  final bool isShowEmoji;
  final bool isImagePicker;


  @override
  List<Object?> get props => [isShowEmoji, isImagePicker];

}

// class InitialMessageTextFieldState extends MessageTextFieldState{
//   const InitialMessageTextFieldState();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class ShowEmojiState extends MessageTextFieldState{
//   final bool isShowEmoji;
//
//   const ShowEmojiState(this.isShowEmoji);
//
//   @override
//   List<Object?> get props => [isShowEmoji];
// }
//
// class ShowImagePickerState extends MessageTextFieldState{
//
//   const ShowImagePickerState(this.isImagePicker);
//
//   @override
//   List<Object?> get props => [isImagePicker];
// }
//
