



import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_message_entity.dart';
import 'package:messenger/features/domain/repositories/group_message_repository.dart';

class GetAllGroupMessagesRemoteUseCase implements UseCase<List<GroupMessageEntity>, ParamsGetAllGroupMessagesRemoteUseCase> {
  final GroupMessageRepository repository;

  GetAllGroupMessagesRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, List<GroupMessageEntity>>> call(ParamsGetAllGroupMessagesRemoteUseCase params) async {
    return await repository.getAllGroupMessagesRemote(params.groupId);
  }
}

class ParamsGetAllGroupMessagesRemoteUseCase extends Equatable {
  final String groupId;

  const ParamsGetAllGroupMessagesRemoteUseCase({required this.groupId});

  @override
  List<Object> get props => [groupId];

  @override
  String toString() {
    return 'GetAllGroupMessagesRemoteUseCase Params{groupId: $groupId}';
  }
}
