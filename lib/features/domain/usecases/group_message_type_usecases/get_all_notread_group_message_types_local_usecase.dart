



import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_message_type_entity.dart';
import 'package:messenger/features/domain/repositories/group_message_type_repository.dart';

class GetAllNotReadGroupMessageTypesLocalUseCase implements UseCase<List<GroupMessageTypeEntity>, ParamsGetAllNotReadGroupMessageTypesLocalUseCase> {
  final GroupMessageTypeRepository repository;

  GetAllNotReadGroupMessageTypesLocalUseCase(this.repository);


  @override
  Future<Either<Failure, List<GroupMessageTypeEntity>>> call(ParamsGetAllNotReadGroupMessageTypesLocalUseCase params) async {
    return await repository.getAllNotReadGroupMessageTypesLocal(params.groupId);
  }
}

class ParamsGetAllNotReadGroupMessageTypesLocalUseCase extends Equatable {
  final String groupId;

  const ParamsGetAllNotReadGroupMessageTypesLocalUseCase({required this.groupId});

  @override
  List<Object> get props => [groupId];

  @override
  String toString() {
    return 'GetAllNotReadGroupMessageTypesLocalUseCase Params{groupId: $groupId}';
  }
}
