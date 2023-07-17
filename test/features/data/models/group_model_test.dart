

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:messenger/features/data/models/group_model.dart';
import 'package:messenger/features/domain/entities/group_entity.dart';

import '../../../fixtures/fixture_reader.dart';


void main() {
  const tGroupModel = GroupModel(
    id: 1,
    groupId: "987654321",
    groupCreatorUserPhoneNumber: "09120123456",
    groupName: "testGroupName",
    groupAvatar: "testAvatar.jpg",
    createDateTime: "2023-01-01 12:00:00",
    lastMessageSenderFullName: "testFullName",
    lastMessageBody: "testMessage",
    lastMessageDateTime: "2023-01-01 12:00:00",
    lastMessageCategory: "text",
    lastMessageType: "sent",
    lastMessageIsReadByGroupUser: true,
    isConfirm: true,
    notReadMessageCount: 0,
  );

  test("should be a subclass of GroupEntity", () async {
    expect(tGroupModel, isA<GroupEntity>());
  });

  test("fromJson", () async {
    //arrange
    final Map<String, dynamic> jsonMap =
    json.decode(fixtureReader("group_model.json"));
    // act
    final result = GroupModel.fromJson(jsonMap);
    // assert
    expect(result, tGroupModel);
  });

  test("toJson", () async {
    //arrange
    final result = tGroupModel.toJson();
    // act
    final expectedGroupMap = {
      "id": 1,
      "groupId": "987654321",
      "groupCreatorUserPhoneNumber": "09120123456",
      "groupName": "testGroupName",
      "groupAvatar": "testAvatar.jpg",
      "createDateTime": "2023-01-01 12:00:00",
      "lastMessageSenderFullName": "testFullName",
      "lastMessageBody": "testMessage",
      "lastMessageDateTime": "2023-01-01 12:00:00",
      "lastMessageCategory": "text",
      "lastMessageType": "sent",
      "lastMessageIsReadByGroupUser": true,
      "isConfirm": true,
      "notReadMessageCount": 0
    };
    // assert
    expect(result, expectedGroupMap);
  });
}
