

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:messenger/features/data/models/group_message_model.dart';
import 'package:messenger/features/domain/entities/group_message_entity.dart';

import '../../../fixtures/fixture_reader.dart';


void main() {
  const tGroupMessageModel = GroupMessageModel(
    id: 1,
    messageId: "123456789",
    groupId: "987654321",
    senderPhoneNumber: "09120123456",
    messageCategory: "text",
    messageBody: "testMessage",
    messageDateTime: "2023-01-01 12:00:00",
  );

  test("should be a subclass of GroupMessageEntity", () async {
    expect(tGroupMessageModel, isA<GroupMessageEntity>());
  });

  test("fromJson", () async {
    //arrange
    final Map<String, dynamic> jsonMap =
    json.decode(fixtureReader("group_message_model.json"));
    // act
    final result = GroupMessageModel.fromJson(jsonMap);
    // assert
    expect(result, tGroupMessageModel);
  });

  test("toJson", () async {
    //arrange
    final result = tGroupMessageModel.toJson();
    // act
    final expectedGroupMessageMap = {
      "id": 1,
      "messageId": "123456789",
      "groupId": "987654321",
      "senderPhoneNumber": "09120123456",
      "messageCategory": "text",
      "messageBody": "testMessage",
      "messageDateTime": "2023-01-01 12:00:00"
    };
    // assert
    expect(result, expectedGroupMessageMap);
  });
}
