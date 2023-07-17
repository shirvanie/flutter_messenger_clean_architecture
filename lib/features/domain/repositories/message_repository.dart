

import 'package:dartz/dartz.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/features/domain/entities/message_entity.dart';

abstract class MessageRepository{
  /// Local
  Future<Either<Failure, bool>> existMessageLocal(String messageId);
  Future<Either<Failure, List<MessageEntity>>> getAllMessagesLocal(String senderPhoneNumber, String targetPhoneNumber);
  Future<Either<Failure, MessageEntity>> getMessageLocal(String messageId);
  Future<Either<Failure, bool>> removeMessageLocal(String messageId);
  Future<Either<Failure, bool>> saveMessageLocal(MessageEntity messageItem);
  Future<Either<Failure, List<MessageEntity>>> getAllUnsendMessagesLocal();
  Future<Either<Failure, List<MessageEntity>>> getAllNotReadMessagesLocal(String senderPhoneNumber, String targetPhoneNumber);

  /// Remote
  Future<Either<Failure, List<MessageEntity>>> getAllMessagesRemote(String senderPhoneNumber, String targetPhoneNumber);
  Future<Either<Failure, bool>> removeMessageRemote(String messageId);
  Future<Either<Failure, MessageEntity>> getMessageRemote(String messageId);
  Future<Either<Failure, List<MessageEntity>>> getMissedMessagesRemote(String targetPhoneNumber);
  Future<Either<Failure, bool>> saveMessageRemote(MessageEntity messageItem);
  Future<Either<Failure, bool>> updateAllMessagesRemote(List<MessageEntity> messageItems);
}
