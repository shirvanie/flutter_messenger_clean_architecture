
import 'package:dartz/dartz.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_entity.dart';
import 'package:messenger/features/domain/repositories/group_repository.dart';

class GetAllGroupsRemoteUseCase implements UseCase<List<GroupEntity>, NoParams> {
  final GroupRepository repository;

  GetAllGroupsRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, List<GroupEntity>>> call(NoParams params) async {
    return await repository.getAllGroupsRemote();
  }
}
