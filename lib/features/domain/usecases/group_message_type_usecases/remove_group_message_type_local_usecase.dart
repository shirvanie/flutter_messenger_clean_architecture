

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/repositories/group_message_type_repository.dart';

class RemoveGroupMessageTypeLocalUseCase implements UseCase<bool, ParamsRemoveGroupMessageTypeLocalUseCase> {
  final GroupMessageTypeRepository repository;

  RemoveGroupMessageTypeLocalUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsRemoveGroupMessageTypeLocalUseCase params) async {
    return await repository.removeGroupMessageTypeLocal(params.messageId);
  }
}

class ParamsRemoveGroupMessageTypeLocalUseCase extends Equatable {
  final String messageId;

  const ParamsRemoveGroupMessageTypeLocalUseCase({required this.messageId});

  @override
  List<Object> get props => [messageId];

  @override
  String toString() {
    return 'RemoveGroupMessageTypeLocalUseCase Params{messageId: $messageId}';
  }
}
