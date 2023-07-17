



import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_message_entity.dart';
import 'package:messenger/features/domain/repositories/group_message_repository.dart';

class GetAllUnsendGroupMessagesLocalUseCase implements UseCase<List<GroupMessageEntity>, ParamsGetAllUnsendGroupMessagesLocalUseCase> {
  final GroupMessageRepository repository;

  GetAllUnsendGroupMessagesLocalUseCase(this.repository);


  @override
  Future<Either<Failure, List<GroupMessageEntity>>> call(ParamsGetAllUnsendGroupMessagesLocalUseCase params) async {
    return await repository.getAllUnsendGroupMessagesLocal(params.senderPhoneNumber);
  }
}

class ParamsGetAllUnsendGroupMessagesLocalUseCase extends Equatable {
  final String senderPhoneNumber;

  const ParamsGetAllUnsendGroupMessagesLocalUseCase({required this.senderPhoneNumber});

  @override
  List<Object> get props => [senderPhoneNumber];

  @override
  String toString() {
    return 'GetAllUnsendGroupMessagesLocalUseCase Params{senderPhoneNumber: $senderPhoneNumber}';
  }
}
