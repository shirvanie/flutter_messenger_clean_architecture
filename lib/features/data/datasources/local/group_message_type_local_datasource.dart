


import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/features/data/datasources/db/database_helper.dart';
import 'package:messenger/features/domain/entities/group_message_type_entity.dart';

abstract class GroupMessageTypeLocalDataSource {
  Future<bool> existGroupMessageTypeLocal(String messageId);
  Future<List<GroupMessageTypeEntity>> getAllGroupMessageTypesLocal(String groupId, String messageId);
  Future<GroupMessageTypeEntity> getGroupMessageTypeLocal(String messageId);
  Future<bool> removeGroupMessageTypeLocal(String messageId);
  Future<bool> saveGroupMessageTypeLocal(GroupMessageTypeEntity groupMessageTypeItem);
  Future<List<GroupMessageTypeEntity>> getAllUnsendGroupMessageTypesLocal(String receiverPhoneNumber);
  Future<List<GroupMessageTypeEntity>> getAllNotReadGroupMessageTypesLocal(String groupId);
}

class GroupMessageTypeLocalDataSourceImpl implements GroupMessageTypeLocalDataSource {

  final DatabaseHelper databaseHelper;
  GroupMessageTypeLocalDataSourceImpl(this.databaseHelper);


  @override
  Future<bool> existGroupMessageTypeLocal(String messageId) async {
    try{
      return await databaseHelper.existGroupMessageTypeLocal(messageId);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<List<GroupMessageTypeEntity>> getAllGroupMessageTypesLocal(String groupId, String messageId) async {
    try{
      return await databaseHelper.getAllGroupMessageTypesLocal(groupId, messageId);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<GroupMessageTypeEntity> getGroupMessageTypeLocal(String messageId) async {
    try{
      return await databaseHelper.getGroupMessageTypeLocal(messageId);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<bool> removeGroupMessageTypeLocal(String messageId) async {
    try{
      return await databaseHelper.removeGroupMessageTypeLocal(messageId);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<bool> saveGroupMessageTypeLocal(GroupMessageTypeEntity groupMessageTypeItem) async {
    try{
      return await databaseHelper.saveGroupMessageTypeLocal(groupMessageTypeItem);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<List<GroupMessageTypeEntity>> getAllNotReadGroupMessageTypesLocal(String groupId) async {
    try{
      return await databaseHelper.getAllNotReadGroupMessageTypesLocal(groupId);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<List<GroupMessageTypeEntity>> getAllUnsendGroupMessageTypesLocal(String receiverPhoneNumber) async {
    try{
      return await databaseHelper.getAllUnsendGroupMessageTypesLocal(receiverPhoneNumber);
    } catch (e) {
      throw DatabaseException();
    }
  }

}
