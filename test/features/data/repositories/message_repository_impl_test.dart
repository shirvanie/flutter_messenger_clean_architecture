


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/features/data/models/message_model.dart';
import 'package:messenger/features/data/repositories/message_repository_impl.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMessageLocalDataSource mockMessageLocalDataSource;
  late MockMessageRemoteDataSource mockMessageRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MessageRepositoryImpl messageRepositoryImpl;

  final testJson = fixtureReader("message_model.json");
  final testMessageModel = MessageModel.fromJson(json.decode(testJson));
  String messageId = testMessageModel.messageId.toString();
  String senderPhoneNumber = testMessageModel.senderPhoneNumber.toString();
  String targetPhoneNumber = testMessageModel.targetPhoneNumber.toString();

  setUp(() {
    mockMessageLocalDataSource = MockMessageLocalDataSource();
    mockMessageRemoteDataSource = MockMessageRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    messageRepositoryImpl = MessageRepositoryImpl(
        messageLocalDataSource: mockMessageLocalDataSource,
        messageRemoteDataSource: mockMessageRemoteDataSource,
        networkInfo: mockNetworkInfo);
  });

  void runTestsOnline(Function body) {
    group("device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group("device is offline", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group("MessageRemoteDataSource", () {
    group("getAllMessagesRemote", () {
      runTestsOnline(() {
        test(
            "should return all Messages when call to remote datasource is success", () async {
          //arrange
          when(mockMessageRemoteDataSource.getAllMessagesRemote(any, any))
              .thenAnswer((_) async => [testMessageModel]);
          //act
          final result = await messageRepositoryImpl.getAllMessagesRemote(senderPhoneNumber, targetPhoneNumber);
          //assert
          verify(mockMessageRemoteDataSource.getAllMessagesRemote(senderPhoneNumber, targetPhoneNumber));
          expect(result.getOrElse(() => []), [testMessageModel]);
        });
        test("should return ServerFailure when getAllMessages and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockMessageRemoteDataSource.getAllMessagesRemote(any, any))
              .thenThrow(ServerException());
          //act
          final result = await messageRepositoryImpl.getAllMessagesRemote(senderPhoneNumber, targetPhoneNumber);
          //assert
          verify(mockMessageRemoteDataSource.getAllMessagesRemote(senderPhoneNumber, targetPhoneNumber));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockMessageRemoteDataSource.getAllMessagesRemote(any, any))
              .thenThrow(ConnectionException());
          //act
          final result = await messageRepositoryImpl.getAllMessagesRemote(senderPhoneNumber, targetPhoneNumber);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });

    group("getMessageRemote", () {
      runTestsOnline(() {
        test("should return a Message model when call to remote datasource is success", () async {
          //arrange
          when(mockMessageRemoteDataSource.getMessageRemote(any))
              .thenAnswer((_) async => testMessageModel);
          //act
          final result = await messageRepositoryImpl.getMessageRemote(messageId);
          //assert
          verify(mockMessageRemoteDataSource.getMessageRemote(messageId));
          expect(result, Right(testMessageModel));
        });

        test("should return ServerFailure when getMessage and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockMessageRemoteDataSource.getMessageRemote(any))
              .thenThrow(ServerException());
          //act
          final result = await messageRepositoryImpl.getMessageRemote(messageId);
          //assert
          verify(mockMessageRemoteDataSource.getMessageRemote(messageId));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockMessageRemoteDataSource.getMessageRemote(any))
              .thenThrow(ConnectionException());
          //act
          final result = await messageRepositoryImpl.getMessageRemote(messageId);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });

    group("getMissedMessagesRemote", () {
      runTestsOnline(() {
        test(
            "should return all MissedMessages when call to remote datasource is success", () async {
          //arrange
          when(mockMessageRemoteDataSource.getMissedMessagesRemote(any))
              .thenAnswer((_) async => [testMessageModel]);
          //act
          final result = await messageRepositoryImpl.getMissedMessagesRemote(targetPhoneNumber);
          //assert
          verify(mockMessageRemoteDataSource.getMissedMessagesRemote(targetPhoneNumber));
          expect(result.getOrElse(() => []), [testMessageModel]);
        });
        test("should return ServerFailure when geMissedMessages and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockMessageRemoteDataSource.getMissedMessagesRemote(any))
              .thenThrow(ServerException());
          //act
          final result = await messageRepositoryImpl.getMissedMessagesRemote(targetPhoneNumber);
          //assert
          verify(mockMessageRemoteDataSource.getMissedMessagesRemote(targetPhoneNumber));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockMessageRemoteDataSource.getMissedMessagesRemote(any))
              .thenThrow(ConnectionException());
          //act
          final result = await messageRepositoryImpl.getMissedMessagesRemote(targetPhoneNumber);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });

    group("removeMessageRemote", () {
      runTestsOnline(() {
        test("should return true when removeMessage and call to remote datasource is success", () async {
          //arrange
          when(mockMessageRemoteDataSource.removeMessageRemote(any))
              .thenAnswer((_) async => true);
          //act
          final result = await messageRepositoryImpl.removeMessageRemote(messageId);
          //assert
          verify(mockMessageRemoteDataSource.removeMessageRemote(messageId));
          expect(result, const Right(true));
        });

        test("should return ServerFailure when removeMessage and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockMessageRemoteDataSource.removeMessageRemote(any))
              .thenThrow(ServerException());
          //act
          final result = await messageRepositoryImpl.removeMessageRemote(messageId);
          //assert
          verify(mockMessageRemoteDataSource.removeMessageRemote(messageId));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockMessageRemoteDataSource.removeMessageRemote(any))
              .thenThrow(ConnectionException());
          //act
          final result = await messageRepositoryImpl.removeMessageRemote(messageId);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });

    group("saveMessageRemote", () {
      runTestsOnline(() {
        test("should return true when saveMessage and call to remote datasource is success", () async {
          //arrange
          when(mockMessageRemoteDataSource.saveMessageRemote(any))
              .thenAnswer((_) async => true);
          //act
          final result = await messageRepositoryImpl.saveMessageRemote(testMessageModel);
          //assert
          verify(mockMessageRemoteDataSource.saveMessageRemote(testMessageModel));
          expect(result, const Right(true));
        });

        test("should return ServerFailure when saveMessage and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockMessageRemoteDataSource.saveMessageRemote(any))
              .thenThrow(ServerException());
          //act
          final result = await messageRepositoryImpl.saveMessageRemote(testMessageModel);
          //assert
          verify(mockMessageRemoteDataSource.saveMessageRemote(testMessageModel));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockMessageRemoteDataSource.saveMessageRemote(any))
              .thenThrow(ConnectionException());
          //act
          final result = await messageRepositoryImpl.saveMessageRemote(testMessageModel);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });

    group("updateAllMessagesRemote", () {
      runTestsOnline(() {
        test(
            "should return true and update all Messages when call to remote datasource is success", () async {
          //arrange
          when(mockMessageRemoteDataSource.updateAllMessagesRemote(any))
              .thenAnswer((_) async => true);
          //act
          final result = await messageRepositoryImpl.updateAllMessagesRemote([testMessageModel]);
          //assert
          verify(mockMessageRemoteDataSource.updateAllMessagesRemote([testMessageModel]));
          expect(result, const Right(true));
        });
        test("should return ServerFailure when updateAllMessages and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockMessageRemoteDataSource.updateAllMessagesRemote(any))
              .thenThrow(ServerException());
          //act
          final result = await messageRepositoryImpl.updateAllMessagesRemote([testMessageModel]);
          //assert
          verify(mockMessageRemoteDataSource.updateAllMessagesRemote([testMessageModel]));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockMessageRemoteDataSource.updateAllMessagesRemote(any))
              .thenThrow(ConnectionException());
          //act
          final result = await messageRepositoryImpl.updateAllMessagesRemote([testMessageModel]);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });
  });

  group("MessageLocalDataSource", () {
    group("existMessageLocal", () {
      test("should return true when existMessage and call to local datasource is success", () async {
        //arrange
        when(mockMessageLocalDataSource.existMessageLocal(any))
            .thenAnswer((_) async => true);
        //act
        final result = await messageRepositoryImpl.existMessageLocal(messageId);
        //assert
        verify(mockMessageLocalDataSource.existMessageLocal(messageId));
        expect(result, const Right(true));
      });
      test("should return DatabaseFailure when existMessage and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockMessageLocalDataSource.existMessageLocal(any))
            .thenThrow(DatabaseException());
        //act
        final result = await messageRepositoryImpl.existMessageLocal(messageId);
        //assert
        verify(mockMessageLocalDataSource.existMessageLocal(messageId));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("getAllMessagesLocal", () {
      test("should return all Messages when call to local datasource is successful", () async {
        //arrange
        when(mockMessageLocalDataSource.getAllMessagesLocal(any, any))
            .thenAnswer((_) async => [testMessageModel]);
        //act
        final result = await messageRepositoryImpl.getAllMessagesLocal(senderPhoneNumber, targetPhoneNumber);
        //assert
        verify(mockMessageLocalDataSource.getAllMessagesLocal(senderPhoneNumber, targetPhoneNumber));
        expect(result.getOrElse(() => []), [testMessageModel]);
      });
      test("should return DatabaseFailure when getAllMessages and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockMessageLocalDataSource.getAllMessagesLocal(any, any))
            .thenThrow(DatabaseException());
        //act
        final result = await messageRepositoryImpl.getAllMessagesLocal(senderPhoneNumber, targetPhoneNumber);
        //assert
        verify(mockMessageLocalDataSource.getAllMessagesLocal(senderPhoneNumber, targetPhoneNumber));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("getMessageLocal", () {
      test("should return a Message model when call to local datasource is success", () async {
        //arrange
        when(mockMessageLocalDataSource.getMessageLocal(any))
            .thenAnswer((_) async => testMessageModel);
        //act
        final result = await messageRepositoryImpl.getMessageLocal(messageId);
        //assert
        verify(mockMessageLocalDataSource.getMessageLocal(messageId));
        expect(result, Right(testMessageModel));
      });
      test("should return DatabaseFailure when getMessage and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockMessageLocalDataSource.getMessageLocal(any))
            .thenThrow(DatabaseException());
        //act
        final result = await messageRepositoryImpl.getMessageLocal(messageId);
        //assert
        verify(mockMessageLocalDataSource.getMessageLocal(messageId));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("removeMessageLocal", () {
      test("should return true when removeMessage and call to local datasource is success", () async {
        //arrange
        when(mockMessageLocalDataSource.removeMessageLocal(any))
            .thenAnswer((_) async => true);
        //act
        final result = await messageRepositoryImpl.removeMessageLocal(messageId);
        //assert
        verify(mockMessageLocalDataSource.removeMessageLocal(messageId));
        expect(result, const Right(true));
      });
      test("should return DatabaseFailure when removeMessage and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockMessageLocalDataSource.removeMessageLocal(any))
            .thenThrow(DatabaseException());
        //act
        final result = await messageRepositoryImpl.removeMessageLocal(messageId);
        //assert
        verify(mockMessageLocalDataSource.removeMessageLocal(messageId));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("saveMessageLocal", () {
      test("should return true when saveMessage and call to local datasource is success", () async {
        //arrange
        when(mockMessageLocalDataSource.saveMessageLocal(any))
            .thenAnswer((_) async => true);
        //act
        final result = await messageRepositoryImpl.saveMessageLocal(testMessageModel);
        //assert
        verify(mockMessageLocalDataSource.saveMessageLocal(testMessageModel));
        expect(result, const Right(true));
      });
      test("should return DatabaseFailure when saveMessage and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockMessageLocalDataSource.saveMessageLocal(any))
            .thenThrow(DatabaseException());
        //act
        final result = await messageRepositoryImpl.saveMessageLocal(testMessageModel);
        //assert
        verify(mockMessageLocalDataSource.saveMessageLocal(testMessageModel));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("getAllUnsendMessagesLocal", () {
      test("should return all unsend Messages when call to local datasource is successful", () async {
        //arrange
        when(mockMessageLocalDataSource.getAllUnsendMessagesLocal())
            .thenAnswer((_) async => [testMessageModel]);
        //act
        final result = await messageRepositoryImpl.getAllUnsendMessagesLocal();
        //assert
        verify(mockMessageLocalDataSource.getAllUnsendMessagesLocal());
        expect(result.getOrElse(() => []), [testMessageModel]);
      });
      test("should return DatabaseFailure when getAllUnsendMessages and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockMessageLocalDataSource.getAllUnsendMessagesLocal())
            .thenThrow(DatabaseException());
        //act
        final result = await messageRepositoryImpl.getAllUnsendMessagesLocal();
        //assert
        verify(mockMessageLocalDataSource.getAllUnsendMessagesLocal());
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("getAllNotReadMessagesLocal", () {
      test("should return all not-read Messages when call to local datasource is successful", () async {
        //arrange
        when(mockMessageLocalDataSource.getAllNotReadMessagesLocal(any, any))
            .thenAnswer((_) async => [testMessageModel]);
        //act
        final result = await messageRepositoryImpl.getAllNotReadMessagesLocal(senderPhoneNumber, targetPhoneNumber);
        //assert
        verify(mockMessageLocalDataSource.getAllNotReadMessagesLocal(senderPhoneNumber, targetPhoneNumber));
        expect(result.getOrElse(() => []), [testMessageModel]);
      });
      test("should return DatabaseFailure when getAllNotReadMessages and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockMessageLocalDataSource.getAllNotReadMessagesLocal(any, any))
            .thenThrow(DatabaseException());
        //act
        final result = await messageRepositoryImpl.getAllNotReadMessagesLocal(senderPhoneNumber, targetPhoneNumber);
        //assert
        verify(mockMessageLocalDataSource.getAllNotReadMessagesLocal(senderPhoneNumber, targetPhoneNumber));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });
  });
}