


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/data/models/user_model.dart';
import 'package:messenger/features/domain/usecases/user_usecases/get_all_users_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';


void main() {
  late MockUserRepository mockUserRepository;
  late GetAllUsersLocalUseCase getAllUsersLocalUseCase;

  final testJson = fixtureReader("user_model.json");
  final testUserModel = UserModel.fromJson(json.decode(testJson));

  setUp(() {
    mockUserRepository = MockUserRepository();
    getAllUsersLocalUseCase = GetAllUsersLocalUseCase(mockUserRepository);
  });


  test("should return all Users when call getAllUsersLocal from the repository", () async{
    //arrange
    when(mockUserRepository.getAllUsersLocal())
        .thenAnswer((_) async => Right([testUserModel]));
    //actual
    final result = await getAllUsersLocalUseCase(NoParams());
    verify(mockUserRepository.getAllUsersLocal());
    expect(result.getOrElse(() => []), [testUserModel]);
  });
}



