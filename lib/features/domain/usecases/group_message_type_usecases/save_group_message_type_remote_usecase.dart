





import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_message_type_entity.dart';
import 'package:messenger/features/domain/repositories/group_message_type_repository.dart';

class SaveGroupMessageTypeRemoteUseCase implements UseCase<bool, ParamsSaveGroupMessageTypeRemoteUseCase> {
  final GroupMessageTypeRepository repository;

  SaveGroupMessageTypeRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsSaveGroupMessageTypeRemoteUseCase params) async {
    return await repository.saveGroupMessageTypeRemote(params.groupMessageTypeItem);
  }
}

class ParamsSaveGroupMessageTypeRemoteUseCase extends Equatable {
  final GroupMessageTypeEntity groupMessageTypeItem;

  const ParamsSaveGroupMessageTypeRemoteUseCase({required this.groupMessageTypeItem});

  @override
  List<Object> get props => [groupMessageTypeItem];

  @override
  String toString() {
    return 'SaveGroupMessageTypeRemoteUseCase Params{messageId: $groupMessageTypeItem}';
  }
}
