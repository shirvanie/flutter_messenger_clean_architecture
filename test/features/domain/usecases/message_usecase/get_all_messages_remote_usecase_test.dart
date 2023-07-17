
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/message_model.dart';
import 'package:messenger/features/domain/usecases/message_usecases/get_all_messages_remote_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockMessageRepository mockMessageRepository;
  late GetAllMessagesRemoteUseCase getAllMessagesRemoteUseCase;

  final testJson = fixtureReader("message_model.json");
  final testMessageModel = MessageModel.fromJson(json.decode(testJson));
  String senderPhoneNumber = testMessageModel.senderPhoneNumber.toString();
  String targetPhoneNumber = testMessageModel.targetPhoneNumber.toString();

  setUp(() {
    mockMessageRepository = MockMessageRepository();
    getAllMessagesRemoteUseCase = GetAllMessagesRemoteUseCase(mockMessageRepository);
  });


  test("should return all Messages when call getAllMessagesRemote from the repository", () async{
    //arrange
    when(mockMessageRepository.getAllMessagesRemote(senderPhoneNumber, targetPhoneNumber))
        .thenAnswer((_) async => Right([testMessageModel]));
    //actual
    final result = await getAllMessagesRemoteUseCase(ParamsGetAllMessagesRemoteUseCase(senderPhoneNumber: senderPhoneNumber, targetPhoneNumber: targetPhoneNumber));
    verify(mockMessageRepository.getAllMessagesRemote(senderPhoneNumber, targetPhoneNumber));
    expect(result.getOrElse(() => []), [testMessageModel]);
  });
}