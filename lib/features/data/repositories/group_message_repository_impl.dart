

import 'package:dartz/dartz.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/networks/network_info.dart';
import 'package:messenger/features/data/datasources/local/group_message_local_datasource.dart';
import 'package:messenger/features/data/datasources/remote/group_message_remote_datasource.dart';
import 'package:messenger/features/domain/entities/group_message_entity.dart';
import 'package:messenger/features/domain/repositories/group_message_repository.dart';

class GroupMessageRepositoryImpl implements GroupMessageRepository {

  final GroupMessageLocalDataSource groupMessageLocalDataSource;
  final GroupMessageRemoteDataSource groupMessageRemoteDataSource;
  final NetworkInfo networkInfo;

  GroupMessageRepositoryImpl({
    required this.groupMessageLocalDataSource,
    required this.groupMessageRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, bool>> existGroupMessageLocal(String messageId) async {
    try{
      final response = await groupMessageLocalDataSource.existGroupMessageLocal(messageId);
      return Right(response);
    } catch(e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<GroupMessageEntity>>> getAllGroupMessagesLocal(String groupId) async {
    try{
      final response = await groupMessageLocalDataSource.getAllGroupMessagesLocal(groupId);
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<GroupMessageEntity>>> getAllUnsendGroupMessagesLocal(String senderPhoneNumber) async {
    try{
      final response = await groupMessageLocalDataSource.getAllUnsendGroupMessagesLocal(senderPhoneNumber);
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, GroupMessageEntity>> getGroupMessageLocal(String messageId) async {
    try{
      final response = await groupMessageLocalDataSource.getGroupMessageLocal(messageId);
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> removeGroupMessageLocal(String messageId) async {
    try{
      final response = await groupMessageLocalDataSource.removeGroupMessageLocal(messageId);
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveGroupMessageLocal(GroupMessageEntity groupMessageItem) async {
    try{
      final response = await groupMessageLocalDataSource.saveGroupMessageLocal(groupMessageItem);
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<GroupMessageEntity>>> getAllGroupMessagesRemote(String groupId) async {
    final isConnected = await networkInfo.isConnected;
    if(isConnected) {
      try{
        final result = await groupMessageRemoteDataSource.getAllGroupMessagesRemote(groupId);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
  @override
  Future<Either<Failure, GroupMessageEntity>> getGroupMessageRemote(String messageId) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final result = await groupMessageRemoteDataSource.getGroupMessageRemote(messageId);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<GroupMessageEntity>>> getMissedGroupMessagesRemote(String groupId, String receiverPhoneNumber) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final result = await groupMessageRemoteDataSource.getMissedGroupMessagesRemote(groupId, receiverPhoneNumber);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> removeGroupMessageRemote(String messageId) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final result = await groupMessageRemoteDataSource.removeGroupMessageRemote(messageId);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveGroupMessageRemote(GroupMessageEntity groupMessageItem) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final result = await groupMessageRemoteDataSource.saveGroupMessageRemote(groupMessageItem);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateAllGroupMessagesRemote(List<GroupMessageEntity> groupMessageItems) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final result = await groupMessageRemoteDataSource.updateAllGroupMessagesRemote(groupMessageItems);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

}
