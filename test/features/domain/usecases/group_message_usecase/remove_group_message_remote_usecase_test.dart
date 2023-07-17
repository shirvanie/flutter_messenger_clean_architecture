


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_message_model.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/remove_group_message_remote_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupMessageRepository mockGroupMessageRepository;
  late RemoveGroupMessageRemoteUseCase removeGroupMessageRemoteUseCase;

  final testJson = fixtureReader("group_message_model.json");
  final testGroupMessageModel = GroupMessageModel.fromJson(json.decode(testJson));
  String messageId = testGroupMessageModel.messageId.toString();

  setUp(() {
    mockGroupMessageRepository = MockGroupMessageRepository();
    removeGroupMessageRemoteUseCase = RemoveGroupMessageRemoteUseCase(mockGroupMessageRepository);
  });


  test("should return true when call removeGroupMessageRemote from the repository", () async{
    //arrange
    when(mockGroupMessageRepository.removeGroupMessageRemote(any))
        .thenAnswer((_) async => const Right(true));
    //actual
    final result = await removeGroupMessageRemoteUseCase(ParamsRemoveGroupMessageRemoteUseCase(messageId: messageId));
    verify(mockGroupMessageRepository.removeGroupMessageRemote(messageId));
    expect(result, const Right(true));
  });
}

