

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/repositories/group_message_repository.dart';

class RemoveGroupMessageLocalUseCase implements UseCase<bool, ParamsRemoveGroupMessageLocalUseCase> {
  final GroupMessageRepository repository;

  RemoveGroupMessageLocalUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsRemoveGroupMessageLocalUseCase params) async {
    return await repository.removeGroupMessageLocal(params.messageId);
  }
}

class ParamsRemoveGroupMessageLocalUseCase extends Equatable {
  final String messageId;

  const ParamsRemoveGroupMessageLocalUseCase({required this.messageId});

  @override
  List<Object> get props => [messageId];

  @override
  String toString() {
    return 'RemoveGroupMessageLocalUseCase Params{messageId: $messageId}';
  }
}
