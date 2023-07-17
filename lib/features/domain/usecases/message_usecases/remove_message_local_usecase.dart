
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/repositories/message_repository.dart';

class RemoveMessageLocalUseCase implements UseCase<bool, ParamsRemoveMessageLocalUseCase> {
  final MessageRepository repository;

  RemoveMessageLocalUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsRemoveMessageLocalUseCase params) async {
    return await repository.removeMessageLocal(params.messageId);
  }
}

class ParamsRemoveMessageLocalUseCase extends Equatable {
  final String messageId;

  const ParamsRemoveMessageLocalUseCase({required this.messageId});

  @override
  List<Object> get props => [messageId];

  @override
  String toString() {
    return 'RemoveMessageLocalUseCase Params{messageId: $messageId}';
  }
}
