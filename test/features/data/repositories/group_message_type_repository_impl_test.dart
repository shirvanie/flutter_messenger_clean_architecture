

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/features/data/models/group_message_type_model.dart';
import 'package:messenger/features/data/repositories/group_message_type_repository_impl.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupMessageTypeLocalDataSource mockGroupMessageTypeLocalDataSource;
  late MockGroupMessageTypeRemoteDataSource mockGroupMessageTypeRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late GroupMessageTypeRepositoryImpl groupMessageTypeRepositoryImpl;

  final testJson = fixtureReader("group_message_type_model.json");
  final testGroupMessageTypeModel = GroupMessageTypeModel.fromJson(json.decode(testJson));
  String groupId = testGroupMessageTypeModel.groupId.toString();
  String messageId = testGroupMessageTypeModel.messageId.toString();
  String receiverPhoneNumber = testGroupMessageTypeModel.receiverPhoneNumber.toString();

  setUp(() {
    mockGroupMessageTypeLocalDataSource = MockGroupMessageTypeLocalDataSource();
    mockGroupMessageTypeRemoteDataSource = MockGroupMessageTypeRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    groupMessageTypeRepositoryImpl = GroupMessageTypeRepositoryImpl(
        groupMessageTypeLocalDataSource: mockGroupMessageTypeLocalDataSource,
        groupMessageTypeRemoteDataSource: mockGroupMessageTypeRemoteDataSource,
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

  group("GroupMessageTypeRemoteDataSource", () {
    group("getAllGroupMessageTypesRemote", () {
      runTestsOnline(() {
        test(
            "should return all GroupMessageTypes when call to remote datasource is success", () async {
          //arrange
          when(mockGroupMessageTypeRemoteDataSource.getAllGroupMessageTypesRemote(any, any))
              .thenAnswer((_) async => [testGroupMessageTypeModel]);
          //act
          final result = await groupMessageTypeRepositoryImpl.getAllGroupMessageTypesRemote(groupId, messageId);
          //assert
          verify(mockGroupMessageTypeRemoteDataSource.getAllGroupMessageTypesRemote(groupId, messageId));
          expect(result.getOrElse(() => []), [testGroupMessageTypeModel]);
        });
        test("should return ServerFailure when getAllGroupMessageTypes and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockGroupMessageTypeRemoteDataSource.getAllGroupMessageTypesRemote(any, any))
              .thenThrow(ServerException());
          //act
          final result = await groupMessageTypeRepositoryImpl.getAllGroupMessageTypesRemote(groupId, messageId);
          //assert
          verify(mockGroupMessageTypeRemoteDataSource.getAllGroupMessageTypesRemote(groupId, messageId));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockGroupMessageTypeRemoteDataSource.getAllGroupMessageTypesRemote(any, any))
              .thenThrow(ConnectionException());
          //act
          final result = await groupMessageTypeRepositoryImpl.getAllGroupMessageTypesRemote(groupId, messageId);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });

    group("getGroupMessageTypeRemote", () {
      runTestsOnline(() {
        test("should return a GroupMessageType model when call to remote datasource is success", () async {
          //arrange
          when(mockGroupMessageTypeRemoteDataSource.getGroupMessageTypeRemote(any))
              .thenAnswer((_) async => testGroupMessageTypeModel);
          //act
          final result = await groupMessageTypeRepositoryImpl.getGroupMessageTypeRemote(messageId);
          //assert
          verify(mockGroupMessageTypeRemoteDataSource.getGroupMessageTypeRemote(messageId));
          expect(result, Right(testGroupMessageTypeModel));
        });

        test("should return ServerFailure when getGroupMessageType and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockGroupMessageTypeRemoteDataSource.getGroupMessageTypeRemote(any))
              .thenThrow(ServerException());
          //act
          final result = await groupMessageTypeRepositoryImpl.getGroupMessageTypeRemote(messageId);
          //assert
          verify(mockGroupMessageTypeRemoteDataSource.getGroupMessageTypeRemote(messageId));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockGroupMessageTypeRemoteDataSource.getGroupMessageTypeRemote(any))
              .thenThrow(ConnectionException());
          //act
          final result = await groupMessageTypeRepositoryImpl.getGroupMessageTypeRemote(messageId);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });

    group("removeGroupMessageTypeRemote", () {
      runTestsOnline(() {
        test("should return true when removeGroupMessageType and call to remote datasource is success", () async {
          //arrange
          when(mockGroupMessageTypeRemoteDataSource.removeGroupMessageTypeRemote(any))
              .thenAnswer((_) async => true);
          //act
          final result = await groupMessageTypeRepositoryImpl.removeGroupMessageTypeRemote(messageId);
          //assert
          verify(mockGroupMessageTypeRemoteDataSource.removeGroupMessageTypeRemote(messageId));
          expect(result, const Right(true));
        });

        test("should return ServerFailure when removeGroupMessageType and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockGroupMessageTypeRemoteDataSource.removeGroupMessageTypeRemote(any))
              .thenThrow(ServerException());
          //act
          final result = await groupMessageTypeRepositoryImpl.removeGroupMessageTypeRemote(messageId);
          //assert
          verify(mockGroupMessageTypeRemoteDataSource.removeGroupMessageTypeRemote(messageId));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockGroupMessageTypeRemoteDataSource.removeGroupMessageTypeRemote(any))
              .thenThrow(ConnectionException());
          //act
          final result = await groupMessageTypeRepositoryImpl.removeGroupMessageTypeRemote(messageId);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });

    group("saveGroupMessageTypeRemote", () {
      runTestsOnline(() {
        test("should return true when saveGroupMessageType and call to remote datasource is success", () async {
          //arrange
          when(mockGroupMessageTypeRemoteDataSource.saveGroupMessageTypeRemote(any))
              .thenAnswer((_) async => true);
          //act
          final result = await groupMessageTypeRepositoryImpl.saveGroupMessageTypeRemote(testGroupMessageTypeModel);
          //assert
          verify(mockGroupMessageTypeRemoteDataSource.saveGroupMessageTypeRemote(testGroupMessageTypeModel));
          expect(result, const Right(true));
        });

        test("should return ServerFailure when saveGroupMessageType and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockGroupMessageTypeRemoteDataSource.saveGroupMessageTypeRemote(any))
              .thenThrow(ServerException());
          //act
          final result = await groupMessageTypeRepositoryImpl.saveGroupMessageTypeRemote(testGroupMessageTypeModel);
          //assert
          verify(mockGroupMessageTypeRemoteDataSource.saveGroupMessageTypeRemote(testGroupMessageTypeModel));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockGroupMessageTypeRemoteDataSource.saveGroupMessageTypeRemote(any))
              .thenThrow(ConnectionException());
          //act
          final result = await groupMessageTypeRepositoryImpl.saveGroupMessageTypeRemote(testGroupMessageTypeModel);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });

    group("updateAllGroupMessageTypesRemote", () {
      runTestsOnline(() {
        test(
            "should return true and update all GroupMessageTypes when call to remote datasource is success", () async {
          //arrange
          when(mockGroupMessageTypeRemoteDataSource.updateAllGroupMessageTypesRemote(any))
              .thenAnswer((_) async => true);
          //act
          final result = await groupMessageTypeRepositoryImpl.updateAllGroupMessageTypesRemote([testGroupMessageTypeModel]);
          //assert
          verify(mockGroupMessageTypeRemoteDataSource.updateAllGroupMessageTypesRemote([testGroupMessageTypeModel]));
          expect(result, const Right(true));
        });
        test("should return ServerFailure when updateAllGroupMessageTypes and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockGroupMessageTypeRemoteDataSource.updateAllGroupMessageTypesRemote(any))
              .thenThrow(ServerException());
          //act
          final result = await groupMessageTypeRepositoryImpl.updateAllGroupMessageTypesRemote([testGroupMessageTypeModel]);
          //assert
          verify(mockGroupMessageTypeRemoteDataSource.updateAllGroupMessageTypesRemote([testGroupMessageTypeModel]));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockGroupMessageTypeRemoteDataSource.updateAllGroupMessageTypesRemote(any))
              .thenThrow(ConnectionException());
          //act
          final result = await groupMessageTypeRepositoryImpl.updateAllGroupMessageTypesRemote([testGroupMessageTypeModel]);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });
  });

  group("GroupMessageTypeLocalDataSource", () {
    group("existGroupMessageTypeLocal", () {
      test("should return true when existGroupMessageType and call to local datasource is success", () async {
        //arrange
        when(mockGroupMessageTypeLocalDataSource.existGroupMessageTypeLocal(any))
            .thenAnswer((_) async => true);
        //act
        final result = await groupMessageTypeRepositoryImpl.existGroupMessageTypeLocal(messageId);
        //assert
        verify(mockGroupMessageTypeLocalDataSource.existGroupMessageTypeLocal(messageId));
        expect(result, const Right(true));
      });
      test("should return DatabaseFailure when existGroupMessageType and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockGroupMessageTypeLocalDataSource.existGroupMessageTypeLocal(any))
            .thenThrow(DatabaseException());
        //act
        final result = await groupMessageTypeRepositoryImpl.existGroupMessageTypeLocal(messageId);
        //assert
        verify(mockGroupMessageTypeLocalDataSource.existGroupMessageTypeLocal(messageId));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("getAllGroupMessageTypesLocal", () {
      test("should return all GroupMessageTypes when call to local datasource is successful", () async {
        //arrange
        when(mockGroupMessageTypeLocalDataSource.getAllGroupMessageTypesLocal(any, any))
            .thenAnswer((_) async => [testGroupMessageTypeModel]);
        //act
        final result = await groupMessageTypeRepositoryImpl.getAllGroupMessageTypesLocal(groupId, messageId);
        //assert
        verify(mockGroupMessageTypeLocalDataSource.getAllGroupMessageTypesLocal(groupId, messageId));
        expect(result.getOrElse(() => []), [testGroupMessageTypeModel]);
      });
      test("should return DatabaseFailure when getAllGroupMessageTypes and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockGroupMessageTypeLocalDataSource.getAllGroupMessageTypesLocal(any, any))
            .thenThrow(DatabaseException());
        //act
        final result = await groupMessageTypeRepositoryImpl.getAllGroupMessageTypesLocal(groupId, messageId);
        //assert
        verify(mockGroupMessageTypeLocalDataSource.getAllGroupMessageTypesLocal(groupId, messageId));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("getGroupMessageTypeLocal", () {
      test("should return a GroupMessageType model when call to local datasource is success", () async {
        //arrange
        when(mockGroupMessageTypeLocalDataSource.getGroupMessageTypeLocal(any))
            .thenAnswer((_) async => testGroupMessageTypeModel);
        //act
        final result = await groupMessageTypeRepositoryImpl.getGroupMessageTypeLocal(messageId);
        //assert
        verify(mockGroupMessageTypeLocalDataSource.getGroupMessageTypeLocal(messageId));
        expect(result, Right(testGroupMessageTypeModel));
      });
      test("should return DatabaseFailure when getGroupMessageType and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockGroupMessageTypeLocalDataSource.getGroupMessageTypeLocal(any))
            .thenThrow(DatabaseException());
        //act
        final result = await groupMessageTypeRepositoryImpl.getGroupMessageTypeLocal(messageId);
        //assert
        verify(mockGroupMessageTypeLocalDataSource.getGroupMessageTypeLocal(messageId));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("removeGroupMessageTypeLocal", () {
      test("should return true when removeGroupMessageType and call to local datasource is success", () async {
        //arrange
        when(mockGroupMessageTypeLocalDataSource.removeGroupMessageTypeLocal(any))
            .thenAnswer((_) async => true);
        //act
        final result = await groupMessageTypeRepositoryImpl.removeGroupMessageTypeLocal(messageId);
        //assert
        verify(mockGroupMessageTypeLocalDataSource.removeGroupMessageTypeLocal(messageId));
        expect(result, const Right(true));
      });
      test("should return DatabaseFailure when removeGroupMessageType and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockGroupMessageTypeLocalDataSource.removeGroupMessageTypeLocal(any))
            .thenThrow(DatabaseException());
        //act
        final result = await groupMessageTypeRepositoryImpl.removeGroupMessageTypeLocal(messageId);
        //assert
        verify(mockGroupMessageTypeLocalDataSource.removeGroupMessageTypeLocal(messageId));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("saveGroupMessageTypeLocal", () {
      test("should return true when saveGroupMessageType and call to local datasource is success", () async {
        //arrange
        when(mockGroupMessageTypeLocalDataSource.saveGroupMessageTypeLocal(any))
            .thenAnswer((_) async => true);
        //act
        final result = await groupMessageTypeRepositoryImpl.saveGroupMessageTypeLocal(testGroupMessageTypeModel);
        //assert
        verify(mockGroupMessageTypeLocalDataSource.saveGroupMessageTypeLocal(testGroupMessageTypeModel));
        expect(result, const Right(true));
      });
      test("should return DatabaseFailure when saveGroupMessageType and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockGroupMessageTypeLocalDataSource.saveGroupMessageTypeLocal(any))
            .thenThrow(DatabaseException());
        //act
        final result = await groupMessageTypeRepositoryImpl.saveGroupMessageTypeLocal(testGroupMessageTypeModel);
        //assert
        verify(mockGroupMessageTypeLocalDataSource.saveGroupMessageTypeLocal(testGroupMessageTypeModel));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("getAllUnsendGroupMessageTypesLocal", () {
      test("should return all unsend whenGroupMessageTypes and call to local datasource is successful", () async {
        //arrange
        when(mockGroupMessageTypeLocalDataSource.getAllUnsendGroupMessageTypesLocal(any))
            .thenAnswer((_) async => [testGroupMessageTypeModel]);
        //act
        final result = await groupMessageTypeRepositoryImpl.getAllUnsendGroupMessageTypesLocal(receiverPhoneNumber);
        //assert
        verify(mockGroupMessageTypeLocalDataSource.getAllUnsendGroupMessageTypesLocal(receiverPhoneNumber));
        expect(result.getOrElse(() => []), [testGroupMessageTypeModel]);
      });
      test("should return DatabaseFailure when getAllUnsendGroupMessageTypes and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockGroupMessageTypeLocalDataSource.getAllUnsendGroupMessageTypesLocal(any))
            .thenThrow(DatabaseException());
        //act
        final result = await groupMessageTypeRepositoryImpl.getAllUnsendGroupMessageTypesLocal(receiverPhoneNumber);
        //assert
        verify(mockGroupMessageTypeLocalDataSource.getAllUnsendGroupMessageTypesLocal(receiverPhoneNumber));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("getAllNotReadGroupMessageTypesLocal", () {
      test("should return all not-read GroupMessageTypes when call to local datasource is successful", () async {
        //arrange
        when(mockGroupMessageTypeLocalDataSource.getAllNotReadGroupMessageTypesLocal(any))
            .thenAnswer((_) async => [testGroupMessageTypeModel]);
        //act
        final result = await groupMessageTypeRepositoryImpl.getAllNotReadGroupMessageTypesLocal(groupId);
        //assert
        verify(mockGroupMessageTypeLocalDataSource.getAllNotReadGroupMessageTypesLocal(groupId));
        expect(result.getOrElse(() => []), [testGroupMessageTypeModel]);
      });
      test("should return DatabaseFailure when getAllNotReadGroupMessageTypes and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockGroupMessageTypeLocalDataSource.getAllNotReadGroupMessageTypesLocal(any))
            .thenThrow(DatabaseException());
        //act
        final result = await groupMessageTypeRepositoryImpl.getAllNotReadGroupMessageTypesLocal(groupId);
        //assert
        verify(mockGroupMessageTypeLocalDataSource.getAllNotReadGroupMessageTypesLocal(groupId));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });
  });
}