



import 'package:flutter_test/flutter_test.dart';
import 'package:messenger/features/data/models/sms_model.dart';

void main() {
  const testSMSModel = SMSModel(
    userPhoneNumber: "09120123456",
    verifyCode: "456789",
  );

  test("should be a subclass of UserEntity", () async {
    expect(testSMSModel, isA<SMSModel>());
  });

  test("toJson", () async {
    //arrange
    final result = testSMSModel.toJson();
    // act
    final expectedUserMap = {
      "mobile": '09120123456',
      "templateId": 654321,
      "parameters": [
        {"name": "AppName", "value": "Messenger"},
        {"name": "VerifyCode", "value": "456789"}
      ]
    };
    // assert
    expect(result, expectedUserMap);
  });
}
