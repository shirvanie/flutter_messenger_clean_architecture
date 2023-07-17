

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/features/data/models/group_user_model.dart';
import 'package:messenger/features/domain/entities/group_user_entity.dart';

abstract class GroupUserRemoteDataSource {
  Future<List<GroupUserEntity>> getAllGroupUsersRemote(String groupId);
  Future<List<GroupUserEntity>> getAllGroupUsersByPhoneNumberRemote(String userPhoneNumber);
  Future<bool> saveGroupUserRemote(GroupUserEntity groupUserItem);
  Future<bool> removeGroupUserRemote(String groupId, String userPhoneNumber);
}

class GroupUserRemoteDataSourceImpl implements GroupUserRemoteDataSource {

  late final Dio dio;

  GroupUserRemoteDataSourceImpl({required this.dio});


  @override
  Future<List<GroupUserEntity>> getAllGroupUsersRemote(String groupId) async {
    final response = await dio.post(
      Constants.getAllGroupUsersApiUrl,
      data: jsonEncode({
        'groupId': groupId,
      }),
    );
    if(response.statusCode == 200) {
      final responseBody = json.decode(response.toString()) as List;
      return responseBody.map((e) => GroupUserModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<GroupUserEntity>> getAllGroupUsersByPhoneNumberRemote(String userPhoneNumber) async {
    final response = await dio.post(
      Constants.getAllGroupUsersByPhoneNumberApiUrl,
      data: jsonEncode({
        'userPhoneNumber': userPhoneNumber,
      }),
    );
    if(response.statusCode == 200) {
      final responseBody = json.decode(response.toString()) as List;
      return responseBody.map((e) => GroupUserModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> removeGroupUserRemote(String groupId, String userPhoneNumber) async {
    final response = await dio.post(
      Constants.removeGroupUserApiUrl,
      data: jsonEncode({
        'groupId': groupId,
        'userPhoneNumber': userPhoneNumber
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
  Future<bool> saveGroupUserRemote(GroupUserEntity groupUserItem) async {
    final response = await dio.post(
      Constants.saveGroupUserApiUrl,
      data: jsonEncode(groupUserItem),
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

}
