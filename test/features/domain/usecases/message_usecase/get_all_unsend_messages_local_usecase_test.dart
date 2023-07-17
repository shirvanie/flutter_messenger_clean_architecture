
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/data/models/message_model.dart';
import 'package:messenger/features/domain/usecases/message_usecases/get_all_unsend_messages_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockMessageRepository mockMessageRepository;
  late GetAllUnsendMessagesLocalUseCase getAllUnsendMessagesLocalUseCase;

  final testJson = fixtureReader("message_model.json");
  final testMessageModel = MessageModel.fromJson(json.decode(testJson));

  setUp(() {
    mockMessageRepository = MockMessageRepository();
    getAllUnsendMessagesLocalUseCase = GetAllUnsendMessagesLocalUseCase(mockMessageRepository);
  });


  test("should return all unsend Messages when call getAllUnsendMessagesLocal from the repository", () async{
    //arrange
    when(mockMessageRepository.getAllUnsendMessagesLocal())
        .thenAnswer((_) async => Right([testMessageModel]));
    //actual
    final result = await getAllUnsendMessagesLocalUseCase(NoParams());
    verify(mockMessageRepository.getAllUnsendMessagesLocal());
    expect(result.getOrElse(() => []), [testMessageModel]);
  });
}