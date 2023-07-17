





import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_message_type_entity.dart';
import 'package:messenger/features/domain/repositories/group_message_type_repository.dart';

class UpdateAllGroupMessageTypesRemoteUseCase implements UseCase<bool, ParamsUpdateAllGroupMessageTypesRemoteUseCase> {
  final GroupMessageTypeRepository repository;

  UpdateAllGroupMessageTypesRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsUpdateAllGroupMessageTypesRemoteUseCase params) async {
    return await repository.updateAllGroupMessageTypesRemote(params.groupMessageTypeItems);
  }
}

class ParamsUpdateAllGroupMessageTypesRemoteUseCase extends Equatable {
  final List<GroupMessageTypeEntity> groupMessageTypeItems;

  const ParamsUpdateAllGroupMessageTypesRemoteUseCase({required this.groupMessageTypeItems});

  @override
  List<Object> get props => [groupMessageTypeItems];

  @override
  String toString() {
    return 'UpdateAllGroupMessageTypeRemoteUseCase Params{messageId: $groupMessageTypeItems}';
  }
}
