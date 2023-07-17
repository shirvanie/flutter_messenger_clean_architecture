


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/user_model.dart';
import 'package:messenger/features/domain/usecases/user_usecases/remove_user_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';


void main() {
  late MockUserRepository mockUserRepository;
  late RemoveUserLocalUseCase removeUserLocalUseCase;

  final testJson = fixtureReader("user_model.json");
  final testUserModel = UserModel.fromJson(json.decode(testJson));
  String userPhoneNumber = testUserModel.userPhoneNumber.toString();

  setUp(() {
    mockUserRepository = MockUserRepository();
    removeUserLocalUseCase = RemoveUserLocalUseCase(mockUserRepository);
  });


  test("should return true when call removeUserLocal from the repository", () async{
    //arrange
    when(mockUserRepository.removeUserLocal(any))
        .thenAnswer((_) async => const Right(true));
    //actual
    final result = await removeUserLocalUseCase(ParamsRemoveUserLocalUseCase(userPhoneNumber: userPhoneNumber));
    verify(mockUserRepository.removeUserLocal(userPhoneNumber));
    expect(result, const Right(true));
  });
}



