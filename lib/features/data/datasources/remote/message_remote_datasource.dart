


import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/features/data/models/message_model.dart';
import 'package:messenger/features/domain/entities/message_entity.dart';

abstract class MessageRemoteDataSource {
  Future<List<MessageEntity>> getAllMessagesRemote(String senderPhoneNumber, String targetPhoneNumber);
  Future<bool> removeMessageRemote(String messageId);
  Future<MessageEntity> getMessageRemote(String messageId);
  Future<List<MessageEntity>> getMissedMessagesRemote(String targetPhoneNumber);
  Future<bool> saveMessageRemote(MessageEntity messageItem);
  Future<bool> updateAllMessagesRemote(List<MessageEntity> messageItems);
}

class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {

  late final Dio dio;

  MessageRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MessageEntity>> getAllMessagesRemote(String senderPhoneNumber, String targetPhoneNumber) async {
    final response = await dio.post(
      Constants.getAllMessagesApiUrl,
      data: jsonEncode({
        'senderPhoneNumber': senderPhoneNumber,
        'targetPhoneNumber': targetPhoneNumber
      }),
    );
    if(response.statusCode == 200) {
      final responseBody = json.decode(response.toString()) as List;
      return responseBody.map((e) => MessageModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MessageEntity> getMessageRemote(String messageId) async {
    final response = await dio.post(
      Constants.getMessageApiUrl,
      data: jsonEncode({
        'messageId': messageId,
      }),
    );
    if(response.statusCode == 200) {
      final responseBody = json.decode(response.toString()) as Map<String, dynamic>;
      return MessageModel.fromJson(responseBody);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MessageEntity>> getMissedMessagesRemote(String targetPhoneNumber) async {
    final response = await dio.post(
      Constants.getMissedMessagesApiUrl,
      data: jsonEncode({
        'targetPhoneNumber': targetPhoneNumber,
      }),
    );
    if(response.statusCode == 200) {
      final responseBody = json.decode(response.toString()) as List;
      return responseBody.map((e) => MessageModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> removeMessageRemote(String messageId) async {
    final response = await dio.post(
      Constants.removeMessageApiUrl,
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
  Future<bool> saveMessageRemote(MessageEntity messageItem) async {
    final response = await dio.post(
      Constants.saveMessageApiUrl,
      data: jsonEncode(messageItem),
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
  Future<bool> updateAllMessagesRemote(List<MessageEntity> messageItems) async {
    final response = await dio.post(
      Constants.updateAllMessagesApiUrl,
      data: jsonEncode(messageItems),
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
