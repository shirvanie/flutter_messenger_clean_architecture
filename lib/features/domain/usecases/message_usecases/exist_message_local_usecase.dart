

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/repositories/message_repository.dart';

class ExistMessageLocalUseCase implements UseCase<bool, ParamsExistMessageLocalUseCase> {
  final MessageRepository repository;

  ExistMessageLocalUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsExistMessageLocalUseCase params) async {
    return await repository.existMessageLocal(params.messageId);
  }
}

class ParamsExistMessageLocalUseCase extends Equatable {
  final String messageId;

  const ParamsExistMessageLocalUseCase({required this.messageId});

  @override
  List<Object> get props => [messageId];

  @override
  String toString() {
    return 'ExistMessageLocalUseCase Params{messageId: $messageId}';
  }
}
