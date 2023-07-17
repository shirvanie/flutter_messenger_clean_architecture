


import 'package:dartz/dartz.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/features/data/models/sms_model.dart';
import 'package:messenger/features/domain/entities/user_entity.dart';


abstract class UserRepository{
  /// Local
  Future<Either<Failure, bool>> existUserLocal(String userPhoneNumber);
  Future<Either<Failure, List<UserEntity>>> getAllUsersLocal();
  Future<Either<Failure, UserEntity>> getUserLocal(String userPhoneNumber);
  Future<Either<Failure, bool>> removeUserLocal(String userPhoneNumber);
  Future<Either<Failure, bool>> saveUserLocal(UserEntity userItem);

  /// Remote
  Future<Either<Failure, List<UserEntity>>> getAllUsersRemote();
  Future<Either<Failure, UserEntity>> getUserRemote(String userPhoneNumber);
  Future<Either<Failure, bool>> saveUserRemote(UserEntity userItem);
  Future<Either<Failure, bool>> setUserLastSeenDateTimeRemote(String userPhoneNumber, String lastSeenDateTime);
  Future<Either<Failure, bool>> sendSMSVerifyCodeRemote(SMSModel smsItem);
}
