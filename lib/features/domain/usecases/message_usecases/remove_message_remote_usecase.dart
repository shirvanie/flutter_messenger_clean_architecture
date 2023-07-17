
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/repositories/message_repository.dart';

class RemoveMessageRemoteUseCase implements UseCase<bool, ParamsRemoveMessageRemoteUseCase> {
  final MessageRepository repository;

  RemoveMessageRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsRemoveMessageRemoteUseCase params) async {
    return await repository.removeMessageRemote(params.messageId);
  }
}

class ParamsRemoveMessageRemoteUseCase extends Equatable {
  final String messageId;

  const ParamsRemoveMessageRemoteUseCase({required this.messageId});

  @override
  List<Object> get props => [messageId];

  @override
  String toString() {
    return 'RemoveMessageRemoteUseCase Params{messageId: $messageId}';
  }
}
