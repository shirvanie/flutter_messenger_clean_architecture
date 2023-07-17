

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/features/data/models/group_user_model.dart';
import 'package:messenger/features/data/repositories/group_user_repository_impl.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupUserLocalDataSource mockGroupUserLocalDataSource;
  late MockGroupUserRemoteDataSource mockGroupUserRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late GroupUserRepositoryImpl groupUserRepositoryImpl;

  final testJson = fixtureReader("group_user_model.json");
  final testGroupUserModel = GroupUserModel.fromJson(json.decode(testJson));
  String groupId = testGroupUserModel.groupId.toString();
  String userPhoneNumber = testGroupUserModel.userPhoneNumber.toString();

  setUp(() {
    mockGroupUserLocalDataSource = MockGroupUserLocalDataSource();
    mockGroupUserRemoteDataSource = MockGroupUserRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    groupUserRepositoryImpl = GroupUserRepositoryImpl(
        groupUserLocalDataSource: mockGroupUserLocalDataSource,
        groupUserRemoteDataSource: mockGroupUserRemoteDataSource,
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

  group("GroupUserRemoteDataSource", () {
    group("getAllGroupUsersRemote", () {
      runTestsOnline(() {
        test(
            "should return all GroupUsers when call to remote datasource is success", () async {
          //arrange
          when(mockGroupUserRemoteDataSource.getAllGroupUsersRemote(any))
              .thenAnswer((_) async => [testGroupUserModel]);
          //act
          final result = await groupUserRepositoryImpl.getAllGroupUsersRemote(groupId);
          //assert
          verify(mockGroupUserRemoteDataSource.getAllGroupUsersRemote(groupId));
          expect(result.getOrElse(() => []), [testGroupUserModel]);
        });
        test("should return ServerFailure when getAllGroupUsers and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockGroupUserRemoteDataSource.getAllGroupUsersRemote(any))
              .thenThrow(ServerException());
          //act
          final result = await groupUserRepositoryImpl.getAllGroupUsersRemote(groupId);
          //assert
          verify(mockGroupUserRemoteDataSource.getAllGroupUsersRemote(groupId));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockGroupUserRemoteDataSource.getAllGroupUsersRemote(any))
              .thenThrow(ConnectionException());
          //act
          final result = await groupUserRepositoryImpl.getAllGroupUsersRemote(groupId);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });

    group("getAllGroupUsersByPhoneNumberRemote", () {
      runTestsOnline(() {
        test(
            "should return all GroupUsersByPhoneNumber when call to remote datasource is success", () async {
          //arrange
          when(mockGroupUserRemoteDataSource.getAllGroupUsersByPhoneNumberRemote(any))
              .thenAnswer((_) async => [testGroupUserModel]);
          //act
          final result = await groupUserRepositoryImpl.getAllGroupUsersByPhoneNumberRemote(userPhoneNumber);
          //assert
          verify(mockGroupUserRemoteDataSource.getAllGroupUsersByPhoneNumberRemote(userPhoneNumber));
          expect(result.getOrElse(() => []), [testGroupUserModel]);
        });
        test("should return ServerFailure when getAllGroupUserByPhoneNumber and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockGroupUserRemoteDataSource.getAllGroupUsersByPhoneNumberRemote(any))
              .thenThrow(ServerException());
          //act
          final result = await groupUserRepositoryImpl.getAllGroupUsersByPhoneNumberRemote(userPhoneNumber);
          //assert
          verify(mockGroupUserRemoteDataSource.getAllGroupUsersByPhoneNumberRemote(userPhoneNumber));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockGroupUserRemoteDataSource.getAllGroupUsersByPhoneNumberRemote(any))
              .thenThrow(ConnectionException());
          //act
          final result = await groupUserRepositoryImpl.getAllGroupUsersByPhoneNumberRemote(userPhoneNumber);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });

    group("removeGroupUserRemote", () {
      runTestsOnline(() {
        test("should return true when removeGroupUser and call to remote datasource is success", () async {
          //arrange
          when(mockGroupUserRemoteDataSource.removeGroupUserRemote(any, any))
              .thenAnswer((_) async => true);
          //act
          final result = await groupUserRepositoryImpl.removeGroupUserRemote(groupId, userPhoneNumber);
          //assert
          verify(mockGroupUserRemoteDataSource.removeGroupUserRemote(groupId, userPhoneNumber));
          expect(result, const Right(true));
        });

        test("should return ServerFailure when removeGroupUser and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockGroupUserRemoteDataSource.removeGroupUserRemote(any, any))
              .thenThrow(ServerException());
          //act
          final result = await groupUserRepositoryImpl.removeGroupUserRemote(groupId, userPhoneNumber);
          //assert
          verify(mockGroupUserRemoteDataSource.removeGroupUserRemote(groupId, userPhoneNumber));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockGroupUserRemoteDataSource.removeGroupUserRemote(any, any))
              .thenThrow(ConnectionException());
          //act
          final result = await groupUserRepositoryImpl.removeGroupUserRemote(groupId, userPhoneNumber);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });

    group("saveGroupUserRemote", () {
      runTestsOnline(() {
        test("should return true when saveGroupUser and call to remote datasource is success", () async {
          //arrange
          when(mockGroupUserRemoteDataSource.saveGroupUserRemote(any))
              .thenAnswer((_) async => true);
          //act
          final result = await groupUserRepositoryImpl.saveGroupUserRemote(testGroupUserModel);
          //assert
          verify(mockGroupUserRemoteDataSource.saveGroupUserRemote(testGroupUserModel));
          expect(result, const Right(true));
        });

        test("should return ServerFailure when saveGroupUser and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockGroupUserRemoteDataSource.saveGroupUserRemote(any))
              .thenThrow(ServerException());
          //act
          final result = await groupUserRepositoryImpl.saveGroupUserRemote(testGroupUserModel);
          //assert
          verify(mockGroupUserRemoteDataSource.saveGroupUserRemote(testGroupUserModel));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockGroupUserRemoteDataSource.saveGroupUserRemote(any))
              .thenThrow(ConnectionException());
          //act
          final result = await groupUserRepositoryImpl.saveGroupUserRemote(testGroupUserModel);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });
  });

  group("GroupUserLocalDataSource", () {
    group("getAllGroupUsersLocal", () {
      test("should return all GroupUsers when call to local datasource is successful", () async {
        //arrange
        when(mockGroupUserLocalDataSource.getAllGroupUsersLocal(any))
            .thenAnswer((_) async => [testGroupUserModel]);
        //act
        final result = await groupUserRepositoryImpl.getAllGroupUsersLocal(groupId);
        //assert
        verify(mockGroupUserLocalDataSource.getAllGroupUsersLocal(groupId));
        expect(result.getOrElse(() => []), [testGroupUserModel]);
      });
      test("should return DatabaseFailure when getAllGroupUsers and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockGroupUserLocalDataSource.getAllGroupUsersLocal(any))
            .thenThrow(DatabaseException());
        //act
        final result = await groupUserRepositoryImpl.getAllGroupUsersLocal(groupId);
        //assert
        verify(mockGroupUserLocalDataSource.getAllGroupUsersLocal(groupId));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("getGroupUserLocal", () {
      test("should return a GroupUser model when call to local datasource is success", () async {
        //arrange
        when(mockGroupUserLocalDataSource.getGroupUserLocal(any, any))
            .thenAnswer((_) async => testGroupUserModel);
        //act
        final result = await groupUserRepositoryImpl.getGroupUserLocal(groupId, userPhoneNumber);
        //assert
        verify(mockGroupUserLocalDataSource.getGroupUserLocal(groupId, userPhoneNumber));
        expect(result, Right(testGroupUserModel));
      });
      test("should return DatabaseFailure when getGroupUser and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockGroupUserLocalDataSource.getGroupUserLocal(any, any))
            .thenThrow(DatabaseException());
        //act
        final result = await groupUserRepositoryImpl.getGroupUserLocal(groupId, userPhoneNumber);
        //assert
        verify(mockGroupUserLocalDataSource.getGroupUserLocal(groupId, userPhoneNumber));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("removeGroupUserLocal", () {
      test("should return true when removeGroupUser and call to local datasource is success", () async {
        //arrange
        when(mockGroupUserLocalDataSource.removeGroupUserLocal(any, any))
            .thenAnswer((_) async => true);
        //act
        final result = await groupUserRepositoryImpl.removeGroupUserLocal(groupId, userPhoneNumber);
        //assert
        verify(mockGroupUserLocalDataSource.removeGroupUserLocal(groupId, userPhoneNumber));
        expect(result, const Right(true));
      });
      test("should return DatabaseFailure when removeGroupUser and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockGroupUserLocalDataSource.removeGroupUserLocal(any, any))
            .thenThrow(DatabaseException());
        //act
        final result = await groupUserRepositoryImpl.removeGroupUserLocal(groupId, userPhoneNumber);
        //assert
        verify(mockGroupUserLocalDataSource.removeGroupUserLocal(groupId, userPhoneNumber));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("saveGroupUserLocal", () {
      test("should return true when saveGroupUser and call to local datasource is success", () async {
        //arrange
        when(mockGroupUserLocalDataSource.saveGroupUserLocal(any))
            .thenAnswer((_) async => true);
        //act
        final result = await groupUserRepositoryImpl.saveGroupUserLocal(testGroupUserModel);
        //assert
        verify(mockGroupUserLocalDataSource.saveGroupUserLocal(testGroupUserModel));
        expect(result, const Right(true));
      });
      test("should return DatabaseFailure when saveGroupUser and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockGroupUserLocalDataSource.saveGroupUserLocal(any))
            .thenThrow(DatabaseException());
        //act
        final result = await groupUserRepositoryImpl.saveGroupUserLocal(testGroupUserModel);
        //assert
        verify(mockGroupUserLocalDataSource.saveGroupUserLocal(testGroupUserModel));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });
  });
}