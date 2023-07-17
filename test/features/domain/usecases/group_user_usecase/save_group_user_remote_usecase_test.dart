


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_user_model.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/save_group_user_remote_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupUserRepository mockGroupUserRepository;
  late SaveGroupUserRemoteUseCase saveGroupUserRemoteUseCase;

  final testJson = fixtureReader("group_user_model.json");
  final testGroupUserModel = GroupUserModel.fromJson(json.decode(testJson));

  setUp(() {
    mockGroupUserRepository = MockGroupUserRepository();
    saveGroupUserRemoteUseCase = SaveGroupUserRemoteUseCase(mockGroupUserRepository);
  });


  test("should return a GroupUser model when call saveGroupUserRemote from the repository", () async{
    //arrange
    when(mockGroupUserRepository.saveGroupUserRemote(any))
        .thenAnswer((_) async => const Right(true));
    //actual
    final result = await saveGroupUserRemoteUseCase(ParamsSaveGroupUserRemoteUseCase(groupUserItem: testGroupUserModel));
    verify(mockGroupUserRepository.saveGroupUserRemote(testGroupUserModel));
    expect(result, const Right(true));
  });
}

