

import 'package:dartz/dartz.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/features/domain/entities/group_user_entity.dart';

abstract class GroupUserRepository{
  /// Local
  Future<Either<Failure, List<GroupUserEntity>>> getAllGroupUsersLocal(String groupId);
  Future<Either<Failure, GroupUserEntity>> getGroupUserLocal(String groupId, String userPhoneNumber);
  Future<Either<Failure, bool>> removeGroupUserLocal(String groupId, String userPhoneNumber);
  Future<Either<Failure, bool>> saveGroupUserLocal(GroupUserEntity groupItem);

  /// Remote
  Future<Either<Failure, List<GroupUserEntity>>> getAllGroupUsersRemote(String groupId);
  Future<Either<Failure, List<GroupUserEntity>>> getAllGroupUsersByPhoneNumberRemote(String userPhoneNumber);
  Future<Either<Failure, bool>> saveGroupUserRemote(GroupUserEntity groupUserItem);
  Future<Either<Failure, bool>> removeGroupUserRemote(String groupId, String userPhoneNumber);
}
