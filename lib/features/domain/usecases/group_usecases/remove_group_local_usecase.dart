

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/repositories/group_repository.dart';

class RemoveGroupLocalUseCase implements UseCase<bool, ParamsRemoveGroupLocalUseCase> {
  final GroupRepository repository;

  RemoveGroupLocalUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsRemoveGroupLocalUseCase params) async {
    return await repository.removeGroupLocal(params.groupId);
  }
}

class ParamsRemoveGroupLocalUseCase extends Equatable {
  final String groupId;

  const ParamsRemoveGroupLocalUseCase({required this.groupId});

  @override
  List<Object> get props => [groupId];

  @override
  String toString() {
    return 'RemoveGroupLocalUseCase Params{groupId: $groupId}';
  }
}
