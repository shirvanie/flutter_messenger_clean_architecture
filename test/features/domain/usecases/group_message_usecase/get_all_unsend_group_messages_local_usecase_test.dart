
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_message_model.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/get_all_unsend_group_messages_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupMessageRepository mockGroupMessageRepository;
  late GetAllUnsendGroupMessagesLocalUseCase getAllUnsendGroupMessagesLocalUseCase;

  final testJson = fixtureReader("group_message_model.json");
  final testGroupMessageModel = GroupMessageModel.fromJson(json.decode(testJson));
  final senderPhoneNumber = testGroupMessageModel.senderPhoneNumber.toString();
  
  setUp(() {
    mockGroupMessageRepository = MockGroupMessageRepository();
    getAllUnsendGroupMessagesLocalUseCase = GetAllUnsendGroupMessagesLocalUseCase(mockGroupMessageRepository);
  });


  test("should return all unsend GroupMessages when call getAllUnsendGroupMessagesLocal from the repository", () async{
    //arrange
    when(mockGroupMessageRepository.getAllUnsendGroupMessagesLocal(senderPhoneNumber))
        .thenAnswer((_) async => Right([testGroupMessageModel]));
    //actual
    final result = await getAllUnsendGroupMessagesLocalUseCase(ParamsGetAllUnsendGroupMessagesLocalUseCase(senderPhoneNumber: senderPhoneNumber));
    verify(mockGroupMessageRepository.getAllUnsendGroupMessagesLocal(senderPhoneNumber));
    expect(result.getOrElse(() => []), [testGroupMessageModel]);
  });
}