
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/repositories/user_repository.dart';

class SetUserLastSeenDateTimeRemoteUseCase implements UseCase<bool, ParamsSetUserLastSeenDateTimeRemoteUseCase> {
  final UserRepository repository;

  SetUserLastSeenDateTimeRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsSetUserLastSeenDateTimeRemoteUseCase params) async {
    return await repository.setUserLastSeenDateTimeRemote(params.userPhoneNumber, params.lastSeenDateTime);
  }
}

class ParamsSetUserLastSeenDateTimeRemoteUseCase extends Equatable {
  final String userPhoneNumber;
  final String lastSeenDateTime;

  const ParamsSetUserLastSeenDateTimeRemoteUseCase({required this.userPhoneNumber, required this.lastSeenDateTime});

  @override
  List<Object> get props => [userPhoneNumber, lastSeenDateTime];

  @override
  String toString() {
    return 'SetUserLastSeenDateTimeRemoteUseCase Params{userPhoneNumber: $userPhoneNumber, lastSeenDateTime: $lastSeenDateTime}';
  }
}
