


import 'package:dartz/dartz.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/networks/network_info.dart';
import 'package:messenger/features/data/datasources/local/group_message_type_local_datasource.dart';
import 'package:messenger/features/data/datasources/remote/group_message_type_remote_datasource.dart';
import 'package:messenger/features/domain/entities/group_message_type_entity.dart';
import 'package:messenger/features/domain/repositories/group_message_type_repository.dart';

class GroupMessageTypeRepositoryImpl implements GroupMessageTypeRepository {

  final GroupMessageTypeLocalDataSource groupMessageTypeLocalDataSource;
  final GroupMessageTypeRemoteDataSource groupMessageTypeRemoteDataSource;
  final NetworkInfo networkInfo;

  GroupMessageTypeRepositoryImpl({
    required this.groupMessageTypeLocalDataSource,
    required this.groupMessageTypeRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, bool>> existGroupMessageTypeLocal(String messageId) async {
    try{
      final response = await groupMessageTypeLocalDataSource.existGroupMessageTypeLocal(messageId);
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<GroupMessageTypeEntity>>> getAllGroupMessageTypesLocal(String groupId, String messageId) async {
    try{
      final response = await groupMessageTypeLocalDataSource.getAllGroupMessageTypesLocal(groupId, messageId);
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<GroupMessageTypeEntity>>> getAllNotReadGroupMessageTypesLocal(String groupId) async {
    try{
      final response = await groupMessageTypeLocalDataSource.getAllNotReadGroupMessageTypesLocal(groupId);
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<GroupMessageTypeEntity>>> getAllUnsendGroupMessageTypesLocal(String receiverPhoneNumber) async {
    try{
      final response = await groupMessageTypeLocalDataSource.getAllUnsendGroupMessageTypesLocal(receiverPhoneNumber);
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, GroupMessageTypeEntity>> getGroupMessageTypeLocal(String messageId) async {
    try{
      final response = await groupMessageTypeLocalDataSource.getGroupMessageTypeLocal(messageId);
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> removeGroupMessageTypeLocal(String messageId) async {
    try{
      final response = await groupMessageTypeLocalDataSource.removeGroupMessageTypeLocal(messageId);
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveGroupMessageTypeLocal(GroupMessageTypeEntity groupMessageTypeItem) async {
    try{
      final response = await groupMessageTypeLocalDataSource.saveGroupMessageTypeLocal(groupMessageTypeItem);
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> removeGroupMessageTypeRemote(String messageId) async {
    final isConnected = await networkInfo.isConnected;
    if(isConnected) {
      try{
        final result = await groupMessageTypeRemoteDataSource.removeGroupMessageTypeRemote(messageId);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<GroupMessageTypeEntity>>> getAllGroupMessageTypesRemote(String groupId, String messageId) async {
    final isConnected = await networkInfo.isConnected;
    if(isConnected) {
      try{
        final result = await groupMessageTypeRemoteDataSource.getAllGroupMessageTypesRemote(groupId, messageId);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, GroupMessageTypeEntity>> getGroupMessageTypeRemote(String messageId) async {
    final isConnected = await networkInfo.isConnected;
    if(isConnected) {
      try{
        final result = await groupMessageTypeRemoteDataSource.getGroupMessageTypeRemote(messageId);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveGroupMessageTypeRemote(GroupMessageTypeEntity groupMessageTypeItem) async {
    final isConnected = await networkInfo.isConnected;
    if(isConnected) {
      try{
        final result = await groupMessageTypeRemoteDataSource.saveGroupMessageTypeRemote(groupMessageTypeItem);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateAllGroupMessageTypesRemote(List<GroupMessageTypeEntity> groupMessageTypeItems) async {
    final isConnected = await networkInfo.isConnected;
    if(isConnected) {
      try{
        final result = await groupMessageTypeRemoteDataSource.updateAllGroupMessageTypesRemote(groupMessageTypeItems);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }


}
