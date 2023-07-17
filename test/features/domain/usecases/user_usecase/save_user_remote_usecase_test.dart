


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/user_model.dart';
import 'package:messenger/features/domain/usecases/user_usecases/save_user_remote_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';


void main() {
  late MockUserRepository mockUserRepository;
  late SaveUserRemoteUseCase saveUserRemoteUseCase;

  final testJson = fixtureReader("user_model.json");
  final testUserModel = UserModel.fromJson(json.decode(testJson));

  setUp(() {
    mockUserRepository = MockUserRepository();
    saveUserRemoteUseCase = SaveUserRemoteUseCase(mockUserRepository);
  });


  test("should return true when call saveUserRemote from the repository", () async{
    //arrange
    when(mockUserRepository.saveUserRemote(any))
        .thenAnswer((_) async => const Right(true));
    //actual
    final result = await saveUserRemoteUseCase(ParamsSaveUserRemoteUseCase(userItem: testUserModel));
    verify(mockUserRepository.saveUserRemote(testUserModel));
    expect(result, const Right(true));
  });
}



