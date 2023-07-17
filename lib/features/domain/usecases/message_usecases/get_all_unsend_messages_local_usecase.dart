

import 'package:dartz/dartz.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/message_entity.dart';
import 'package:messenger/features/domain/repositories/message_repository.dart';

class GetAllUnsendMessagesLocalUseCase implements UseCase<List<MessageEntity>, NoParams> {
  final MessageRepository repository;

  GetAllUnsendMessagesLocalUseCase(this.repository);


  @override
  Future<Either<Failure, List<MessageEntity>>> call(NoParams params) async {
    return await repository.getAllUnsendMessagesLocal();
  }
}
