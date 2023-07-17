


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_message_type_model.dart';
import 'package:messenger/features/domain/usecases/group_message_type_usecases/save_group_message_type_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupMessageTypeRepository mockGroupMessageTypeRepository;
  late SaveGroupMessageTypeLocalUseCase saveGroupMessageTypeLocalUseCase;

  final testJson = fixtureReader("group_message_type_model.json");
  final testGroupMessageTypeModel = GroupMessageTypeModel.fromJson(json.decode(testJson));

  setUp(() {
    mockGroupMessageTypeRepository = MockGroupMessageTypeRepository();
    saveGroupMessageTypeLocalUseCase = SaveGroupMessageTypeLocalUseCase(mockGroupMessageTypeRepository);
  });


  test("should return true when call saveGroupMessageTypeLocal from the repository", () async{
    //arrange
    when(mockGroupMessageTypeRepository.saveGroupMessageTypeLocal(any))
        .thenAnswer((_) async => const Right(true));
    //actual
    final result = await saveGroupMessageTypeLocalUseCase(ParamsSaveGroupMessageTypeLocalUseCase(groupMessageTypeItem: testGroupMessageTypeModel));
    verify(mockGroupMessageTypeRepository.saveGroupMessageTypeLocal(testGroupMessageTypeModel));
    expect(result, const Right(true));
  });
}

