
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/message_model.dart';
import 'package:messenger/features/domain/usecases/message_usecases/get_missed_messages_remote_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockMessageRepository mockMessageRepository;
  late GetMissedMessagesRemoteUseCase getMissedMessagesRemoteUseCase;

  final testJson = fixtureReader("message_model.json");
  final testMessageModel = MessageModel.fromJson(json.decode(testJson));
  final targetPhoneNumber = testMessageModel.targetPhoneNumber.toString();

  setUp(() {
    mockMessageRepository = MockMessageRepository();
    getMissedMessagesRemoteUseCase = GetMissedMessagesRemoteUseCase(mockMessageRepository);
  });


  test("should return missed Messages when call getMissedMessagesRemote from the repository", () async{
    //arrange
    when(mockMessageRepository.getMissedMessagesRemote(targetPhoneNumber))
        .thenAnswer((_) async => Right([testMessageModel]));
    //actual
    final result = await getMissedMessagesRemoteUseCase(ParamsGetMissedMessagesRemoteUseCase(targetPhoneNumber: targetPhoneNumber));
    verify(mockMessageRepository.getMissedMessagesRemote(targetPhoneNumber));
    expect(result.getOrElse(() => []), [testMessageModel]);
  });
}