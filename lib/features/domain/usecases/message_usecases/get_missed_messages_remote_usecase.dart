

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/message_entity.dart';
import 'package:messenger/features/domain/repositories/message_repository.dart';

class GetMissedMessagesRemoteUseCase implements UseCase<List<MessageEntity>, ParamsGetMissedMessagesRemoteUseCase> {
  final MessageRepository repository;

  GetMissedMessagesRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, List<MessageEntity>>> call(ParamsGetMissedMessagesRemoteUseCase params) async {
    return await repository.getMissedMessagesRemote(params.targetPhoneNumber);
  }
}

class ParamsGetMissedMessagesRemoteUseCase extends Equatable {
  final String targetPhoneNumber;

  const ParamsGetMissedMessagesRemoteUseCase({required this.targetPhoneNumber});

  @override
  List<Object> get props => [targetPhoneNumber];

  @override
  String toString() {
    return 'GetMissedMessagesRemoteUseCase Params{targetPhoneNumber: $targetPhoneNumber}';
  }
}
