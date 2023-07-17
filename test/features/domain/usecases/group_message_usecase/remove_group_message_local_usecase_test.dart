


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_message_model.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/remove_group_message_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupMessageRepository mockGroupMessageRepository;
  late RemoveGroupMessageLocalUseCase removeGroupMessageLocalUseCase;

  final testJson = fixtureReader("group_message_model.json");
  final testGroupMessageModel = GroupMessageModel.fromJson(json.decode(testJson));
  String messageId = testGroupMessageModel.messageId.toString();

  setUp(() {
    mockGroupMessageRepository = MockGroupMessageRepository();
    removeGroupMessageLocalUseCase = RemoveGroupMessageLocalUseCase(mockGroupMessageRepository);
  });


  test("should return true when call removeGroupMessageLocal from the repository", () async{
    //arrange
    when(mockGroupMessageRepository.removeGroupMessageLocal(any))
        .thenAnswer((_) async => const Right(true));
    //actual
    final result = await removeGroupMessageLocalUseCase(ParamsRemoveGroupMessageLocalUseCase(messageId: messageId));
    verify(mockGroupMessageRepository.removeGroupMessageLocal(messageId));
    expect(result, const Right(true));
  });
}

