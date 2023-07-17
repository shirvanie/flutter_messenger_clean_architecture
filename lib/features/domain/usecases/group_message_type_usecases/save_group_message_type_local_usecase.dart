





import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_message_type_entity.dart';
import 'package:messenger/features/domain/repositories/group_message_type_repository.dart';

class SaveGroupMessageTypeLocalUseCase implements UseCase<bool, ParamsSaveGroupMessageTypeLocalUseCase> {
  final GroupMessageTypeRepository repository;

  SaveGroupMessageTypeLocalUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsSaveGroupMessageTypeLocalUseCase params) async {
    return await repository.saveGroupMessageTypeLocal(params.groupMessageTypeItem);
  }
}

class ParamsSaveGroupMessageTypeLocalUseCase extends Equatable {
  final GroupMessageTypeEntity groupMessageTypeItem;

  const ParamsSaveGroupMessageTypeLocalUseCase({required this.groupMessageTypeItem});

  @override
  List<Object> get props => [groupMessageTypeItem];

  @override
  String toString() {
    return 'SaveGroupMessageTypeLocalUseCase Params{messageId: $groupMessageTypeItem}';
  }
}
