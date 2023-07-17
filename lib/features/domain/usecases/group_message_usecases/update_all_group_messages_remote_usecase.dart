
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_message_entity.dart';
import 'package:messenger/features/domain/repositories/group_message_repository.dart';

class UpdateAllGroupMessagesRemoteUseCase implements UseCase<bool, ParamsUpdateAllGroupMessagesRemoteUseCase> {
  final GroupMessageRepository repository;

  UpdateAllGroupMessagesRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsUpdateAllGroupMessagesRemoteUseCase params) async {
    return await repository.updateAllGroupMessagesRemote(params.groupMessageItems);
  }
}

class ParamsUpdateAllGroupMessagesRemoteUseCase extends Equatable {
  final List<GroupMessageEntity> groupMessageItems;

  const ParamsUpdateAllGroupMessagesRemoteUseCase({required this.groupMessageItems});

  @override
  List<Object> get props => [groupMessageItems];

  @override
  String toString() {
    return 'UpdateAllGroupMessagesRemoteUseCase Params{groupMessageItems: $groupMessageItems}';
  }
}
