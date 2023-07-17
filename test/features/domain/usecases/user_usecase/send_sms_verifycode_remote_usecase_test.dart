


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:messenger/features/data/models/sms_model.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/user_model.dart';
import 'package:messenger/features/domain/usecases/user_usecases/send_sms_verifycode_remote_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';


void main() {
  late MockUserRepository mockUserRepository;
  late SendSMSVerifyCodeRemoteUseCase sendSMSVerifyCodeRemoteUseCase;

  final testJson = fixtureReader("user_model.json");
  final testUserModel = UserModel.fromJson(json.decode(testJson));
  final testSMSModel = SMSModel(userPhoneNumber: testUserModel.userPhoneNumber!,
      verifyCode: testUserModel.verifyCode!);

  setUp(() {
    mockUserRepository = MockUserRepository();
    sendSMSVerifyCodeRemoteUseCase = SendSMSVerifyCodeRemoteUseCase(mockUserRepository);
  });


  test("should return true when call sendSMSVerifyCodeRemote from the repository", () async{
    //arrange
    when(mockUserRepository.sendSMSVerifyCodeRemote(any))
        .thenAnswer((_) async => const Right(true));
    //actual
    final result = await sendSMSVerifyCodeRemoteUseCase(ParamsSendSMSVerifyCodeRemoteUseCase(smsItem: testSMSModel));
    verify(mockUserRepository.sendSMSVerifyCodeRemote(testSMSModel));
    expect(result, const Right(true));
  });
}



