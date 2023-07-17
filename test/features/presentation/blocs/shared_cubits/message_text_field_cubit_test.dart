




import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:messenger/features/presentation/blocs/shared_cubit/message_text_field_cubit/message_text_field_cubit.dart';

void main() {
  late MessageTextFieldCubit messageTextFieldCubit;

  setUp(() {
    messageTextFieldCubit = MessageTextFieldCubit();
  });

  test("initial state should be ThemeState", () {
    // assert
    expect(messageTextFieldCubit.state, equals(const MessageTextFieldState(false, false)));
  });

  blocTest<MessageTextFieldCubit, MessageTextFieldState>(
    'Should emit [MessageTextFieldState] when data is gotten successfully',
    build: () => messageTextFieldCubit,
    act: (cubit) => cubit.setState(isShowEmoji: true, isImagePicker: true),
    expect: () => [
      const MessageTextFieldState(true, true),
    ],
    verify: (cubit) => messageTextFieldCubit,
  );


}