


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_message_model.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/exist_group_message_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupMessageRepository mockGroupMessageRepository;
  late ExistGroupMessageLocalUseCase existGroupMessageLocalUseCase;

  final testJson = fixtureReader("group_message_model.json");
  final testGroupMessageModel = GroupMessageModel.fromJson(json.decode(testJson));
  String messageId = testGroupMessageModel.messageId.toString();

  setUp(() {
    mockGroupMessageRepository = MockGroupMessageRepository();
    existGroupMessageLocalUseCase = ExistGroupMessageLocalUseCase(mockGroupMessageRepository);
  });


  test("should return true when call existGroupMessageLocal from the repository", () async{
    //arrange
    when(mockGroupMessageRepository.existGroupMessageLocal(any))
        .thenAnswer((_) async => const Right(true));
    //actual
    final result = await existGroupMessageLocalUseCase(ParamsExistGroupMessageLocalUseCase(messageId: messageId));
    verify(mockGroupMessageRepository.existGroupMessageLocal(messageId));
    expect(result, const Right(true));
  });
}

