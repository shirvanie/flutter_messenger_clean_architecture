


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/message_model.dart';
import 'package:messenger/features/domain/usecases/message_usecases/exist_message_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockMessageRepository mockMessageRepository;
  late ExistMessageLocalUseCase existMessageLocalUseCase;

  final testJson = fixtureReader("message_model.json");
  final testMessageModel = MessageModel.fromJson(json.decode(testJson));
  String messageId = testMessageModel.messageId.toString();

  setUp(() {
    mockMessageRepository = MockMessageRepository();
    existMessageLocalUseCase = ExistMessageLocalUseCase(mockMessageRepository);
  });


  test("should return true when call existMessageLocal from the repository", () async{
    //arrange
    when(mockMessageRepository.existMessageLocal(any))
        .thenAnswer((_) async => const Right(true));
    //actual
    final result = await existMessageLocalUseCase(ParamsExistMessageLocalUseCase(messageId: messageId));
    verify(mockMessageRepository.existMessageLocal(messageId));
    expect(result, const Right(true));
  });
}

