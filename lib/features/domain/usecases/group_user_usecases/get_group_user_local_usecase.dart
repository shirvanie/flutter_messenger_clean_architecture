

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_user_entity.dart';
import 'package:messenger/features/domain/repositories/group_user_repository.dart';

class GetGroupUserLocalUseCase implements UseCase<GroupUserEntity, ParamsGetGroupUserLocalUseCase> {
  final GroupUserRepository repository;

  GetGroupUserLocalUseCase(this.repository);


  @override
  Future<Either<Failure, GroupUserEntity>> call(ParamsGetGroupUserLocalUseCase params) async {
    return await repository.getGroupUserLocal(params.groupId, params.userPhoneNumber);
  }
}

class ParamsGetGroupUserLocalUseCase extends Equatable {
  final String groupId;
  final String userPhoneNumber;

  const ParamsGetGroupUserLocalUseCase({required this.groupId, required this.userPhoneNumber});

  @override
  List<Object> get props => [groupId, userPhoneNumber];

  @override
  String toString() {
    return 'GetGroupUserLocalUseCase Params{groupId: $groupId, userPhoneNumber: $userPhoneNumber}';
  }
}
