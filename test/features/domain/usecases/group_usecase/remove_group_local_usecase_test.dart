


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_model.dart';
import 'package:messenger/features/domain/usecases/group_usecases/remove_group_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupRepository mockGroupRepository;
  late RemoveGroupLocalUseCase removeGroupLocalUseCase;

  final testJson = fixtureReader("group_model.json");
  final testGroupModel = GroupModel.fromJson(json.decode(testJson));
  String groupId = testGroupModel.groupId.toString();

  setUp(() {
    mockGroupRepository = MockGroupRepository();
    removeGroupLocalUseCase = RemoveGroupLocalUseCase(mockGroupRepository);
  });


  test("should return a Group model when call removeGroupLocal from the repository", () async{
    //arrange
    when(mockGroupRepository.removeGroupLocal(any))
        .thenAnswer((_) async => const Right(true));
    //actual
    final result = await removeGroupLocalUseCase(ParamsRemoveGroupLocalUseCase(groupId: groupId));
    verify(mockGroupRepository.removeGroupLocal(groupId));
    expect(result, const Right(true));
  });
}

