

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:messenger/features/data/models/message_model.dart';
import 'package:messenger/features/domain/entities/message_entity.dart';

import '../../../fixtures/fixture_reader.dart';


void main() {
  const tMessageModel = MessageModel(
    id: 1,
    messageId: "123456789",
    senderPhoneNumber: "09120123456",
    targetPhoneNumber: "09120654321",
    messageCategory: "text",
    messageBody: "testMessage",
    messageDateTime: "2023-01-01 12:00:00",
    messageType: "send",
    messageIsReadByTargetUser: true,
  );

  test("should be a subclass of MessageEntity", () async {
    expect(tMessageModel, isA<MessageEntity>());
  });

  test("fromJson", () async {
    //arrange
    final Map<String, dynamic> jsonMap =
    json.decode(fixtureReader("message_model.json"));
    // act
    final result = MessageModel.fromJson(jsonMap);
    // assert
    expect(result, tMessageModel);
  });

  test("toJson", () async {
    //arrange
    final result = tMessageModel.toJson();
    // act
    final expectedMessageMap = {
      "id": 1,
      "messageId": "123456789",
      "senderPhoneNumber": "09120123456",
      "targetPhoneNumber": "09120654321",
      "messageCategory": "text",
      "messageBody": "testMessage",
      "messageDateTime": "2023-01-01 12:00:00",
      "messageType": "send",
      "messageIsReadByTargetUser": true
    };
    // assert
    expect(result, expectedMessageMap);
  });
}
