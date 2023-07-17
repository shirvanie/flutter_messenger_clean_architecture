



import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/repositories/group_message_type_repository.dart';

class ExistGroupMessageTypeLocalUseCase implements UseCase<bool, ParamsExistGroupMessageTypeLocalUseCase> {
  final GroupMessageTypeRepository repository;

  ExistGroupMessageTypeLocalUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsExistGroupMessageTypeLocalUseCase params) {
    return repository.existGroupMessageTypeLocal(params.messageId);
  }
}

class ParamsExistGroupMessageTypeLocalUseCase extends Equatable {
  final String messageId;

  const ParamsExistGroupMessageTypeLocalUseCase({required this.messageId});

  @override
  List<Object> get props => [messageId];

  @override
  String toString() {
    return 'ExistGroupMessageTypeLocalUseCase Params{messageId: $messageId}';
  }
}
