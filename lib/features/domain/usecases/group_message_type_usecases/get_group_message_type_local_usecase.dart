





import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_message_type_entity.dart';
import 'package:messenger/features/domain/repositories/group_message_type_repository.dart';

class GetGroupMessageTypeLocalUseCase implements UseCase<GroupMessageTypeEntity, ParamsGetGroupMessageTypeLocalUseCase> {
  final GroupMessageTypeRepository repository;

  GetGroupMessageTypeLocalUseCase(this.repository);


  @override
  Future<Either<Failure, GroupMessageTypeEntity>> call(ParamsGetGroupMessageTypeLocalUseCase params) async {
    return await repository.getGroupMessageTypeLocal(params.messageId);
  }
}

class ParamsGetGroupMessageTypeLocalUseCase extends Equatable {
  final String messageId;

  const ParamsGetGroupMessageTypeLocalUseCase({required this.messageId});

  @override
  List<Object> get props => [messageId];

  @override
  String toString() {
    return 'GetGroupMessageTypeLocalUseCase Params{messageId: $messageId}';
  }
}
