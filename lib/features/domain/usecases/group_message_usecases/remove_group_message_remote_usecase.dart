
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/repositories/group_message_repository.dart';

class RemoveGroupMessageRemoteUseCase implements UseCase<bool, ParamsRemoveGroupMessageRemoteUseCase> {
  final GroupMessageRepository repository;

  RemoveGroupMessageRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsRemoveGroupMessageRemoteUseCase params) async {
    return await repository.removeGroupMessageRemote(params.messageId);
  }
}

class ParamsRemoveGroupMessageRemoteUseCase extends Equatable {
  final String messageId;

  const ParamsRemoveGroupMessageRemoteUseCase({required this.messageId});

  @override
  List<Object> get props => [messageId];

  @override
  String toString() {
    return 'RemoveGroupMessageRemoteUseCase Params{messageId: $messageId}';
  }
}
