
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/user_entity.dart';
import 'package:messenger/features/domain/repositories/user_repository.dart';

class GetUserRemoteUseCase implements UseCase<UserEntity, ParamsGetUserRemoteUseCase> {
  final UserRepository repository;

  GetUserRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, UserEntity>> call(ParamsGetUserRemoteUseCase params) async {
    return await repository.getUserRemote(params.userPhoneNumber);
  }
}

class ParamsGetUserRemoteUseCase extends Equatable {
  final String userPhoneNumber;

  const ParamsGetUserRemoteUseCase({required this.userPhoneNumber});

  @override
  List<Object> get props => [userPhoneNumber];

  @override
  String toString() {
    return 'GetUserRemoteUseCase Params{userPhoneNumber: $userPhoneNumber}';
  }
}
