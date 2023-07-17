
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/message_entity.dart';
import 'package:messenger/features/domain/repositories/message_repository.dart';

class SaveMessageRemoteUseCase implements UseCase<bool, ParamsSaveMessageRemoteUseCase> {
  final MessageRepository repository;

  SaveMessageRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsSaveMessageRemoteUseCase params) async {
    return await repository.saveMessageRemote(params.messageItem);
  }
}

class ParamsSaveMessageRemoteUseCase extends Equatable {
  final MessageEntity messageItem;

  const ParamsSaveMessageRemoteUseCase({required this.messageItem});

  @override
  List<Object> get props => [messageItem];

  @override
  String toString() {
    return 'SaveMessageRemoteUseCase Params{messageItem: $messageItem}';
  }
}
