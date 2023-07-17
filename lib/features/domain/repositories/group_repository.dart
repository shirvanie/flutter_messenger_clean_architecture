

import 'package:dartz/dartz.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/features/domain/entities/group_entity.dart';


abstract class GroupRepository{
  /// Local
  Future<Either<Failure, List<GroupEntity>>> getAllGroupsLocal();
  Future<Either<Failure, GroupEntity>> getGroupLocal(String groupId);
  Future<Either<Failure, bool>> removeGroupLocal(String groupId);
  Future<Either<Failure, bool>> saveGroupLocal(GroupEntity groupItem);

  /// Remote
  Future<Either<Failure, List<GroupEntity>>> getAllGroupsRemote();
  Future<Either<Failure, GroupEntity>> getGroupRemote(String groupId);
  Future<Either<Failure, bool>> saveGroupRemote(GroupEntity groupItem);
}
