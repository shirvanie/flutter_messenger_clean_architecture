
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_user_entity.dart';
import 'package:messenger/features/domain/repositories/group_user_repository.dart';

class GetAllGroupUsersRemoteUseCase implements UseCase<List<GroupUserEntity>, ParamsGetAllGroupUsersRemoteUseCase> {
  final GroupUserRepository repository;

  GetAllGroupUsersRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, List<GroupUserEntity>>> call(ParamsGetAllGroupUsersRemoteUseCase params) async {
    return await repository.getAllGroupUsersRemote(params.groupId);
  }
}

class ParamsGetAllGroupUsersRemoteUseCase extends Equatable {
  final String groupId;

  const ParamsGetAllGroupUsersRemoteUseCase({required this.groupId});

  @override
  List<Object> get props => [groupId];

  @override
  String toString() {
    return 'GetAllGroupUsersRemoteUseCase Params{groupId: $groupId}';
  }
}
