

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/message_entity.dart';
import 'package:messenger/features/domain/repositories/message_repository.dart';

class GetMessageLocalUseCase implements UseCase<MessageEntity, ParamsGetMessageLocalUseCase> {
  final MessageRepository repository;

  GetMessageLocalUseCase(this.repository);


  @override
  Future<Either<Failure, MessageEntity>> call(ParamsGetMessageLocalUseCase params) async {
    return await repository.getMessageLocal(params.messageId);
  }
}

class ParamsGetMessageLocalUseCase extends Equatable {
  final String messageId;

  const ParamsGetMessageLocalUseCase({required this.messageId});

  @override
  List<Object> get props => [messageId];

  @override
  String toString() {
    return 'GetMessageLocalUseCase Params{messageId: $messageId}';
  }
}
