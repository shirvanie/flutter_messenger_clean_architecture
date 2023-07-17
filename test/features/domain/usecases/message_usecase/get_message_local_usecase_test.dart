


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/message_model.dart';
import 'package:messenger/features/domain/usecases/message_usecases/get_message_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockMessageRepository mockMessageRepository;
  late GetMessageLocalUseCase getMessageLocalUseCase;

  final testJson = fixtureReader("message_model.json");
  final testMessageModel = MessageModel.fromJson(json.decode(testJson));
  String messageId = testMessageModel.messageId.toString();

  setUp(() {
    mockMessageRepository = MockMessageRepository();
    getMessageLocalUseCase = GetMessageLocalUseCase(mockMessageRepository);
  });


  test("should return a Message model when call getMessageLocal from the repository", () async{
    //arrange
    when(mockMessageRepository.getMessageLocal(any))
        .thenAnswer((_) async => Right(testMessageModel));
    //actual
    final result = await getMessageLocalUseCase(ParamsGetMessageLocalUseCase(messageId: messageId));
    verify(mockMessageRepository.getMessageLocal(messageId));
    expect(result, Right(testMessageModel));
  });
}

