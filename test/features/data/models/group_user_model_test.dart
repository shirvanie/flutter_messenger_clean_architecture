

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:messenger/features/data/models/group_user_model.dart';
import 'package:messenger/features/domain/entities/group_user_entity.dart';

import '../../../fixtures/fixture_reader.dart';


void main() {
  const tGroupUserModel = GroupUserModel(
    id: 1,
    groupId: "987654321",
    userPhoneNumber: "09120123456",
    isAdmin: true,
  );

  test("should be a subclass of GroupUserEntity", () async {
    expect(tGroupUserModel, isA<GroupUserEntity>());
  });

  test("fromJson", () async {
    //arrange
    final Map<String, dynamic> jsonMap =
    json.decode(fixtureReader("group_user_model.json"));
    // act
    final result = GroupUserModel.fromJson(jsonMap);
    // assert
    expect(result, tGroupUserModel);
  });

  test("toJson", () async {
    //arrange
    final result = tGroupUserModel.toJson();
    // act
    final expectedGroupUserMap = {
      "id": 1,
      "groupId": "987654321",
      "userPhoneNumber": "09120123456",
      "isAdmin": true
    };
    // assert
    expect(result, expectedGroupUserMap);
  });
}
