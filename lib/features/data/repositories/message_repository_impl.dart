

import 'package:dartz/dartz.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/networks/network_info.dart';
import 'package:messenger/features/data/datasources/local/message_local_datasource.dart';
import 'package:messenger/features/data/datasources/remote/message_remote_datasource.dart';
import 'package:messenger/features/domain/entities/message_entity.dart';
import 'package:messenger/features/domain/repositories/message_repository.dart';


class MessageRepositoryImpl implements MessageRepository {

  final MessageLocalDataSource messageLocalDataSource;
  final MessageRemoteDataSource messageRemoteDataSource;
  final NetworkInfo networkInfo;

  MessageRepositoryImpl({
    required this.messageLocalDataSource,
    required this.messageRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, bool>> existMessageLocal(String messageId) async {
    try{
      final response = await messageLocalDataSource.existMessageLocal(messageId);
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getAllMessagesLocal(String senderPhoneNumber, String targetPhoneNumber) async {
    try{
      final response = await messageLocalDataSource.getAllMessagesLocal(senderPhoneNumber, targetPhoneNumber);
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> removeMessageLocal(String messageId) async {
    try{
      final response = await messageLocalDataSource.removeMessageLocal(messageId);
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getAllNotReadMessagesLocal(String senderPhoneNumber, String targetPhoneNumber) async {
    try{
      final response = await messageLocalDataSource.getAllNotReadMessagesLocal(senderPhoneNumber, targetPhoneNumber);
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getAllUnsendMessagesLocal() async {
    try{
      final response = await messageLocalDataSource.getAllUnsendMessagesLocal();
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, MessageEntity>> getMessageLocal(String messageId) async {
    try{
      final response = await messageLocalDataSource.getMessageLocal(messageId);
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveMessageLocal(MessageEntity messageItem) async {
    try{
      final response = await messageLocalDataSource.saveMessageLocal(messageItem);
      return Right(response);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getAllMessagesRemote(String senderPhoneNumber, String targetPhoneNumber) async {
    final isConnected = await networkInfo.isConnected;
    if(isConnected) {
      try{
        final result = await messageRemoteDataSource.getAllMessagesRemote(senderPhoneNumber, targetPhoneNumber);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, MessageEntity>> getMessageRemote(String messageId) async {
    final isConnected = await networkInfo.isConnected;
    if(isConnected) {
      try{
        final result = await messageRemoteDataSource.getMessageRemote(messageId);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getMissedMessagesRemote(String targetPhoneNumber) async {
    final isConnected = await networkInfo.isConnected;
    if(isConnected) {
      try{
        final result = await messageRemoteDataSource.getMissedMessagesRemote(targetPhoneNumber);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }


  @override
  Future<Either<Failure, bool>> removeMessageRemote(String messageId) async {
    final isConnected = await networkInfo.isConnected;
    if(isConnected) {
      try{
        final result = await messageRemoteDataSource.removeMessageRemote(messageId);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveMessageRemote(MessageEntity messageItem) async {
    final isConnected = await networkInfo.isConnected;
    if(isConnected) {
      try{
        final result = await messageRemoteDataSource.saveMessageRemote(messageItem);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateAllMessagesRemote(List<MessageEntity> messageItems) async {
    final isConnected = await networkInfo.isConnected;
    if(isConnected) {
      try{
        final result = await messageRemoteDataSource.updateAllMessagesRemote(messageItems);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }


}
