

import 'package:dartz/dartz.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/features/domain/entities/group_message_type_entity.dart';

abstract class GroupMessageTypeRepository{
  /// Local
  Future<Either<Failure, bool>> existGroupMessageTypeLocal(String messageId);
  Future<Either<Failure, List<GroupMessageTypeEntity>>> getAllGroupMessageTypesLocal(String groupId, String messageId);
  Future<Either<Failure, GroupMessageTypeEntity>> getGroupMessageTypeLocal(String messageId);
  Future<Either<Failure, bool>> removeGroupMessageTypeLocal(String messageId);
  Future<Either<Failure, bool>> saveGroupMessageTypeLocal(GroupMessageTypeEntity groupMessageTypeItem);
  Future<Either<Failure, List<GroupMessageTypeEntity>>> getAllUnsendGroupMessageTypesLocal(String receiverPhoneNumber);
  Future<Either<Failure, List<GroupMessageTypeEntity>>> getAllNotReadGroupMessageTypesLocal(String groupId);

  /// Remote
  Future<Either<Failure, List<GroupMessageTypeEntity>>> getAllGroupMessageTypesRemote(String groupId, String messageId);
  Future<Either<Failure, bool>> removeGroupMessageTypeRemote(String messageId);
  Future<Either<Failure, GroupMessageTypeEntity>> getGroupMessageTypeRemote(String messageId);
  Future<Either<Failure, bool>> saveGroupMessageTypeRemote(GroupMessageTypeEntity groupMessageTypeItem);
  Future<Either<Failure, bool>> updateAllGroupMessageTypesRemote(List<GroupMessageTypeEntity> groupMessageTypeItems);
}
