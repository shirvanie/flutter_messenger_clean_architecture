
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_user_model.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/get_all_group_users_remote_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupUserRepository mockGroupUserRepository;
  late GetAllGroupUsersRemoteUseCase getAllGroupUsersRemoteUseCase;

  final testJson = fixtureReader("group_user_model.json");
  final testGroupUserModel = GroupUserModel.fromJson(json.decode(testJson));
  String groupId = testGroupUserModel.groupId.toString();

  setUp(() {
    mockGroupUserRepository = MockGroupUserRepository();
    getAllGroupUsersRemoteUseCase = GetAllGroupUsersRemoteUseCase(mockGroupUserRepository);
  });


  test("should return all GroupUsers when call getAllGroupUsersRemote from the repository", () async{
    //arrange
    when(mockGroupUserRepository.getAllGroupUsersRemote(groupId))
        .thenAnswer((_) async => Right([testGroupUserModel]));
    //actual
    final result = await getAllGroupUsersRemoteUseCase(ParamsGetAllGroupUsersRemoteUseCase(groupId: groupId));
    verify(mockGroupUserRepository.getAllGroupUsersRemote(groupId));
    expect(result.getOrElse(() => []), [testGroupUserModel]);
  });
}