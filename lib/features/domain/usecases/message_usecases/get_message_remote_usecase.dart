

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/message_entity.dart';
import 'package:messenger/features/domain/repositories/message_repository.dart';

class GetMessageRemoteUseCase implements UseCase<MessageEntity, ParamsGetMessageRemoteUseCase> {
  final MessageRepository repository;

  GetMessageRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, MessageEntity>> call(ParamsGetMessageRemoteUseCase params) async {
    return await repository.getMessageRemote(params.messageId);
  }
}

class ParamsGetMessageRemoteUseCase extends Equatable {
  final String messageId;

  const ParamsGetMessageRemoteUseCase({required this.messageId});

  @override
  List<Object> get props => [messageId];

  @override
  String toString() {
    return 'GetMessageRemoteUseCase Params{messageId: $messageId}';
  }
}
