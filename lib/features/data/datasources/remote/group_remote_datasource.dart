

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/features/data/models/group_model.dart';
import 'package:messenger/features/domain/entities/group_entity.dart';

abstract class GroupRemoteDataSource {
  Future<List<GroupEntity>> getAllGroupsRemote();
  Future<GroupEntity> getGroupRemote(String groupId);
  Future<bool> saveGroupRemote(GroupEntity groupItem);
}

class GroupRemoteDataSourceImpl implements GroupRemoteDataSource {

  late final Dio dio;

  GroupRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<GroupEntity>> getAllGroupsRemote() async {
    final response = await dio.get(
      Constants.getAllGroupsApiUrl,
    );
    if(response.statusCode == 200) {
      final responseBody = json.decode(response.toString()) as List;
      return responseBody.map((e) => GroupModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<GroupEntity> getGroupRemote(String groupId) async {
    final response = await dio.post(
      Constants.getGroupApiUrl,
      data: jsonEncode({
        'groupId': groupId,
      }),
    );
    if(response.statusCode == 200) {
      final responseBody = json.decode(response.toString()) as Map<String, dynamic>;
      return GroupModel.fromJson(responseBody);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> saveGroupRemote(GroupEntity groupItem) async {
    final response = await dio.post(
      Constants.saveGroupApiUrl,
      data: jsonEncode(groupItem),
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
