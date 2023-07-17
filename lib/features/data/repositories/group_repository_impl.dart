


import 'package:dartz/dartz.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/networks/network_info.dart';
import 'package:messenger/features/data/datasources/local/group_local_datasource.dart';
import 'package:messenger/features/data/datasources/remote/group_remote_datasource.dart';
import 'package:messenger/features/domain/entities/group_entity.dart';
import 'package:messenger/features/domain/repositories/group_repository.dart';

class GroupRepositoryImpl implements GroupRepository {

  final GroupLocalDataSource groupLocalDataSource;
  final GroupRemoteDataSource groupRemoteDataSource;
  final NetworkInfo networkInfo;

  GroupRepositoryImpl({
    required this.groupLocalDataSource,
    required this.groupRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<GroupEntity>>> getAllGroupsLocal() async {
    try{
      final response = await groupLocalDataSource.getAllGroupsLocal();
      return Right(response);
    } catch(e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, GroupEntity>> getGroupLocal(String userPhoneNumber) async {
    try{
      final response = await groupLocalDataSource.getGroupLocal(userPhoneNumber);
      return Right(response);
    } catch(e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveGroupLocal(GroupEntity groupItem) async {
    try{
      final response = await groupLocalDataSource.saveGroupLocal(groupItem);
      return Right(response);
    } catch(e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> removeGroupLocal(String groupId) async {
    try{
      final response = await groupLocalDataSource.removeGroupLocal(groupId);
      return Right(response);
    } catch(e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<GroupEntity>>> getAllGroupsRemote() async {
    final isConnected = await networkInfo.isConnected;
    if(isConnected) {
      try{
        final result = await groupRemoteDataSource.getAllGroupsRemote();
        return Right(result);
      } catch(e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, GroupEntity>> getGroupRemote(String groupId) async {
    final isConnected = await networkInfo.isConnected;
    if(isConnected) {
      try{
        final result = await groupRemoteDataSource.getGroupRemote(groupId);
        return Right(result);
      } catch(e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveGroupRemote(GroupEntity groupItem) async {
    final isConnected = await networkInfo.isConnected;
    if(isConnected) {
      try{
        final result = await groupRemoteDataSource.saveGroupRemote(groupItem);
        return Right(result);
      } catch(e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }


}
