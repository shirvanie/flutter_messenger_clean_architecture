
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_entity.dart';
import 'package:messenger/features/domain/repositories/group_repository.dart';

class GetGroupLocalUseCase implements UseCase<GroupEntity, ParamsGetGroupLocalUseCase> {
  final GroupRepository repository;

  GetGroupLocalUseCase(this.repository);


  @override
  Future<Either<Failure, GroupEntity>> call(ParamsGetGroupLocalUseCase params) async {
    return await repository.getGroupLocal(params.groupId);
  }
}

class ParamsGetGroupLocalUseCase extends Equatable {
  final String groupId;

  const ParamsGetGroupLocalUseCase({required this.groupId});

  @override
  List<Object> get props => [groupId];

  @override
  String toString() {
    return 'GetGroupLocalUseCase Params{groupId: $groupId}';
  }
}
