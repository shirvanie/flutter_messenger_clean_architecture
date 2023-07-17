
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/user_entity.dart';
import 'package:messenger/features/domain/repositories/user_repository.dart';

class SaveUserLocalUseCase implements UseCase<bool, ParamsSaveUserLocalUseCase> {
  final UserRepository repository;

  SaveUserLocalUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsSaveUserLocalUseCase params) async {
    return await repository.saveUserLocal(params.userItem);
  }
}

class ParamsSaveUserLocalUseCase extends Equatable {
  final UserEntity userItem;

  const ParamsSaveUserLocalUseCase({required this.userItem});

  @override
  List<Object> get props => [userItem];

  @override
  String toString() {
    return 'SaveUserLocalUseCase Params{userItem: $userItem}';
  }
}
