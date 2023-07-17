
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_user_model.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/get_all_group_users_by_phone_number_remote_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupUserRepository mockGroupUserRepository;
  late GetAllGroupUsersByPhoneNumberRemoteUseCase getAllGroupUsersByPhoneNumberRemoteUseCase;

  final testJson = fixtureReader("group_user_model.json");
  final testGroupUserModel = GroupUserModel.fromJson(json.decode(testJson));
  String userPhoneNumber = testGroupUserModel.userPhoneNumber.toString();

  setUp(() {
    mockGroupUserRepository = MockGroupUserRepository();
    getAllGroupUsersByPhoneNumberRemoteUseCase = GetAllGroupUsersByPhoneNumberRemoteUseCase(mockGroupUserRepository);
  });


  test("should return all GroupUsers by userPhoneNumber when call getAllGroupUsersByPhoneNumberRemote from the repository", () async{
    //arrange
    when(mockGroupUserRepository.getAllGroupUsersByPhoneNumberRemote(userPhoneNumber))
        .thenAnswer((_) async => Right([testGroupUserModel]));
    //actual
    final result = await getAllGroupUsersByPhoneNumberRemoteUseCase(ParamsGetAllGroupUsersByPhoneNumberRemoteUseCase(userPhoneNumber: userPhoneNumber));
    verify(mockGroupUserRepository.getAllGroupUsersByPhoneNumberRemote(userPhoneNumber));
    expect(result.getOrElse(() => []), [testGroupUserModel]);
  });
}