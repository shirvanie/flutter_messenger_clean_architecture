


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_message_model.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/update_all_group_messages_remote_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupMessageRepository mockGroupMessageRepository;
  late UpdateAllGroupMessagesRemoteUseCase updateAllGroupMessagesRemoteUseCase;

  final testJson = fixtureReader("group_message_model.json");
  final testGroupMessageModel = GroupMessageModel.fromJson(json.decode(testJson));

  setUp(() {
    mockGroupMessageRepository = MockGroupMessageRepository();
    updateAllGroupMessagesRemoteUseCase = UpdateAllGroupMessagesRemoteUseCase(mockGroupMessageRepository);
  });


  test("should return true when call updateAllGroupMessagesRemote from the repository", () async{
    //arrange
    when(mockGroupMessageRepository.updateAllGroupMessagesRemote(any))
        .thenAnswer((_) async => const Right(true));
    //actual
    final result = await updateAllGroupMessagesRemoteUseCase(ParamsUpdateAllGroupMessagesRemoteUseCase(groupMessageItems: [testGroupMessageModel]));
    verify(mockGroupMessageRepository.updateAllGroupMessagesRemote([testGroupMessageModel]));
    expect(result, const Right(true));
  });
}

