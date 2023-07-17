


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/message_model.dart';
import 'package:messenger/features/domain/usecases/message_usecases/save_message_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockMessageRepository mockMessageRepository;
  late SaveMessageLocalUseCase saveMessageLocalUseCase;

  final testJson = fixtureReader("message_model.json");
  final testMessageModel = MessageModel.fromJson(json.decode(testJson));
  // String messageId = testMessageModel.messageId.toString();

  setUp(() {
    mockMessageRepository = MockMessageRepository();
    saveMessageLocalUseCase = SaveMessageLocalUseCase(mockMessageRepository);
  });


  test("should return true when call saveMessageLocal from the repository", () async{
    //arrange
    when(mockMessageRepository.saveMessageLocal(any))
        .thenAnswer((_) async => const Right(true));
    //actual
    final result = await saveMessageLocalUseCase(ParamsSaveMessageLocalUseCase(messageItem: testMessageModel));
    verify(mockMessageRepository.saveMessageLocal(testMessageModel));
    expect(result, const Right(true));
  });
}

