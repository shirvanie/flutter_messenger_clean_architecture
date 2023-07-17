


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/user_model.dart';
import 'package:messenger/features/domain/usecases/user_usecases/get_user_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';


void main() {
  late MockUserRepository mockUserRepository;
  late GetUserLocalUseCase getUserLocalUseCase;

  final testJson = fixtureReader("user_model.json");
  final testUserModel = UserModel.fromJson(json.decode(testJson));
  String userPhoneNumber = testUserModel.userPhoneNumber.toString();

  setUp(() {
    mockUserRepository = MockUserRepository();
    getUserLocalUseCase = GetUserLocalUseCase(mockUserRepository);
  });


  test("should return a User model when call getUserLocal from the repository", () async{
    //arrange
    when(mockUserRepository.getUserLocal(any))
        .thenAnswer((_) async => Right(testUserModel));
    //actual
    final result = await getUserLocalUseCase(ParamsGetUserLocalUseCase(userPhoneNumber: userPhoneNumber));
    verify(mockUserRepository.getUserLocal(userPhoneNumber));
    expect(result, Right(testUserModel));
  });
}



