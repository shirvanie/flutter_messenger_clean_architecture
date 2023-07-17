
import 'package:dartz/dartz.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/user_entity.dart';
import 'package:messenger/features/domain/repositories/user_repository.dart';

class GetAllUsersLocalUseCase implements UseCase<List<UserEntity>, NoParams> {
  final UserRepository repository;

  GetAllUsersLocalUseCase(this.repository);


  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParams params) async {
    return await repository.getAllUsersLocal();
  }
}
