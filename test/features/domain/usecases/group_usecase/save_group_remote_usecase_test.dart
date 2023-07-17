


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_model.dart';
import 'package:messenger/features/domain/usecases/group_usecases/save_group_remote_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupRepository mockGroupRepository;
  late SaveGroupRemoteUseCase saveGroupRemoteUseCase;

  final testJson = fixtureReader("group_model.json");
  final testGroupModel = GroupModel.fromJson(json.decode(testJson));

  setUp(() {
    mockGroupRepository = MockGroupRepository();
    saveGroupRemoteUseCase = SaveGroupRemoteUseCase(mockGroupRepository);
  });


  test("should return a Group model when call saveGroupRemote from the repository", () async{
    //arrange
    when(mockGroupRepository.saveGroupRemote(any))
        .thenAnswer((_) async => const Right(true));
    //actual
    final result = await saveGroupRemoteUseCase(ParamsSaveGroupRemoteUseCase(groupItem: testGroupModel));
    verify(mockGroupRepository.saveGroupRemote(testGroupModel));
    expect(result, const Right(true));
  });
}

