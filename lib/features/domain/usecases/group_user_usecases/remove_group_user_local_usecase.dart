
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/repositories/group_user_repository.dart';

class RemoveGroupUserLocalUseCase implements UseCase<bool, ParamsRemoveGroupUserLocalUseCase> {
  final GroupUserRepository repository;

  RemoveGroupUserLocalUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsRemoveGroupUserLocalUseCase params) async {
    return await repository.removeGroupUserLocal(params.groupId, params.userPhoneNumber);
  }
}

class ParamsRemoveGroupUserLocalUseCase extends Equatable {
  final String groupId;
  final String userPhoneNumber;

  const ParamsRemoveGroupUserLocalUseCase({required this.groupId, required this.userPhoneNumber});

  @override
  List<Object> get props => [groupId, groupId];

  @override
  String toString() {
    return 'RemoveGroupUserLocalUseCase Params{groupId: $groupId, userPhoneNumber: $userPhoneNumber}';
  }
}
