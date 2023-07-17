
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_message_entity.dart';
import 'package:messenger/features/domain/repositories/group_message_repository.dart';

class GetMissedGroupMessagesRemoteUseCase implements UseCase<List<GroupMessageEntity>, ParamsGetMissedGroupMessagesRemoteUseCase> {
  final GroupMessageRepository repository;

  GetMissedGroupMessagesRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, List<GroupMessageEntity>>> call(ParamsGetMissedGroupMessagesRemoteUseCase params) async {
    return await repository.getMissedGroupMessagesRemote(params.groupId, params.receiverPhoneNumber);
  }
}

class ParamsGetMissedGroupMessagesRemoteUseCase extends Equatable {
  final String groupId;
  final String receiverPhoneNumber;

  const ParamsGetMissedGroupMessagesRemoteUseCase({required this.groupId, required this.receiverPhoneNumber});

  @override
  List<Object> get props => [groupId, receiverPhoneNumber];

  @override
  String toString() {
    return 'GetMissedGroupMessagesRemoteUseCase Params{groupId: $groupId, receiverPhoneNumber: $receiverPhoneNumber}';
  }
}
