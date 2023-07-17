



import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_message_type_entity.dart';
import 'package:messenger/features/domain/repositories/group_message_type_repository.dart';

class GetAllGroupMessageTypesLocalUseCase implements UseCase<List<GroupMessageTypeEntity>, ParamsGetAllGroupMessageTypesLocalUseCase> {
  final GroupMessageTypeRepository repository;

  GetAllGroupMessageTypesLocalUseCase(this.repository);


  @override
  Future<Either<Failure, List<GroupMessageTypeEntity>>> call(ParamsGetAllGroupMessageTypesLocalUseCase params) {
    return repository.getAllGroupMessageTypesLocal(params.groupId, params.messageId);
  }
}

class ParamsGetAllGroupMessageTypesLocalUseCase extends Equatable {
  final String groupId;
  final String messageId;

  const ParamsGetAllGroupMessageTypesLocalUseCase({required this.groupId, required this.messageId});

  @override
  List<Object> get props => [groupId, messageId];

  @override
  String toString() {
    return 'GetAllGroupMessageTypesLocalUseCase Params{groupId: $groupId, messageId: $messageId}';
  }
}
