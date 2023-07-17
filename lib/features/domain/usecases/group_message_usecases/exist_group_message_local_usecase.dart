



import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/repositories/group_message_repository.dart';

class ExistGroupMessageLocalUseCase implements UseCase<bool, ParamsExistGroupMessageLocalUseCase> {
  final GroupMessageRepository repository;

  ExistGroupMessageLocalUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsExistGroupMessageLocalUseCase params) async {
    return await repository.existGroupMessageLocal(params.messageId);
  }
}

class ParamsExistGroupMessageLocalUseCase extends Equatable {
  final String messageId;

  const ParamsExistGroupMessageLocalUseCase({required this.messageId});

  @override
  List<Object> get props => [messageId];

  @override
  String toString() {
    return 'ExistGroupMessageLocalUseCase Params{messageId: $messageId}';
  }
}
