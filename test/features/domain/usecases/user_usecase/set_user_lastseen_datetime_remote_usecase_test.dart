


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/user_model.dart';
import 'package:messenger/features/domain/usecases/user_usecases/set_user_lastseen_datetime_remote_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';


void main() {
  late MockUserRepository mockUserRepository;
  late SetUserLastSeenDateTimeRemoteUseCase setUserLastSeenDateTimeRemoteUseCase;

  final testJson = fixtureReader("user_model.json");
  final testUserModel = UserModel.fromJson(json.decode(testJson));
  String userPhoneNumber = testUserModel.userPhoneNumber.toString();
  String lastSeenDateTime = testUserModel.lastSeenDateTime.toString();

  setUp(() {
    mockUserRepository = MockUserRepository();
    setUserLastSeenDateTimeRemoteUseCase = SetUserLastSeenDateTimeRemoteUseCase(mockUserRepository);
  });


  test("should return true when call setUserLastSeenDateTimeRemote from the repository", () async{
    //arrange
    when(mockUserRepository.setUserLastSeenDateTimeRemote(any, any))
        .thenAnswer((_) async => const Right(true));
    //actual
    final result = await setUserLastSeenDateTimeRemoteUseCase(ParamsSetUserLastSeenDateTimeRemoteUseCase(userPhoneNumber: userPhoneNumber, lastSeenDateTime: lastSeenDateTime));
    verify(mockUserRepository.setUserLastSeenDateTimeRemote(userPhoneNumber, lastSeenDateTime));
    expect(result, const Right(true));
  });
}



