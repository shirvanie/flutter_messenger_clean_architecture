


import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/features/data/models/group_message_model.dart';
import 'package:messenger/features/domain/entities/group_message_entity.dart';

abstract class GroupMessageRemoteDataSource {
  Future<List<GroupMessageEntity>> getAllGroupMessagesRemote(String groupId);
  Future<bool> removeGroupMessageRemote(String messageId);
  Future<GroupMessageEntity> getGroupMessageRemote(String messageId);
  Future<List<GroupMessageEntity>> getMissedGroupMessagesRemote(String groupId, String receiverPhoneNumber);
  Future<bool> saveGroupMessageRemote(GroupMessageEntity groupMessageItem);
  Future<bool> updateAllGroupMessagesRemote(List<GroupMessageEntity> groupMessageItems);
}

class GroupMessageRemoteDataSourceImpl implements GroupMessageRemoteDataSource {
  late final Dio dio;

  GroupMessageRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<GroupMessageEntity>> getAllGroupMessagesRemote(String groupId) async {
    final response = await dio.post(
      Constants.getAllGroupMessagesApiUrl,
      data: jsonEncode({
        'groupId': groupId,
      }),
    );
    if(response.statusCode == 200) {
      final responseBody = json.decode(response.toString()) as List;
      return responseBody.map((e) => GroupMessageModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<GroupMessageEntity> getGroupMessageRemote(String messageId) async {
    final response = await dio.post(
      Constants.getGroupMessageApiUrl,
      data: jsonEncode({
        'messageId': messageId,
      }),
    );
    if(response.statusCode == 200) {
      final responseBody = json.decode(response.toString()) as Map<String, dynamic>;
      return GroupMessageModel.fromJson(responseBody);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<GroupMessageEntity>> getMissedGroupMessagesRemote(String groupId, String receiverPhoneNumber) async {
    final response = await dio.post(
      Constants.getMissedGroupMessagesApiUrl,
      data: jsonEncode({
        'groupId': groupId,
        'receiverPhoneNumber': receiverPhoneNumber,
      }),
    );
    if(response.statusCode == 200) {
      final responseBody = json.decode(response.toString()) as List;
      return responseBody.map((e) => GroupMessageModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> removeGroupMessageRemote(String messageId) async {
    final response = await dio.post(
      Constants.removeGroupMessageApiUrl,
      data: jsonEncode({
        'messageId': messageId,
      }),
    );
    if(response.statusCode == 200) {
      final responseBody = json.decode(response.toString()) as String;
      if(responseBody == "Data Removed") {
        return true;
      } else {
        return false;
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> saveGroupMessageRemote(GroupMessageEntity groupMessageItem) async {
    final response = await dio.post(
      Constants.saveGroupMessageApiUrl,
      data: jsonEncode(groupMessageItem),
    );
    if(response.statusCode == 200) {
      final responseBody = json.decode(response.toString()) as String;
      if(responseBody == "Data Saved") {
        return true;
      } else {
        return false;
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> updateAllGroupMessagesRemote(List<GroupMessageEntity> groupMessageItems) async {
    final response = await dio.post(
      Constants.updateAllGroupMessagesApiUrl,
      data: jsonEncode(groupMessageItems),
    );
    if(response.statusCode == 200) {
      final responseBody = json.decode(response.toString()) as String;
      if(responseBody == "Data Updated") {
        return true;
      } else {
        return false;
      }
    } else {
      throw ServerException();
    }
  }


}
