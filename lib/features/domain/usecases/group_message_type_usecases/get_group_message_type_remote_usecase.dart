





import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_message_type_entity.dart';
import 'package:messenger/features/domain/repositories/group_message_type_repository.dart';

class GetGroupMessageTypeRemoteUseCase implements UseCase<GroupMessageTypeEntity, ParamsGetGroupMessageTypeRemoteUseCase> {
  final GroupMessageTypeRepository repository;

  GetGroupMessageTypeRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, GroupMessageTypeEntity>> call(ParamsGetGroupMessageTypeRemoteUseCase params) async {
    return await repository.getGroupMessageTypeRemote(params.messageId);
  }
}

class ParamsGetGroupMessageTypeRemoteUseCase extends Equatable {
  final String messageId;

  const ParamsGetGroupMessageTypeRemoteUseCase({required this.messageId});

  @override
  List<Object> get props => [messageId];

  @override
  String toString() {
    return 'GetGroupMessageTypeRemoteUseCase Params{messageId: $messageId}';
  }
}
