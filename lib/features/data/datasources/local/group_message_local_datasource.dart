


import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/features/data/datasources/db/database_helper.dart';
import 'package:messenger/features/domain/entities/group_message_entity.dart';

abstract class GroupMessageLocalDataSource {
  Future<bool> existGroupMessageLocal(String messageId);
  Future<List<GroupMessageEntity>> getAllGroupMessagesLocal(String groupId);
  Future<GroupMessageEntity> getGroupMessageLocal(String messageId);
  Future<bool> removeGroupMessageLocal(String messageId);
  Future<bool> saveGroupMessageLocal(GroupMessageEntity groupMessageItem);
  Future<List<GroupMessageEntity>> getAllUnsendGroupMessagesLocal(String senderPhoneNumber);

}

class GroupMessageLocalDataSourceImpl implements GroupMessageLocalDataSource {

  final DatabaseHelper databaseHelper;
  GroupMessageLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<bool> existGroupMessageLocal(String messageId) async {
    try{
      return await databaseHelper.existGroupMessageLocal(messageId);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<List<GroupMessageEntity>> getAllGroupMessagesLocal(String groupId) async {
    try{
      return await databaseHelper.getAllGroupMessagesLocal(groupId);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<GroupMessageEntity> getGroupMessageLocal(String messageId) async {
    try{
      return await databaseHelper.getGroupMessageLocal(messageId);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<bool> removeGroupMessageLocal(String messageId) async {
    try{
      return await databaseHelper.removeGroupMessageLocal(messageId);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<bool> saveGroupMessageLocal(GroupMessageEntity groupMessageItem) async {
    try{
      return await databaseHelper.saveGroupMessageLocal(groupMessageItem);
    } catch (e) {
      throw DatabaseException();
    }
  }


  @override
  Future<List<GroupMessageEntity>> getAllUnsendGroupMessagesLocal(String senderPhoneNumber) async {
    try{
      return await databaseHelper.getAllUnsendGroupMessagesLocal(senderPhoneNumber);
    } catch (e) {
      throw DatabaseException();
    }
  }

}
