


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_message_model.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/save_group_message_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupMessageRepository mockGroupMessageRepository;
  late SaveGroupMessageLocalUseCase saveGroupMessageLocalUseCase;

  final testJson = fixtureReader("group_message_model.json");
  final testGroupMessageModel = GroupMessageModel.fromJson(json.decode(testJson));

  setUp(() {
    mockGroupMessageRepository = MockGroupMessageRepository();
    saveGroupMessageLocalUseCase = SaveGroupMessageLocalUseCase(mockGroupMessageRepository);
  });


  test("should return true when call saveGroupMessageLocal from the repository", () async{
    //arrange
    when(mockGroupMessageRepository.saveGroupMessageLocal(any))
        .thenAnswer((_) async => const Right(true));
    //actual
    final result = await saveGroupMessageLocalUseCase(ParamsSaveGroupMessageLocalUseCase(groupMessageItem: testGroupMessageModel));
    verify(mockGroupMessageRepository.saveGroupMessageLocal(testGroupMessageModel));
    expect(result, const Right(true));
  });
}

