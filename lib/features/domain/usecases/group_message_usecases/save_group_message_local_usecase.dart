

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_message_entity.dart';
import 'package:messenger/features/domain/repositories/group_message_repository.dart';

class SaveGroupMessageLocalUseCase implements UseCase<bool, ParamsSaveGroupMessageLocalUseCase> {
  final GroupMessageRepository repository;

  SaveGroupMessageLocalUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsSaveGroupMessageLocalUseCase params) async {
    return await repository.saveGroupMessageLocal(params.groupMessageItem);
  }
}

class ParamsSaveGroupMessageLocalUseCase extends Equatable {
  final GroupMessageEntity groupMessageItem;

  const ParamsSaveGroupMessageLocalUseCase({required this.groupMessageItem});

  @override
  List<Object> get props => [groupMessageItem];

  @override
  String toString() {
    return 'SaveGroupMessageLocalUseCase Params{groupMessageItem: $groupMessageItem}';
  }
}
