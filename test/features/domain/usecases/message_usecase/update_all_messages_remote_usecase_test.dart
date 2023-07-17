


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/message_model.dart';
import 'package:messenger/features/domain/usecases/message_usecases/update_all_messages_remote_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockMessageRepository mockMessageRepository;
  late UpdateAllMessagesRemoteUseCase updateAllMessagesRemoteUseCase;

  final testJson = fixtureReader("message_model.json");
  final testMessageModel = MessageModel.fromJson(json.decode(testJson));

  setUp(() {
    mockMessageRepository = MockMessageRepository();
    updateAllMessagesRemoteUseCase = UpdateAllMessagesRemoteUseCase(mockMessageRepository);
  });


  test("should return true when call updateAllMessagesRemote from the repository", () async{
    //arrange
    when(mockMessageRepository.updateAllMessagesRemote(any))
        .thenAnswer((_) async => const Right(true));
    //actual
    final result = await updateAllMessagesRemoteUseCase(ParamsUpdateAllMessagesRemoteUseCase(messageItems: [testMessageModel]));
    verify(mockMessageRepository.updateAllMessagesRemote([testMessageModel]));
    expect(result, const Right(true));
  });
}

