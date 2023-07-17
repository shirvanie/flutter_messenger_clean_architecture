
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_user_entity.dart';
import 'package:messenger/features/domain/repositories/group_user_repository.dart';

class GetAllGroupUsersLocalUseCase implements UseCase<List<GroupUserEntity>, ParamsGetAllGroupUsersLocalUseCase> {
  final GroupUserRepository repository;

  GetAllGroupUsersLocalUseCase(this.repository);


  @override
  Future<Either<Failure, List<GroupUserEntity>>> call(ParamsGetAllGroupUsersLocalUseCase params) async {
    return await repository.getAllGroupUsersLocal(params.groupId);
  }
}

class ParamsGetAllGroupUsersLocalUseCase extends Equatable {
  final String groupId;

  const ParamsGetAllGroupUsersLocalUseCase({required this.groupId});

  @override
  List<Object> get props => [groupId];

  @override
  String toString() {
    return 'GetAllGroupUsersLocalUseCase Params{groupId: $groupId}';
  }
}
