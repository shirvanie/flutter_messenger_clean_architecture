


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_message_model.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/save_group_message_remote_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupMessageRepository mockGroupMessageRepository;
  late SaveGroupMessageRemoteUseCase saveGroupMessageRemoteUseCase;

  final testJson = fixtureReader("group_message_model.json");
  final testGroupMessageModel = GroupMessageModel.fromJson(json.decode(testJson));

  setUp(() {
    mockGroupMessageRepository = MockGroupMessageRepository();
    saveGroupMessageRemoteUseCase = SaveGroupMessageRemoteUseCase(mockGroupMessageRepository);
  });


  test("should return true when call saveGroupMessageRemote from the repository", () async{
    //arrange
    when(mockGroupMessageRepository.saveGroupMessageRemote(any))
        .thenAnswer((_) async => const Right(true));
    //actual
    final result = await saveGroupMessageRemoteUseCase(ParamsSaveGroupMessageRemoteUseCase(groupMessageItem: testGroupMessageModel));
    verify(mockGroupMessageRepository.saveGroupMessageRemote(testGroupMessageModel));
    expect(result, const Right(true));
  });
}

