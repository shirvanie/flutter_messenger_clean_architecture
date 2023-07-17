

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/features/data/models/group_message_model.dart';
import 'package:messenger/features/data/repositories/group_message_repository_impl.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupMessageLocalDataSource mockGroupMessageLocalDataSource;
  late MockGroupMessageRemoteDataSource mockGroupMessageRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late GroupMessageRepositoryImpl groupMessageRepositoryImpl;

  final testJson = fixtureReader("group_message_model.json");
  final testGroupMessageModel = GroupMessageModel.fromJson(json.decode(testJson));
  String groupId = testGroupMessageModel.groupId.toString();
  String messageId = testGroupMessageModel.messageId.toString();
  String senderPhoneNumber = testGroupMessageModel.senderPhoneNumber.toString();
  String receiverPhoneNumber = testGroupMessageModel.senderPhoneNumber.toString();

  setUp(() {
    mockGroupMessageLocalDataSource = MockGroupMessageLocalDataSource();
    mockGroupMessageRemoteDataSource = MockGroupMessageRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    groupMessageRepositoryImpl = GroupMessageRepositoryImpl(
        groupMessageLocalDataSource: mockGroupMessageLocalDataSource,
        groupMessageRemoteDataSource: mockGroupMessageRemoteDataSource,
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

  group("GroupMessageRemoteDataSource", () {
    group("getAllGroupMessagesRemote", () {
      runTestsOnline(() {
        test(
            "should return all GroupMessages when call to remote datasource is success", () async {
          //arrange
          when(mockGroupMessageRemoteDataSource.getAllGroupMessagesRemote(any))
              .thenAnswer((_) async => [testGroupMessageModel]);
          //act
          final result = await groupMessageRepositoryImpl.getAllGroupMessagesRemote(groupId);
          //assert
          verify(mockGroupMessageRemoteDataSource.getAllGroupMessagesRemote(groupId));
          expect(result.getOrElse(() => []), [testGroupMessageModel]);
        });
        test("should return ServerFailure when getAllGroupMessages and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockGroupMessageRemoteDataSource.getAllGroupMessagesRemote(any))
              .thenThrow(ServerException());
          //act
          final result = await groupMessageRepositoryImpl.getAllGroupMessagesRemote(groupId);
          //assert
          verify(mockGroupMessageRemoteDataSource.getAllGroupMessagesRemote(groupId));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockGroupMessageRemoteDataSource.getAllGroupMessagesRemote(any))
              .thenThrow(ConnectionException());
          //act
          final result = await groupMessageRepositoryImpl.getAllGroupMessagesRemote(groupId);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });

    group("getGroupMessageRemote", () {
      runTestsOnline(() {
        test("should return a GroupMessage model when call to remote datasource is success", () async {
          //arrange
          when(mockGroupMessageRemoteDataSource.getGroupMessageRemote(any))
              .thenAnswer((_) async => testGroupMessageModel);
          //act
          final result = await groupMessageRepositoryImpl.getGroupMessageRemote(messageId);
          //assert
          verify(mockGroupMessageRemoteDataSource.getGroupMessageRemote(messageId));
          expect(result, Right(testGroupMessageModel));
        });

        test("should return ServerFailure when getGroupMessage and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockGroupMessageRemoteDataSource.getGroupMessageRemote(any))
              .thenThrow(ServerException());
          //act
          final result = await groupMessageRepositoryImpl.getGroupMessageRemote(messageId);
          //assert
          verify(mockGroupMessageRemoteDataSource.getGroupMessageRemote(messageId));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockGroupMessageRemoteDataSource.getGroupMessageRemote(any))
              .thenThrow(ConnectionException());
          //act
          final result = await groupMessageRepositoryImpl.getGroupMessageRemote(messageId);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });

    group("getMissedGroupMessagesRemote", () {
      runTestsOnline(() {
        test(
            "should return missed GroupMessages when call to remote datasource is success", () async {
          //arrange
          when(mockGroupMessageRemoteDataSource.getMissedGroupMessagesRemote(any, any))
              .thenAnswer((_) async => [testGroupMessageModel]);
          //act
          final result = await groupMessageRepositoryImpl.getMissedGroupMessagesRemote(groupId, receiverPhoneNumber);
          //assert
          verify(mockGroupMessageRemoteDataSource.getMissedGroupMessagesRemote(groupId, receiverPhoneNumber));
          expect(result.getOrElse(() => []), [testGroupMessageModel]);
        });
        test("should return ServerFailure when getMissedGroupMessages and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockGroupMessageRemoteDataSource.getMissedGroupMessagesRemote(any, any))
              .thenThrow(ServerException());
          //act
          final result = await groupMessageRepositoryImpl.getMissedGroupMessagesRemote(groupId, receiverPhoneNumber);
          //assert
          verify(mockGroupMessageRemoteDataSource.getMissedGroupMessagesRemote(groupId, receiverPhoneNumber));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockGroupMessageRemoteDataSource.getMissedGroupMessagesRemote(any, any))
              .thenThrow(ConnectionException());
          //act
          final result = await groupMessageRepositoryImpl.getMissedGroupMessagesRemote(groupId, receiverPhoneNumber);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });

    group("removeGroupMessageRemote", () {
      runTestsOnline(() {
        test("should return true when removeGroupMessage and call to remote datasource is success", () async {
          //arrange
          when(mockGroupMessageRemoteDataSource.removeGroupMessageRemote(any))
              .thenAnswer((_) async => true);
          //act
          final result = await groupMessageRepositoryImpl.removeGroupMessageRemote(messageId);
          //assert
          verify(mockGroupMessageRemoteDataSource.removeGroupMessageRemote(messageId));
          expect(result, const Right(true));
        });

        test("should return ServerFailure when removeGroupMessage and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockGroupMessageRemoteDataSource.removeGroupMessageRemote(any))
              .thenThrow(ServerException());
          //act
          final result = await groupMessageRepositoryImpl.removeGroupMessageRemote(messageId);
          //assert
          verify(mockGroupMessageRemoteDataSource.removeGroupMessageRemote(messageId));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockGroupMessageRemoteDataSource.removeGroupMessageRemote(any))
              .thenThrow(ConnectionException());
          //act
          final result = await groupMessageRepositoryImpl.removeGroupMessageRemote(messageId);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });

    group("saveGroupMessageRemote", () {
      runTestsOnline(() {
        test("should return true when saveGroupMessage and call to remote datasource is success", () async {
          //arrange
          when(mockGroupMessageRemoteDataSource.saveGroupMessageRemote(any))
              .thenAnswer((_) async => true);
          //act
          final result = await groupMessageRepositoryImpl.saveGroupMessageRemote(testGroupMessageModel);
          //assert
          verify(mockGroupMessageRemoteDataSource.saveGroupMessageRemote(testGroupMessageModel));
          expect(result, const Right(true));
        });

        test("should return ServerFailure when saveGroupMessage and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockGroupMessageRemoteDataSource.saveGroupMessageRemote(any))
              .thenThrow(ServerException());
          //act
          final result = await groupMessageRepositoryImpl.saveGroupMessageRemote(testGroupMessageModel);
          //assert
          verify(mockGroupMessageRemoteDataSource.saveGroupMessageRemote(testGroupMessageModel));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockGroupMessageRemoteDataSource.saveGroupMessageRemote(any))
              .thenThrow(ConnectionException());
          //act
          final result = await groupMessageRepositoryImpl.saveGroupMessageRemote(testGroupMessageModel);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });

    group("updateAllGroupMessagesRemote", () {
      runTestsOnline(() {
        test(
            "should return true and update all GroupMessages when call to remote datasource is success", () async {
          //arrange
          when(mockGroupMessageRemoteDataSource.updateAllGroupMessagesRemote(any))
              .thenAnswer((_) async => true);
          //act
          final result = await groupMessageRepositoryImpl.updateAllGroupMessagesRemote([testGroupMessageModel]);
          //assert
          verify(mockGroupMessageRemoteDataSource.updateAllGroupMessagesRemote([testGroupMessageModel]));
          expect(result, const Right(true));
        });
        test("should return ServerFailure when updateAllGroupMessages and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockGroupMessageRemoteDataSource.updateAllGroupMessagesRemote(any))
              .thenThrow(ServerException());
          //act
          final result = await groupMessageRepositoryImpl.updateAllGroupMessagesRemote([testGroupMessageModel]);
          //assert
          verify(mockGroupMessageRemoteDataSource.updateAllGroupMessagesRemote([testGroupMessageModel]));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockGroupMessageRemoteDataSource.updateAllGroupMessagesRemote(any))
              .thenThrow(ConnectionException());
          //act
          final result = await groupMessageRepositoryImpl.updateAllGroupMessagesRemote([testGroupMessageModel]);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });
  });

  group("GroupMessageLocalDataSource", () {
    group("existGroupMessageLocal", () {
      test("should return true when existGroupMessage and call to local datasource is success", () async {
        //arrange
        when(mockGroupMessageLocalDataSource.existGroupMessageLocal(any))
            .thenAnswer((_) async => true);
        //act
        final result = await groupMessageRepositoryImpl.existGroupMessageLocal(messageId);
        //assert
        verify(mockGroupMessageLocalDataSource.existGroupMessageLocal(messageId));
        expect(result, const Right(true));
      });
      test("should return DatabaseFailure when existGroupMessage and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockGroupMessageLocalDataSource.existGroupMessageLocal(any))
            .thenThrow(DatabaseException());
        //act
        final result = await groupMessageRepositoryImpl.existGroupMessageLocal(messageId);
        //assert
        verify(mockGroupMessageLocalDataSource.existGroupMessageLocal(messageId));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("getAllGroupMessagesLocal", () {
      test("should return all GroupMessages when call to local datasource is successful", () async {
        //arrange
        when(mockGroupMessageLocalDataSource.getAllGroupMessagesLocal(any))
            .thenAnswer((_) async => [testGroupMessageModel]);
        //act
        final result = await groupMessageRepositoryImpl.getAllGroupMessagesLocal(groupId);
        //assert
        verify(mockGroupMessageLocalDataSource.getAllGroupMessagesLocal(groupId));
        expect(result.getOrElse(() => []), [testGroupMessageModel]);
      });
      test("should return DatabaseFailure when getAllGroupMessages and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockGroupMessageLocalDataSource.getAllGroupMessagesLocal(any))
            .thenThrow(DatabaseException());
        //act
        final result = await groupMessageRepositoryImpl.getAllGroupMessagesLocal(groupId);
        //assert
        verify(mockGroupMessageLocalDataSource.getAllGroupMessagesLocal(groupId));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("getGroupMessageLocal", () {
      test("should return a GroupMessage model when call to local datasource is success", () async {
        //arrange
        when(mockGroupMessageLocalDataSource.getGroupMessageLocal(any))
            .thenAnswer((_) async => testGroupMessageModel);
        //act
        final result = await groupMessageRepositoryImpl.getGroupMessageLocal(messageId);
        //assert
        verify(mockGroupMessageLocalDataSource.getGroupMessageLocal(messageId));
        expect(result, Right(testGroupMessageModel));
      });
      test("should return DatabaseFailure when getGroupMessage and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockGroupMessageLocalDataSource.getGroupMessageLocal(any))
            .thenThrow(DatabaseException());
        //act
        final result = await groupMessageRepositoryImpl.getGroupMessageLocal(messageId);
        //assert
        verify(mockGroupMessageLocalDataSource.getGroupMessageLocal(messageId));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("removeGroupMessageLocal", () {
      test("should return true when removeGroupMessage and call to local datasource is success", () async {
        //arrange
        when(mockGroupMessageLocalDataSource.removeGroupMessageLocal(any))
            .thenAnswer((_) async => true);
        //act
        final result = await groupMessageRepositoryImpl.removeGroupMessageLocal(messageId);
        //assert
        verify(mockGroupMessageLocalDataSource.removeGroupMessageLocal(messageId));
        expect(result, const Right(true));
      });
      test("should return DatabaseFailure when removeGroupMessage and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockGroupMessageLocalDataSource.removeGroupMessageLocal(any))
            .thenThrow(DatabaseException());
        //act
        final result = await groupMessageRepositoryImpl.removeGroupMessageLocal(messageId);
        //assert
        verify(mockGroupMessageLocalDataSource.removeGroupMessageLocal(messageId));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("saveGroupMessageLocal", () {
      test("should return true when saveGroupMessage and call to local datasource is success", () async {
        //arrange
        when(mockGroupMessageLocalDataSource.saveGroupMessageLocal(any))
            .thenAnswer((_) async => true);
        //act
        final result = await groupMessageRepositoryImpl.saveGroupMessageLocal(testGroupMessageModel);
        //assert
        verify(mockGroupMessageLocalDataSource.saveGroupMessageLocal(testGroupMessageModel));
        expect(result, const Right(true));
      });
      test("should return DatabaseFailure when saveGroupMessage and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockGroupMessageLocalDataSource.saveGroupMessageLocal(any))
            .thenThrow(DatabaseException());
        //act
        final result = await groupMessageRepositoryImpl.saveGroupMessageLocal(testGroupMessageModel);
        //assert
        verify(mockGroupMessageLocalDataSource.saveGroupMessageLocal(testGroupMessageModel));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("getAllUnsendGroupMessagesLocal", () {
      test("should return all unSendGroupMessages when call to local datasource is successful", () async {
        //arrange
        when(mockGroupMessageLocalDataSource.getAllUnsendGroupMessagesLocal(any))
            .thenAnswer((_) async => [testGroupMessageModel]);
        //act
        final result = await groupMessageRepositoryImpl.getAllUnsendGroupMessagesLocal(senderPhoneNumber);
        //assert
        verify(mockGroupMessageLocalDataSource.getAllUnsendGroupMessagesLocal(senderPhoneNumber));
        expect(result.getOrElse(() => []), [testGroupMessageModel]);
      });
      test("should return DatabaseFailure when getAllUnsendGroupMessage and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockGroupMessageLocalDataSource.getAllUnsendGroupMessagesLocal(any))
            .thenThrow(DatabaseException());
        //act
        final result = await groupMessageRepositoryImpl.getAllUnsendGroupMessagesLocal(senderPhoneNumber);
        //assert
        verify(mockGroupMessageLocalDataSource.getAllUnsendGroupMessagesLocal(senderPhoneNumber));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });
  });
}