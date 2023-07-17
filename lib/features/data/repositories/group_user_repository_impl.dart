



import 'package:dartz/dartz.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/networks/network_info.dart';
import 'package:messenger/features/data/datasources/local/group_user_local_datasource.dart';
import 'package:messenger/features/data/datasources/remote/group_user_remote_datasource.dart';
import 'package:messenger/features/domain/entities/group_user_entity.dart';
import 'package:messenger/features/domain/repositories/group_user_repository.dart';

class GroupUserRepositoryImpl implements GroupUserRepository {

  final GroupUserLocalDataSource groupUserLocalDataSource;
  final GroupUserRemoteDataSource groupUserRemoteDataSource;
  final NetworkInfo networkInfo;

  GroupUserRepositoryImpl({
    required this.groupUserLocalDataSource,
    required this.groupUserRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<GroupUserEntity>>> getAllGroupUsersLocal(String groupId) async {
    try{
      final response = await groupUserLocalDataSource.getAllGroupUsersLocal(groupId);
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, GroupUserEntity>> getGroupUserLocal(String groupId, String userPhoneNumber) async {
    try{
      final response = await groupUserLocalDataSource.getGroupUserLocal(groupId, userPhoneNumber);
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> removeGroupUserLocal(String groupId, String userPhoneNumber) async {
    try{
      final response = await groupUserLocalDataSource.removeGroupUserLocal(groupId, userPhoneNumber);
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveGroupUserLocal(GroupUserEntity groupItem) async {
    try{
      final response = await groupUserLocalDataSource.saveGroupUserLocal(groupItem);
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<GroupUserEntity>>> getAllGroupUsersByPhoneNumberRemote(String userPhoneNumber) async {
    final isConnected = await networkInfo.isConnected;
    if(isConnected) {
      try{
        final result = await groupUserRemoteDataSource.getAllGroupUsersByPhoneNumberRemote(userPhoneNumber);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }


  @override
  Future<Either<Failure, List<GroupUserEntity>>> getAllGroupUsersRemote(String userPhoneNumber) async {
    final isConnected = await networkInfo.isConnected;
    if(isConnected) {
      try{
        final result = await groupUserRemoteDataSource.getAllGroupUsersRemote(userPhoneNumber);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }


  @override
  Future<Either<Failure, bool>> removeGroupUserRemote(String groupId, String userPhoneNumber) async {
    final isConnected = await networkInfo.isConnected;
    if(isConnected) {
      try{
        final result = await groupUserRemoteDataSource.removeGroupUserRemote(groupId, userPhoneNumber);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveGroupUserRemote(GroupUserEntity groupUserItem) async {
    final isConnected = await networkInfo.isConnected;
    if(isConnected) {
      try{
        final result = await groupUserRemoteDataSource.saveGroupUserRemote(groupUserItem);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

}
