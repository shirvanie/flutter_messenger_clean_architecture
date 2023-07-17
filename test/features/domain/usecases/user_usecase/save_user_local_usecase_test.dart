


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/user_model.dart';
import 'package:messenger/features/domain/usecases/user_usecases/save_user_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';


void main() {
  late MockUserRepository mockUserRepository;
  late SaveUserLocalUseCase saveUserLocalUseCase;

  final testJson = fixtureReader("user_model.json");
  final testUserModel = UserModel.fromJson(json.decode(testJson));

  setUp(() {
    mockUserRepository = MockUserRepository();
    saveUserLocalUseCase = SaveUserLocalUseCase(mockUserRepository);
  });


  test("should return true when call saveUserLocal from the repository", () async{
    //arrange
    when(mockUserRepository.saveUserLocal(any))
        .thenAnswer((_) async => const Right(true));
    //actual
    final result = await saveUserLocalUseCase(ParamsSaveUserLocalUseCase(userItem: testUserModel));
    verify(mockUserRepository.saveUserLocal(testUserModel));
    expect(result, const Right(true));
  });
}



