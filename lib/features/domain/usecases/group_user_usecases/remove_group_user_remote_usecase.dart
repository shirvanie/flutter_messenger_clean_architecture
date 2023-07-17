
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/repositories/group_user_repository.dart';

class RemoveGroupUserRemoteUseCase implements UseCase<bool, ParamsRemoveGroupUserRemoteUseCase> {
  final GroupUserRepository repository;

  RemoveGroupUserRemoteUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(ParamsRemoveGroupUserRemoteUseCase params) async {
    return await repository.removeGroupUserRemote(params.groupId, params.userPhoneNumber);
  }
}

class ParamsRemoveGroupUserRemoteUseCase extends Equatable {
  final String groupId;
  final String userPhoneNumber;

  const ParamsRemoveGroupUserRemoteUseCase({required this.groupId, required this.userPhoneNumber});

  @override
  List<Object> get props => [groupId, userPhoneNumber];

  @override
  String toString() {
    return 'RemoveGroupUserRemoteUseCase Params{groupId: $groupId, userPhoneNumber: $userPhoneNumber}';
  }
}
