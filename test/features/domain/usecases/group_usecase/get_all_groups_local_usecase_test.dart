
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/data/models/group_model.dart';
import 'package:messenger/features/domain/usecases/group_usecases/get_all_groups_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupRepository mockGroupRepository;
  late GetAllGroupsLocalUseCase getAllGroupsLocalUseCase;

  final testJson = fixtureReader("group_model.json");
  final testGroupModel = GroupModel.fromJson(json.decode(testJson));

  setUp(() {
    mockGroupRepository = MockGroupRepository();
    getAllGroupsLocalUseCase = GetAllGroupsLocalUseCase(mockGroupRepository);
  });


  test("should return all Groups when call getAllGroupsLocal from the repository", () async{
    //arrange
    when(mockGroupRepository.getAllGroupsLocal())
        .thenAnswer((_) async => Right([testGroupModel]));
    //actual
    final result = await getAllGroupsLocalUseCase(NoParams());
    verify(mockGroupRepository.getAllGroupsLocal());
    expect(result.getOrElse(() => []), [testGroupModel]);
  });
}