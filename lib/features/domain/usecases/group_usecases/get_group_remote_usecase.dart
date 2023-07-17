

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_entity.dart';
import 'package:messenger/features/domain/repositories/group_repository.dart';

class GetGroupRemoteUseCase implements UseCase<GroupEntity, ParamsGetGroupRemoteUseCase> {
  final GroupRepository repository;

  GetGroupRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, GroupEntity>> call(ParamsGetGroupRemoteUseCase params) async {
    return await repository.getGroupRemote(params.groupId);
  }
}

class ParamsGetGroupRemoteUseCase extends Equatable {
  final String groupId;

  const ParamsGetGroupRemoteUseCase({required this.groupId});

  @override
  List<Object> get props => [groupId];

  @override
  String toString() {
    return 'GetGroupRemoteUseCase Params{groupId: $groupId}';
  }
}
