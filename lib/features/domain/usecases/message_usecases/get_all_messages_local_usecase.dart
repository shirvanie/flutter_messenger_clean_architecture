

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/message_entity.dart';
import 'package:messenger/features/domain/repositories/message_repository.dart';

class GetAllMessagesLocalUseCase implements UseCase<List<MessageEntity>, ParamsGetAllMessagesLocalUseCase> {
  final MessageRepository repository;

  GetAllMessagesLocalUseCase(this.repository);


  @override
  Future<Either<Failure, List<MessageEntity>>> call(ParamsGetAllMessagesLocalUseCase params) async {
    return await repository.getAllMessagesLocal(params.senderPhoneNumber, params.targetPhoneNumber);
  }
}

class ParamsGetAllMessagesLocalUseCase extends Equatable {
  final String senderPhoneNumber;
  final String targetPhoneNumber;

  const ParamsGetAllMessagesLocalUseCase({required this.senderPhoneNumber, required this.targetPhoneNumber});

  @override
  List<Object> get props => [senderPhoneNumber, targetPhoneNumber];

  @override
  String toString() {
    return 'GetAllMessagesLocalUseCase Params{senderPhoneNumber: $senderPhoneNumber, targetPhoneNumber: $targetPhoneNumber}';
  }
}
