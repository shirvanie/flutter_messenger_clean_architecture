
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/repositories/user_repository.dart';

class ExistUserLocalUseCase implements UseCase<bool, ParamsExistUserLocalUseCase> {
  final UserRepository repository;

  ExistUserLocalUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsExistUserLocalUseCase params) async {
    return await repository.existUserLocal(params.userPhoneNumber);
  }
}

class ParamsExistUserLocalUseCase extends Equatable {
  final String userPhoneNumber;

  const ParamsExistUserLocalUseCase({required this.userPhoneNumber});

  @override
  List<Object> get props => [userPhoneNumber];

  @override
  String toString() {
    return 'ExistUserLocalUseCase Params{userPhoneNumber: $userPhoneNumber}';
  }
}
