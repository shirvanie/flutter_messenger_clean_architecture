
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_message_entity.dart';
import 'package:messenger/features/domain/repositories/group_message_repository.dart';

class GetGroupMessageRemoteUseCase implements UseCase<GroupMessageEntity, ParamsGetGroupMessageRemoteUseCase> {
  final GroupMessageRepository repository;

  GetGroupMessageRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, GroupMessageEntity>> call(ParamsGetGroupMessageRemoteUseCase params) async {
    return await repository.getGroupMessageRemote(params.messageId);
  }
}

class ParamsGetGroupMessageRemoteUseCase extends Equatable {
  final String messageId;

  const ParamsGetGroupMessageRemoteUseCase({required this.messageId});

  @override
  List<Object> get props => [messageId];

  @override
  String toString() {
    return 'GetGroupMessageRemoteUseCase Params{messageId: $messageId}';
  }
}
