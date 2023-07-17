
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/message_model.dart';
import 'package:messenger/features/domain/usecases/message_usecases/get_all_notread_messages_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockMessageRepository mockMessageRepository;
  late GetAllNotReadMessagesLocalUseCase getAllNotReadMessagesLocalUseCase;

  final testJson = fixtureReader("message_model.json");
  final testMessageModel = MessageModel.fromJson(json.decode(testJson));
  String senderPhoneNumber = testMessageModel.senderPhoneNumber.toString();
  String targetPhoneNumber = testMessageModel.targetPhoneNumber.toString();

  setUp(() {
    mockMessageRepository = MockMessageRepository();
    getAllNotReadMessagesLocalUseCase = GetAllNotReadMessagesLocalUseCase(mockMessageRepository);
  });


  test("should return all not-read Messages when call getAllNotReadMessagesLocal from the repository", () async{
    //arrange
    when(mockMessageRepository.getAllNotReadMessagesLocal(senderPhoneNumber, targetPhoneNumber))
        .thenAnswer((_) async => Right([testMessageModel]));
    //actual
    final result = await getAllNotReadMessagesLocalUseCase(ParamsGetAllNotReadMessagesLocalUseCase(senderPhoneNumber: senderPhoneNumber, targetPhoneNumber: targetPhoneNumber));
    verify(mockMessageRepository.getAllNotReadMessagesLocal(senderPhoneNumber, targetPhoneNumber));
    expect(result.getOrElse(() => []), [testMessageModel]);
  });
}