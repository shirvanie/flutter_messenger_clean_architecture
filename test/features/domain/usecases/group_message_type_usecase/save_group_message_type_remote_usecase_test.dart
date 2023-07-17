


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_message_type_model.dart';
import 'package:messenger/features/domain/usecases/group_message_type_usecases/save_group_message_type_remote_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupMessageTypeRepository mockGroupMessageTypeRepository;
  late SaveGroupMessageTypeRemoteUseCase saveGroupMessageTypeRemoteUseCase;

  final testJson = fixtureReader("group_message_type_model.json");
  final testGroupMessageTypeModel = GroupMessageTypeModel.fromJson(json.decode(testJson));

  setUp(() {
    mockGroupMessageTypeRepository = MockGroupMessageTypeRepository();
    saveGroupMessageTypeRemoteUseCase = SaveGroupMessageTypeRemoteUseCase(mockGroupMessageTypeRepository);
  });


  test("should return true when call saveGroupMessageTypeRemote from the repository", () async{
    //arrange
    when(mockGroupMessageTypeRepository.saveGroupMessageTypeRemote(any))
        .thenAnswer((_) async => const Right(true));
    //actual
    final result = await saveGroupMessageTypeRemoteUseCase(ParamsSaveGroupMessageTypeRemoteUseCase(groupMessageTypeItem: testGroupMessageTypeModel));
    verify(mockGroupMessageTypeRepository.saveGroupMessageTypeRemote(testGroupMessageTypeModel));
    expect(result, const Right(true));
  });
}

