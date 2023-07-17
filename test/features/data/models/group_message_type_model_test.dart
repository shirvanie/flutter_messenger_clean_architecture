

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:messenger/features/data/models/group_message_type_model.dart';
import 'package:messenger/features/domain/entities/group_message_type_entity.dart';

import '../../../fixtures/fixture_reader.dart';


void main() {
  const tGroupMessageTypeModel = GroupMessageTypeModel(
    id: 1,
    groupId: "987654321",
    messageId: "123456789",
    receiverPhoneNumber: "09120654321",
    messageType: "sent",
    messageIsReadByGroupUser: true,
  );

  test("should be a subclass of GroupMessageTypeEntity", () async {
    expect(tGroupMessageTypeModel, isA<GroupMessageTypeEntity>());
  });

  test("fromJson", () async {
    //arrange
    final Map<String, dynamic> jsonMap =
    json.decode(fixtureReader("group_message_type_model.json"));
    // act
    final result = GroupMessageTypeModel.fromJson(jsonMap);
    // assert
    expect(result, tGroupMessageTypeModel);
  });

  test("toJson", () async {
    //arrange
    final result = tGroupMessageTypeModel.toJson();
    // act
    final expectedGroupMessageTypeMap = {
      "id": 1,
      "groupId": "987654321",
      "messageId": "123456789",
      "receiverPhoneNumber": "09120654321",
      "messageType": "sent",
      "messageIsReadByGroupUser": true
    };
    // assert
    expect(result, expectedGroupMessageTypeMap);
  });
}
