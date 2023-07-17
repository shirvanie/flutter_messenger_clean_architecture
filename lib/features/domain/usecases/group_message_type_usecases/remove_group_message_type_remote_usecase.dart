





import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/repositories/group_message_type_repository.dart';

class RemoveGroupMessageTypeRemoteUseCase implements UseCase<bool, ParamsRemoveGroupMessageTypeRemoteUseCase> {
  final GroupMessageTypeRepository repository;

  RemoveGroupMessageTypeRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsRemoveGroupMessageTypeRemoteUseCase params) async {
    return await repository.removeGroupMessageTypeRemote(params.messageId);
  }
}

class ParamsRemoveGroupMessageTypeRemoteUseCase extends Equatable {
  final String messageId;

  const ParamsRemoveGroupMessageTypeRemoteUseCase({required this.messageId});

  @override
  List<Object> get props => [messageId];

  @override
  String toString() {
    return 'RemoveGroupMessageTypeRemoteUseCase Params{messageId: $messageId}';
  }
}
