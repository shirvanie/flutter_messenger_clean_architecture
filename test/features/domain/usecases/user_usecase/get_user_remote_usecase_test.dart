


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/user_model.dart';
import 'package:messenger/features/domain/usecases/user_usecases/get_user_remote_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';


void main() {
  late MockUserRepository mockUserRepository;
  late GetUserRemoteUseCase getUserRemoteUseCase;

  final testJson = fixtureReader("user_model.json");
  final testUserModel = UserModel.fromJson(json.decode(testJson));
  String userPhoneNumber = testUserModel.userPhoneNumber.toString();

  setUp(() {
    mockUserRepository = MockUserRepository();
    getUserRemoteUseCase = GetUserRemoteUseCase(mockUserRepository);
  });


  test("should return a User model when call getUserRemote from the repository", () async{
    //arrange
    when(mockUserRepository.getUserRemote(any))
        .thenAnswer((_) async => Right(testUserModel));
    //actual
    final result = await getUserRemoteUseCase(ParamsGetUserRemoteUseCase(userPhoneNumber: userPhoneNumber));
    verify(mockUserRepository.getUserRemote(userPhoneNumber));
    expect(result, Right(testUserModel));
  });
}



