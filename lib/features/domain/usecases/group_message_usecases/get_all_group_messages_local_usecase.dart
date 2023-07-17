



import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_message_entity.dart';
import 'package:messenger/features/domain/repositories/group_message_repository.dart';

class GetAllGroupMessagesLocalUseCase implements UseCase<List<GroupMessageEntity>, ParamsGetAllGroupMessagesLocalUseCase> {
  final GroupMessageRepository repository;

  GetAllGroupMessagesLocalUseCase(this.repository);


  @override
  Future<Either<Failure, List<GroupMessageEntity>>> call(ParamsGetAllGroupMessagesLocalUseCase params) async {
    return await repository.getAllGroupMessagesLocal(params.groupId);
  }
}

class ParamsGetAllGroupMessagesLocalUseCase extends Equatable {
  final String groupId;

  const ParamsGetAllGroupMessagesLocalUseCase({required this.groupId});

  @override
  List<Object> get props => [groupId];

  @override
  String toString() {
    return 'GetAllGroupMessagesLocalUseCase Params{groupId: $groupId}';
  }
}
