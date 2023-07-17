
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/repositories/user_repository.dart';

class RemoveUserLocalUseCase implements UseCase<bool, ParamsRemoveUserLocalUseCase> {
  final UserRepository repository;

  RemoveUserLocalUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsRemoveUserLocalUseCase params) async {
    return await repository.removeUserLocal(params.userPhoneNumber);
  }
}

class ParamsRemoveUserLocalUseCase extends Equatable {
  final String userPhoneNumber;

  const ParamsRemoveUserLocalUseCase({required this.userPhoneNumber});

  @override
  List<Object> get props => [userPhoneNumber];

  @override
  String toString() {
    return 'RemoveUserLocalUseCase Params{userPhoneNumber: $userPhoneNumber}';
  }
}
