
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_message_entity.dart';
import 'package:messenger/features/domain/repositories/group_message_repository.dart';

class SaveGroupMessageRemoteUseCase implements UseCase<bool, ParamsSaveGroupMessageRemoteUseCase> {
  final GroupMessageRepository repository;

  SaveGroupMessageRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsSaveGroupMessageRemoteUseCase params) async {
    return await repository.saveGroupMessageRemote(params.groupMessageItem);
  }
}

class ParamsSaveGroupMessageRemoteUseCase extends Equatable {
  final GroupMessageEntity groupMessageItem;

  const ParamsSaveGroupMessageRemoteUseCase({required this.groupMessageItem});

  @override
  List<Object> get props => [groupMessageItem];

  @override
  String toString() {
    return 'SaveGroupMessageRemoteUseCase Params{groupMessageItem: $groupMessageItem}';
  }
}
