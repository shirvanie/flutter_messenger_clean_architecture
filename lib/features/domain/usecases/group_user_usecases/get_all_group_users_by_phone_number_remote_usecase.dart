
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_user_entity.dart';
import 'package:messenger/features/domain/repositories/group_user_repository.dart';

class GetAllGroupUsersByPhoneNumberRemoteUseCase implements UseCase<List<GroupUserEntity>, ParamsGetAllGroupUsersByPhoneNumberRemoteUseCase> {
  final GroupUserRepository repository;

  GetAllGroupUsersByPhoneNumberRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, List<GroupUserEntity>>> call(ParamsGetAllGroupUsersByPhoneNumberRemoteUseCase params) async {
    return await repository.getAllGroupUsersByPhoneNumberRemote(params.userPhoneNumber);
  }
}

class ParamsGetAllGroupUsersByPhoneNumberRemoteUseCase extends Equatable {
  final String userPhoneNumber;

  const ParamsGetAllGroupUsersByPhoneNumberRemoteUseCase({required this.userPhoneNumber});

  @override
  List<Object> get props => [userPhoneNumber];

  @override
  String toString() {
    return 'GetAllGroupUsersByPhoneNumberRemoteUseCase Params{userPhoneNumber: $userPhoneNumber}';
  }
}
