
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/message_entity.dart';
import 'package:messenger/features/domain/repositories/message_repository.dart';

class SaveMessageLocalUseCase implements UseCase<bool, ParamsSaveMessageLocalUseCase> {
  final MessageRepository repository;

  SaveMessageLocalUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsSaveMessageLocalUseCase params) async {
    return await repository.saveMessageLocal(params.messageItem);
  }
}

class ParamsSaveMessageLocalUseCase extends Equatable {
  final MessageEntity messageItem;

  const ParamsSaveMessageLocalUseCase({required this.messageItem});

  @override
  List<Object> get props => [messageItem];

  @override
  String toString() {
    return 'SaveMessageLocalUseCase Params{messageItem: $messageItem}';
  }
}
