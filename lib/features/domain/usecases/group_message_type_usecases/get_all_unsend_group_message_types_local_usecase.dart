



import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_message_type_entity.dart';
import 'package:messenger/features/domain/repositories/group_message_type_repository.dart';

class GetAllUnsendGroupMessageTypesLocalUseCase implements UseCase<List<GroupMessageTypeEntity>, ParamsGetAllUnsendGroupMessageTypesLocalUseCase> {
  final GroupMessageTypeRepository repository;

  GetAllUnsendGroupMessageTypesLocalUseCase(this.repository);


  @override
  Future<Either<Failure, List<GroupMessageTypeEntity>>> call(ParamsGetAllUnsendGroupMessageTypesLocalUseCase params) async {
    return await repository.getAllUnsendGroupMessageTypesLocal(params.receiverPhoneNumber);
  }
}

class ParamsGetAllUnsendGroupMessageTypesLocalUseCase extends Equatable {
  final String receiverPhoneNumber;

  const ParamsGetAllUnsendGroupMessageTypesLocalUseCase({required this.receiverPhoneNumber});

  @override
  List<Object> get props => [receiverPhoneNumber];

  @override
  String toString() {
    return 'GetAllUnsendGroupMessageTypesLocalUseCase Params{receiverPhoneNumber: $receiverPhoneNumber}';
  }
}
