


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_model.dart';
import 'package:messenger/features/domain/usecases/group_usecases/save_group_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupRepository mockGroupRepository;
  late SaveGroupLocalUseCase saveGroupLocalUseCase;

  final testJson = fixtureReader("group_model.json");
  final testGroupModel = GroupModel.fromJson(json.decode(testJson));
  // String groupId = testGroupModel.groupId.toString();

  setUp(() {
    mockGroupRepository = MockGroupRepository();
    saveGroupLocalUseCase = SaveGroupLocalUseCase(mockGroupRepository);
  });


  test("should return a Group model when call saveGroupLocal from the repository", () async{
    //arrange
    when(mockGroupRepository.saveGroupLocal(any))
        .thenAnswer((_) async => const Right(true));
    //actual
    final result = await saveGroupLocalUseCase(ParamsSaveGroupLocalUseCase(groupItem: testGroupModel));
    verify(mockGroupRepository.saveGroupLocal(testGroupModel));
    expect(result, const Right(true));
  });
}

