

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:messenger/features/data/models/user_model.dart';
import 'package:messenger/features/domain/entities/user_entity.dart';

import '../../../fixtures/fixture_reader.dart';


void main() {
  const testUserModel = UserModel(
    id: 1,
    userPhoneNumber: "09120123456",
    fullName: "testFullName",
    userAvatar: "testAvatar.jpg",
    lastSeenDateTime: "2023-01-01 12:00:00",
    lastMessageBody: "testMessage",
    lastMessageDateTime: "2023-01-01 12:00:00",
    lastMessageCategory: "text",
    lastMessageType: "sent",
    lastMessageIsReadByTargetUser: true,
    isConfirm: true,
    notReadMessageCount: 0,
    verifyCode: "456789",
    verifyProfile: true,
  );

  test("should be a subclass of UserEntity", () async {
    expect(testUserModel, isA<UserEntity>());
  });

  test("fromJson", () async {
    //arrange
    final Map<String, dynamic> jsonMap =
      json.decode(fixtureReader("user_model.json"));
    // act
    final result = UserModel.fromJson(jsonMap);
    // assert
    expect(result, testUserModel);
  });


  test("toJson", () async {
    //arrange
    final result = testUserModel.toJson();
    // act
    final expectedUserMap = {
      "id": 1,
      "userPhoneNumber": "09120123456",
      "fullName": "testFullName",
      "userAvatar": "testAvatar.jpg",
      "lastSeenDateTime": "2023-01-01 12:00:00",
      "lastMessageBody": "testMessage",
      "lastMessageDateTime": "2023-01-01 12:00:00",
      "lastMessageCategory": "text",
      "lastMessageType": "sent",
      "lastMessageIsReadByTargetUser": true,
      "isConfirm": true,
      "notReadMessageCount": 0,
      "verifyCode": "456789",
      "verifyProfile": true
    };
    // assert
    expect(result, expectedUserMap);
  });
}
