
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_message_entity.dart';
import 'package:messenger/features/domain/repositories/group_message_repository.dart';

class GetGroupMessageLocalUseCase implements UseCase<GroupMessageEntity, ParamsGetGroupMessageLocalUseCase> {
  final GroupMessageRepository repository;

  GetGroupMessageLocalUseCase(this.repository);


  @override
  Future<Either<Failure, GroupMessageEntity>> call(ParamsGetGroupMessageLocalUseCase params) async {
    return await repository.getGroupMessageLocal(params.messageId);
  }
}

class ParamsGetGroupMessageLocalUseCase extends Equatable {
  final String messageId;

  const ParamsGetGroupMessageLocalUseCase({required this.messageId});

  @override
  List<Object> get props => [messageId];

  @override
  String toString() {
    return 'GetGroupMessageLocalUseCase Params{messageId: $messageId}';
  }
}
