

import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/features/data/datasources/db/database_helper.dart';
import 'package:messenger/features/domain/entities/message_entity.dart';


abstract class MessageLocalDataSource {
  Future<bool> existMessageLocal(String messageId);
  Future<List<MessageEntity>> getAllMessagesLocal(String senderPhoneNumber, String targetPhoneNumber);
  Future<MessageEntity> getMessageLocal(String messageId);
  Future<bool> removeMessageLocal(String messageId);
  Future<bool> saveMessageLocal(MessageEntity messageItem);
  Future<List<MessageEntity>> getAllUnsendMessagesLocal();
  Future<List<MessageEntity>> getAllNotReadMessagesLocal(String senderPhoneNumber, String targetPhoneNumber);
}

class MessageLocalDataSourceImpl implements MessageLocalDataSource {

  final DatabaseHelper databaseHelper;
  MessageLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<bool> existMessageLocal(String messageId) async {
    try{
      return await databaseHelper.existMessageLocal(messageId);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<List<MessageEntity>> getAllMessagesLocal(String senderPhoneNumber, String targetPhoneNumber) async {
    try{
      return await databaseHelper.getAllMessagesLocal(senderPhoneNumber, targetPhoneNumber);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<MessageEntity> getMessageLocal(String messageId) async {
    try{
      return await databaseHelper.getMessageLocal(messageId);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<bool> removeMessageLocal(String messageId) async {
    try{
      return await databaseHelper.removeMessageLocal(messageId);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<bool> saveMessageLocal(MessageEntity messageItem) async {
    try{
      return await databaseHelper.saveMessageLocal(messageItem);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<List<MessageEntity>> getAllUnsendMessagesLocal() async {
    try{
      return await databaseHelper.getAllUnsendMessagesLocal();
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<List<MessageEntity>> getAllNotReadMessagesLocal(String senderPhoneNumber, String targetPhoneNumber) async {
    try{
      return await databaseHelper.getAllNotReadMessagesLocal(senderPhoneNumber, targetPhoneNumber);
    } catch (e) {
      throw DatabaseException();
    }
  }


}
