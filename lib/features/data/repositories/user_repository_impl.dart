
import 'package:dartz/dartz.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/networks/network_info.dart';
import 'package:messenger/features/data/datasources/local/user_local_datasource.dart';
import 'package:messenger/features/data/datasources/remote/user_remote_datasource.dart';
import 'package:messenger/features/data/models/sms_model.dart';
import 'package:messenger/features/data/models/user_model.dart';
import 'package:messenger/features/domain/entities/user_entity.dart';
import 'package:messenger/features/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {

  final UserLocalDataSource userLocalDataSource;
  final UserRemoteDataSource userRemoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.userLocalDataSource,
    required this.userRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, bool>> existUserLocal(String userPhoneNumber) async {
   try{
     final response = await userLocalDataSource.existUserLocal(userPhoneNumber);
     return Right(response);
   } on DatabaseException {
     return Left(DatabaseFailure());
   }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsersLocal() async {
    try{
      final response = await userLocalDataSource.getAllUsersLocal();
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserLocal(String userPhoneNumber) async {
    try{
      final response = await userLocalDataSource.getUserLocal(userPhoneNumber);
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }


  @override
  Future<Either<Failure, bool>> removeUserLocal(String userPhoneNumber) async {
    try{
      final response = await userLocalDataSource.removeUserLocal(userPhoneNumber);
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveUserLocal(UserEntity userItem) async {
    try{
      final response = await userLocalDataSource.saveUserLocal(userItem);
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsersRemote() async {
    final isConnected = await networkInfo.isConnected;
    if(isConnected) {
      try{
        final result = await userRemoteDataSource.getAllUsersRemote();
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }

  }

  @override
  Future<Either<Failure, UserEntity>> getUserRemote(String userPhoneNumber) async {
    final isConnected = await networkInfo.isConnected;
    if(isConnected) {
      try{
        final result = await userRemoteDataSource.getUserRemote(userPhoneNumber);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveUserRemote(UserEntity userItem) async {
    final isConnected = await networkInfo.isConnected;
    if(isConnected) {
      try{
        final result = await userRemoteDataSource.saveUserRemote(userItem as UserModel);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> sendSMSVerifyCodeRemote(SMSModel smsItem) async {
    final isConnected = await networkInfo.isConnected;
    if(isConnected) {
      try{
        final result = await userRemoteDataSource.sendSMSVerifyCodeRemote(smsItem);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> setUserLastSeenDateTimeRemote(String userPhoneNumber, String lastSeenDateTime) async {
    final isConnected = await networkInfo.isConnected;
    if(isConnected) {
      try{
        final result = await userRemoteDataSource.setUserLastSeenDateTimeRemote(userPhoneNumber, lastSeenDateTime);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

}
