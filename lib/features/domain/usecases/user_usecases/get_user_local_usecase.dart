


import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/user_entity.dart';
import 'package:messenger/features/domain/repositories/user_repository.dart';

class GetUserLocalUseCase implements UseCase<UserEntity, ParamsGetUserLocalUseCase> {
  final UserRepository repository;

  GetUserLocalUseCase(this.repository);


  @override
  Future<Either<Failure, UserEntity>> call(ParamsGetUserLocalUseCase params) async {
    return await repository.getUserLocal(params.userPhoneNumber);
  }
}

class ParamsGetUserLocalUseCase extends Equatable {
  final String userPhoneNumber;

  const ParamsGetUserLocalUseCase({required this.userPhoneNumber});

  @override
  List<Object> get props => [userPhoneNumber];

  @override
  String toString() {
    return 'GetUserLocalUseCase Params{userPhoneNumber: $userPhoneNumber}';
  }
}
