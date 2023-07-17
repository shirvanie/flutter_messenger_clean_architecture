


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_message_model.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/get_group_message_remote_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupMessageRepository mockGroupMessageRepository;
  late GetGroupMessageRemoteUseCase getGroupMessageRemoteUseCase;

  final testJson = fixtureReader("group_message_model.json");
  final testGroupMessageModel = GroupMessageModel.fromJson(json.decode(testJson));
  String messageId = testGroupMessageModel.messageId.toString();

  setUp(() {
    mockGroupMessageRepository = MockGroupMessageRepository();
    getGroupMessageRemoteUseCase = GetGroupMessageRemoteUseCase(mockGroupMessageRepository);
  });


  test("should return a GroupMessage model when call getGroupMessageRemote from the repository", () async{
    //arrange
    when(mockGroupMessageRepository.getGroupMessageRemote(any))
        .thenAnswer((_) async => Right(testGroupMessageModel));
    //actual
    final result = await getGroupMessageRemoteUseCase(ParamsGetGroupMessageRemoteUseCase(messageId: messageId));
    verify(mockGroupMessageRepository.getGroupMessageRemote(messageId));
    expect(result, Right(testGroupMessageModel));
  });
}

