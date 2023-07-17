

import 'package:dartz/dartz.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/features/domain/entities/group_message_entity.dart';

abstract class GroupMessageRepository{
  /// Local
  Future<Either<Failure, bool>> existGroupMessageLocal(String messageId);
  Future<Either<Failure, List<GroupMessageEntity>>> getAllGroupMessagesLocal(String groupId);
  Future<Either<Failure, GroupMessageEntity>> getGroupMessageLocal(String messageId);
  Future<Either<Failure, bool>> removeGroupMessageLocal(String messageId);
  Future<Either<Failure, bool>> saveGroupMessageLocal(GroupMessageEntity groupMessageItem);
  Future<Either<Failure, List<GroupMessageEntity>>> getAllUnsendGroupMessagesLocal(String senderPhoneNumber);

  /// Remote
  Future<Either<Failure, List<GroupMessageEntity>>> getAllGroupMessagesRemote(String groupId);
  Future<Either<Failure, bool>> removeGroupMessageRemote(String messageId);
  Future<Either<Failure, GroupMessageEntity>> getGroupMessageRemote(String messageId);
  Future<Either<Failure, List<GroupMessageEntity>>> getMissedGroupMessagesRemote(String groupId, String receiverPhoneNumber);
  Future<Either<Failure, bool>> saveGroupMessageRemote(GroupMessageEntity groupMessageItem);
  Future<Either<Failure, bool>> updateAllGroupMessagesRemote(List<GroupMessageEntity> groupMessageItems);
}
