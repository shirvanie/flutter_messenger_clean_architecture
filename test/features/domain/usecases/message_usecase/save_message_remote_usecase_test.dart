


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/message_model.dart';
import 'package:messenger/features/domain/usecases/message_usecases/save_message_remote_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockMessageRepository mockMessageRepository;
  late SaveMessageRemoteUseCase saveMessageRemoteUseCase;

  final testJson = fixtureReader("message_model.json");
  final testMessageModel = MessageModel.fromJson(json.decode(testJson));
  // String messageId = testMessageModel.messageId.toString();

  setUp(() {
    mockMessageRepository = MockMessageRepository();
    saveMessageRemoteUseCase = SaveMessageRemoteUseCase(mockMessageRepository);
  });


  test("should return true when call saveMessageRemote from the repository", () async{
    //arrange
    when(mockMessageRepository.saveMessageRemote(any))
        .thenAnswer((_) async => const Right(true));
    //actual
    final result = await saveMessageRemoteUseCase(ParamsSaveMessageRemoteUseCase(messageItem: testMessageModel));
    verify(mockMessageRepository.saveMessageRemote(testMessageModel));
    expect(result, const Right(true));
  });
}

