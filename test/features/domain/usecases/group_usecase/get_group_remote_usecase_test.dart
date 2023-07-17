


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_model.dart';
import 'package:messenger/features/domain/usecases/group_usecases/get_group_remote_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupRepository mockGroupRepository;
  late GetGroupRemoteUseCase getGroupRemoteUseCase;

  final testJson = fixtureReader("group_model.json");
  final testGroupModel = GroupModel.fromJson(json.decode(testJson));
  String groupId = testGroupModel.groupId.toString();

  setUp(() {
    mockGroupRepository = MockGroupRepository();
    getGroupRemoteUseCase = GetGroupRemoteUseCase(mockGroupRepository);
  });


  test("should return a Group model when call getGroupRemote from the repository", () async{
    //arrange
    when(mockGroupRepository.getGroupRemote(any))
        .thenAnswer((_) async => Right(testGroupModel));
    //actual
    final result = await getGroupRemoteUseCase(ParamsGetGroupRemoteUseCase(groupId: groupId));
    verify(mockGroupRepository.getGroupRemote(groupId));
    expect(result, Right(testGroupModel));
  });
}

