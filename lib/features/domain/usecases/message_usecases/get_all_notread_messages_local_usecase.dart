

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/message_entity.dart';
import 'package:messenger/features/domain/repositories/message_repository.dart';

class GetAllNotReadMessagesLocalUseCase implements UseCase<List<MessageEntity>, ParamsGetAllNotReadMessagesLocalUseCase> {
  final MessageRepository repository;

  GetAllNotReadMessagesLocalUseCase(this.repository);


  @override
  Future<Either<Failure, List<MessageEntity>>> call(ParamsGetAllNotReadMessagesLocalUseCase params) async {
    return await repository.getAllNotReadMessagesLocal(params.senderPhoneNumber, params.targetPhoneNumber);
  }
}

class ParamsGetAllNotReadMessagesLocalUseCase extends Equatable {
  final String senderPhoneNumber;
  final String targetPhoneNumber;

  const ParamsGetAllNotReadMessagesLocalUseCase({required this.senderPhoneNumber, required this.targetPhoneNumber});

  @override
  List<Object> get props => [senderPhoneNumber, targetPhoneNumber];

  @override
  String toString() {
    return 'GetAllNotReadMessagesLocalUseCase Params{senderPhoneNumber: $senderPhoneNumber, targetPhoneNumber: $targetPhoneNumber}';
  }
}
