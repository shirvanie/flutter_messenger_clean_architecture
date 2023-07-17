
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_entity.dart';
import 'package:messenger/features/domain/repositories/group_repository.dart';

class SaveGroupLocalUseCase implements UseCase<bool, ParamsSaveGroupLocalUseCase> {
  final GroupRepository repository;

  SaveGroupLocalUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsSaveGroupLocalUseCase params) async {
    return await repository.saveGroupLocal(params.groupItem);
  }
}

class ParamsSaveGroupLocalUseCase extends Equatable {
  final GroupEntity groupItem;

  const ParamsSaveGroupLocalUseCase({required this.groupItem});

  @override
  List<Object> get props => [groupItem];

  @override
  String toString() {
    return 'SaveGroupLocalUseCase Params{groupItem: $groupItem}';
  }
}
