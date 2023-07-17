



import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_message_type_entity.dart';
import 'package:messenger/features/domain/repositories/group_message_type_repository.dart';

class GetAllGroupMessageTypesRemoteUseCase implements UseCase<List<GroupMessageTypeEntity>, ParamsGetAllGroupMessageTypesRemoteUseCase> {
  final GroupMessageTypeRepository repository;

  GetAllGroupMessageTypesRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, List<GroupMessageTypeEntity>>> call(ParamsGetAllGroupMessageTypesRemoteUseCase params) async{
    return await repository.getAllGroupMessageTypesRemote(params.groupId, params.messageId);
  }
}

class ParamsGetAllGroupMessageTypesRemoteUseCase extends Equatable {
  final String groupId;
  final String messageId;

  const ParamsGetAllGroupMessageTypesRemoteUseCase({required this.groupId, required this.messageId});

  @override
  List<Object> get props => [groupId, messageId];

  @override
  String toString() {
    return 'GetAllGroupMessageTypesRemoteUseCase Params{groupId: $groupId, messageId: $messageId}';
  }
}
