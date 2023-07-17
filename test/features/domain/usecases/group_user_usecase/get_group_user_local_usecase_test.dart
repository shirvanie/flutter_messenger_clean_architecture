


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_user_model.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/get_group_user_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupUserRepository mockGroupUserRepository;
  late GetGroupUserLocalUseCase getGroupUserLocalUseCase;

  final testJson = fixtureReader("group_user_model.json");
  final testGroupUserModel = GroupUserModel.fromJson(json.decode(testJson));
  String groupId = testGroupUserModel.groupId.toString();
  String userPhoneNumber = testGroupUserModel.userPhoneNumber.toString();

  setUp(() {
    mockGroupUserRepository = MockGroupUserRepository();
    getGroupUserLocalUseCase = GetGroupUserLocalUseCase(mockGroupUserRepository);
  });


  test("should return a GroupUser model when call getGroupUserLocal from the repository", () async{
    //arrange
    when(mockGroupUserRepository.getGroupUserLocal(any, any))
        .thenAnswer((_) async => Right(testGroupUserModel));
    //actual
    final result = await getGroupUserLocalUseCase(ParamsGetGroupUserLocalUseCase(groupId: groupId, userPhoneNumber: userPhoneNumber));
    verify(mockGroupUserRepository.getGroupUserLocal(groupId, userPhoneNumber));
    expect(result, Right(testGroupUserModel));
  });
}

