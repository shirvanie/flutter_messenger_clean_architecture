


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/user_model.dart';
import 'package:messenger/features/domain/usecases/user_usecases/exist_user_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';


void main() {
  late MockUserRepository mockUserRepository;
  late ExistUserLocalUseCase existUserLocalUseCase;

  final testJson = fixtureReader("user_model.json");
  final testUserModel = UserModel.fromJson(json.decode(testJson));
  String userPhoneNumber = testUserModel.userPhoneNumber.toString();

  setUp(() {
    mockUserRepository = MockUserRepository();
    existUserLocalUseCase = ExistUserLocalUseCase(mockUserRepository);
  });


  test("should return true when call existsUserLocal from the repository", () async{
    //arrange
    when(mockUserRepository.existUserLocal(any))
        .thenAnswer((_) async => const Right(true));
    //actual
    final result = await existUserLocalUseCase(ParamsExistUserLocalUseCase(userPhoneNumber: userPhoneNumber));
    verify(mockUserRepository.existUserLocal(userPhoneNumber));
    expect(result, const Right(true));
  });
}



