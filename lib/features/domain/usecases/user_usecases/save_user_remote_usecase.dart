
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/user_entity.dart';
import 'package:messenger/features/domain/repositories/user_repository.dart';

class SaveUserRemoteUseCase implements UseCase<bool, ParamsSaveUserRemoteUseCase> {
  final UserRepository repository;

  SaveUserRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsSaveUserRemoteUseCase params) async {
    return await repository.saveUserRemote(params.userItem);
  }
}

class ParamsSaveUserRemoteUseCase extends Equatable {
  final UserEntity userItem;

  const ParamsSaveUserRemoteUseCase({required this.userItem});

  @override
  List<Object> get props => [userItem];

  @override
  String toString() {
    return 'SaveUserRemoteUseCase Params{userItem: $userItem}';
  }
}
