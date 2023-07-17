
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_user_entity.dart';
import 'package:messenger/features/domain/repositories/group_user_repository.dart';

class SaveGroupUserLocalUseCase implements UseCase<bool, ParamsSaveGroupUserLocalUseCase> {
  final GroupUserRepository repository;

  SaveGroupUserLocalUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsSaveGroupUserLocalUseCase params) async {
    return await repository.saveGroupUserLocal(params.groupUserItem);
  }
}

class ParamsSaveGroupUserLocalUseCase extends Equatable {
  final GroupUserEntity groupUserItem;

  const ParamsSaveGroupUserLocalUseCase({required this.groupUserItem});

  @override
  List<Object> get props => [groupUserItem];

  @override
  String toString() {
    return 'SaveGroupUserLocalUseCase Params{groupUserItem: $groupUserItem}';
  }
}
