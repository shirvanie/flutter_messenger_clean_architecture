
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_message_model.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/get_all_group_messages_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupMessageRepository mockGroupMessageRepository;
  late GetAllGroupMessagesLocalUseCase getAllGroupMessagesLocalUseCase;

  final testJson = fixtureReader("group_message_model.json");
  final testGroupMessageModel = GroupMessageModel.fromJson(json.decode(testJson));
  String groupId = testGroupMessageModel.groupId.toString();

  setUp(() {
    mockGroupMessageRepository = MockGroupMessageRepository();
    getAllGroupMessagesLocalUseCase = GetAllGroupMessagesLocalUseCase(mockGroupMessageRepository);
  });


  test("should return all GroupMessages when call getAllGroupMessagesLocal from the repository", () async{
    //arrange
    when(mockGroupMessageRepository.getAllGroupMessagesLocal(groupId))
        .thenAnswer((_) async => Right([testGroupMessageModel]));
    //actual
    final result = await getAllGroupMessagesLocalUseCase(ParamsGetAllGroupMessagesLocalUseCase(groupId: groupId));
    verify(mockGroupMessageRepository.getAllGroupMessagesLocal(groupId));
    expect(result.getOrElse(() => []), [testGroupMessageModel]);
  });
}