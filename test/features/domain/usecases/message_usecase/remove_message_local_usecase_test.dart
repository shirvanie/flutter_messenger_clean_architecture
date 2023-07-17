


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/message_model.dart';
import 'package:messenger/features/domain/usecases/message_usecases/remove_message_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockMessageRepository mockMessageRepository;
  late RemoveMessageLocalUseCase removeMessageLocalUseCase;

  final testJson = fixtureReader("message_model.json");
  final testMessageModel = MessageModel.fromJson(json.decode(testJson));
  String messageId = testMessageModel.messageId.toString();

  setUp(() {
    mockMessageRepository = MockMessageRepository();
    removeMessageLocalUseCase = RemoveMessageLocalUseCase(mockMessageRepository);
  });


  test("should return true when call removeMessageLocal from the repository", () async{
    //arrange
    when(mockMessageRepository.removeMessageLocal(any))
        .thenAnswer((_) async => const Right(true));
    //actual
    final result = await removeMessageLocalUseCase(ParamsRemoveMessageLocalUseCase(messageId: messageId));
    verify(mockMessageRepository.removeMessageLocal(messageId));
    expect(result, const Right(true));
  });
}

