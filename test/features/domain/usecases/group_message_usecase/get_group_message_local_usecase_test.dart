


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_message_model.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/get_group_message_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupMessageRepository mockGroupMessageRepository;
  late GetGroupMessageLocalUseCase getGroupMessageLocalUseCase;

  final testJson = fixtureReader("group_message_model.json");
  final testGroupMessageModel = GroupMessageModel.fromJson(json.decode(testJson));
  String messageId = testGroupMessageModel.messageId.toString();

  setUp(() {
    mockGroupMessageRepository = MockGroupMessageRepository();
    getGroupMessageLocalUseCase = GetGroupMessageLocalUseCase(mockGroupMessageRepository);
  });


  test("should return a GroupMessage model when call getGroupMessageLocal from the repository", () async{
    //arrange
    when(mockGroupMessageRepository.getGroupMessageLocal(any))
        .thenAnswer((_) async => Right(testGroupMessageModel));
    //actual
    final result = await getGroupMessageLocalUseCase(ParamsGetGroupMessageLocalUseCase(messageId: messageId));
    verify(mockGroupMessageRepository.getGroupMessageLocal(messageId));
    expect(result, Right(testGroupMessageModel));
  });
}

