


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/data/models/user_model.dart';
import 'package:messenger/features/domain/usecases/user_usecases/get_all_users_remote_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';


void main() {
  late MockUserRepository mockUserRepository;
  late GetAllUsersRemoteUseCase getAllUsersRemoteUseCase;

  final testJson = fixtureReader("user_model.json");
  final testUserModel = UserModel.fromJson(json.decode(testJson));

  setUp(() {
    mockUserRepository = MockUserRepository();
    getAllUsersRemoteUseCase = GetAllUsersRemoteUseCase(mockUserRepository);
  });


  test("should return all Users when call getAllUsersRemote from the repository", () async{
    //arrange
    when(mockUserRepository.getAllUsersRemote())
        .thenAnswer((_) async => Right([testUserModel]));
    //actual
    final result = await getAllUsersRemoteUseCase(NoParams());
    verify(mockUserRepository.getAllUsersRemote());
    expect(result.getOrElse(() => []), [testUserModel]);
  });
}



