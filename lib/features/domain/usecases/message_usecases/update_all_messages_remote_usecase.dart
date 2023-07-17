
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/message_entity.dart';
import 'package:messenger/features/domain/repositories/message_repository.dart';

class UpdateAllMessagesRemoteUseCase implements UseCase<bool, ParamsUpdateAllMessagesRemoteUseCase> {
  final MessageRepository repository;

  UpdateAllMessagesRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsUpdateAllMessagesRemoteUseCase params) async {
    return await repository.updateAllMessagesRemote(params.messageItems);
  }
}

class ParamsUpdateAllMessagesRemoteUseCase extends Equatable {
  final List<MessageEntity> messageItems;

  const ParamsUpdateAllMessagesRemoteUseCase({required this.messageItems});

  @override
  List<Object> get props => [messageItems];

  @override
  String toString() {
    return 'UpdateAllMessagesRemoteUseCase Params{messageItems: $messageItems}';
  }
}
