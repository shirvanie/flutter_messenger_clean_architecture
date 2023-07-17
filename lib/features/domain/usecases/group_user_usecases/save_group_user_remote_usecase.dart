

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_user_entity.dart';
import 'package:messenger/features/domain/repositories/group_user_repository.dart';

class SaveGroupUserRemoteUseCase implements UseCase<bool, ParamsSaveGroupUserRemoteUseCase> {
  final GroupUserRepository repository;

  SaveGroupUserRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsSaveGroupUserRemoteUseCase params) async {
    return await repository.saveGroupUserRemote(params.groupUserItem);
  }
}

class ParamsSaveGroupUserRemoteUseCase extends Equatable {
  final GroupUserEntity groupUserItem;

  const ParamsSaveGroupUserRemoteUseCase({required this.groupUserItem});

  @override
  List<Object> get props => [groupUserItem];

  @override
  String toString() {
    return 'SaveGroupUserRemoteUseCase Params{groupUserItem: $groupUserItem}';
  }
}
