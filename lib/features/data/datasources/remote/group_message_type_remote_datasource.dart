

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/features/data/models/group_message_type_model.dart';
import 'package:messenger/features/domain/entities/group_message_type_entity.dart';

abstract class GroupMessageTypeRemoteDataSource {
  Future<List<GroupMessageTypeEntity>> getAllGroupMessageTypesRemote(String groupId, String messageId);
  Future<bool> removeGroupMessageTypeRemote(String messageId);
  Future<GroupMessageTypeEntity> getGroupMessageTypeRemote(String messageId);
  Future<bool> saveGroupMessageTypeRemote(GroupMessageTypeEntity groupMessageTypeItem);
  Future<bool> updateAllGroupMessageTypesRemote(List<GroupMessageTypeEntity> groupMessageTypeItems);
}

class GroupMessageTypeRemoteDataSourceImpl implements GroupMessageTypeRemoteDataSource {
  late final Dio dio;

  GroupMessageTypeRemoteDataSourceImpl({required this.dio});


  @override
  Future<List<GroupMessageTypeEntity>> getAllGroupMessageTypesRemote(String groupId, String messageId) async {
    final response = await dio.post(
      Constants.getAllGroupMessageTypesApiUrl,
      data: jsonEncode({
        'groupId': groupId,
        'messageId': messageId,
      }),
    );
    if(response.statusCode == 200) {
      final responseBody = json.decode(response.toString()) as List;
      return responseBody.map((e) => GroupMessageTypeModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<GroupMessageTypeEntity> getGroupMessageTypeRemote(String messageId) async {
    final response = await dio.post(
      Constants.getGroupMessageTypeApiUrl,
      data: jsonEncode({
        'messageId': messageId,
      }),
    );
    if(response.statusCode == 200) {
      final responseBody = json.decode(response.toString()) as Map<String, dynamic>;
      return GroupMessageTypeModel.fromJson(responseBody);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> removeGroupMessageTypeRemote(String messageId) async {
    final response = await dio.post(
      Constants.removeGroupMessageTypeApiUrl,
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
  Future<bool> saveGroupMessageTypeRemote(GroupMessageTypeEntity groupMessageTypeItem) async {
    final response = await dio.post(
      Constants.saveGroupMessageTypeApiUrl,
      data: jsonEncode(groupMessageTypeItem),
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
  Future<bool> updateAllGroupMessageTypesRemote(List<GroupMessageTypeEntity> groupMessageTypeItems) async {
    final response = await dio.post(
      Constants.updateAllGroupMessageTypesApiUrl,
      data: jsonEncode(groupMessageTypeItems),
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
