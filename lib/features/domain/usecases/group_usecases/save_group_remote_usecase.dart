
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_entity.dart';
import 'package:messenger/features/domain/repositories/group_repository.dart';

class SaveGroupRemoteUseCase implements UseCase<bool, ParamsSaveGroupRemoteUseCase> {
  final GroupRepository repository;

  SaveGroupRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsSaveGroupRemoteUseCase params) async {
    return await repository.saveGroupRemote(params.groupItem);
  }
}

class ParamsSaveGroupRemoteUseCase extends Equatable {
  final GroupEntity groupItem;

  const ParamsSaveGroupRemoteUseCase({required this.groupItem});

  @override
  List<Object> get props => [groupItem];

  @override
  String toString() {
    return 'SaveGroupRemoteUseCase Params{groupItem: $groupItem}';
  }
}
