


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/features/data/models/group_model.dart';
import 'package:messenger/features/data/repositories/group_repository_impl.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupLocalDataSource mockGroupLocalDataSource;
  late MockGroupRemoteDataSource mockGroupRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late GroupRepositoryImpl groupRepositoryImpl;

  final testJson = fixtureReader("group_model.json");
  final testGroupModel = GroupModel.fromJson(json.decode(testJson));
  String groupId = testGroupModel.groupId.toString();
  String userPhoneNumber = testGroupModel.groupCreatorUserPhoneNumber.toString();

  setUp(() {
    mockGroupLocalDataSource = MockGroupLocalDataSource();
    mockGroupRemoteDataSource = MockGroupRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    groupRepositoryImpl = GroupRepositoryImpl(
        groupLocalDataSource: mockGroupLocalDataSource,
        groupRemoteDataSource: mockGroupRemoteDataSource,
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

  group("GroupRemoteDataSource", () {
    group("getAllGroupsRemote", () {
      runTestsOnline(() {
        test(
            "should return all Groups when call to remote datasource is success", () async {
          //arrange
          when(mockGroupRemoteDataSource.getAllGroupsRemote())
              .thenAnswer((_) async => [testGroupModel]);
          //act
          final result = await groupRepositoryImpl.getAllGroupsRemote();
          //assert
          verify(mockGroupRemoteDataSource.getAllGroupsRemote());
          expect(result.getOrElse(() => []), [testGroupModel]);
        });
        test("should return ServerFailure when getAllGroups and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockGroupRemoteDataSource.getAllGroupsRemote())
              .thenThrow(ServerException());
          //act
          final result = await groupRepositoryImpl.getAllGroupsRemote();
          //assert
          verify(mockGroupRemoteDataSource.getAllGroupsRemote());
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockGroupRemoteDataSource.getAllGroupsRemote())
              .thenThrow(ConnectionException());
          //act
          final result = await groupRepositoryImpl.getAllGroupsRemote();
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });

    group("getGroupRemote", () {
      runTestsOnline(() {
        test("should return a Group model when call to remote datasource is success", () async {
          //arrange
          when(mockGroupRemoteDataSource.getGroupRemote(any))
              .thenAnswer((_) async => testGroupModel);
          //act
          final result = await groupRepositoryImpl.getGroupRemote(groupId);
          //assert
          verify(mockGroupRemoteDataSource.getGroupRemote(groupId));
          expect(result, Right(testGroupModel));
        });

        test("should return ServerFailure when getGroup and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockGroupRemoteDataSource.getGroupRemote(any))
              .thenThrow(ServerException());
          //act
          final result = await groupRepositoryImpl.getGroupRemote(groupId);
          //assert
          verify(mockGroupRemoteDataSource.getGroupRemote(groupId));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockGroupRemoteDataSource.getGroupRemote(any))
              .thenThrow(ConnectionException());
          //act
          final result = await groupRepositoryImpl.getGroupRemote(groupId);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });

    group("saveGroupRemote", () {
      runTestsOnline(() {
        test("should return true when saveGroup and call to remote datasource is success", () async {
          //arrange
          when(mockGroupRemoteDataSource.saveGroupRemote(any))
              .thenAnswer((_) async => true);
          //act
          final result = await groupRepositoryImpl.saveGroupRemote(testGroupModel);
          //assert
          verify(mockGroupRemoteDataSource.saveGroupRemote(testGroupModel));
          expect(result, const Right(true));
        });

        test("should return ServerFailure when saveGroup and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockGroupRemoteDataSource.saveGroupRemote(any))
              .thenThrow(ServerException());
          //act
          final result = await groupRepositoryImpl.saveGroupRemote(testGroupModel);
          //assert
          verify(mockGroupRemoteDataSource.saveGroupRemote(testGroupModel));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockGroupRemoteDataSource.saveGroupRemote(any))
              .thenThrow(ConnectionException());
          //act
          final result = await groupRepositoryImpl.saveGroupRemote(testGroupModel);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });
  });

  group("GroupLocalDataSource", () {
    group("getAllGroupsLocal", () {
      test("should return all Groups when call to local datasource is successful", () async {
        //arrange
        when(mockGroupLocalDataSource.getAllGroupsLocal())
            .thenAnswer((_) async => [testGroupModel]);
        //act
        final result = await groupRepositoryImpl.getAllGroupsLocal();
        //assert
        verify(mockGroupLocalDataSource.getAllGroupsLocal());
        expect(result.getOrElse(() => []), [testGroupModel]);
      });
      test("should return DatabaseFailure when getAllGroups and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockGroupLocalDataSource.getAllGroupsLocal())
            .thenThrow(DatabaseException());
        //act
        final result = await groupRepositoryImpl.getAllGroupsLocal();
        //assert
        verify(mockGroupLocalDataSource.getAllGroupsLocal());
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("getGroupLocal", () {
      test("should return a Group model when call to local datasource is success", () async {
        //arrange
        when(mockGroupLocalDataSource.getGroupLocal(any))
            .thenAnswer((_) async => testGroupModel);
        //act
        final result = await groupRepositoryImpl.getGroupLocal(userPhoneNumber);
        //assert
        verify(mockGroupLocalDataSource.getGroupLocal(userPhoneNumber));
        expect(result, Right(testGroupModel));
      });
      test("should return DatabaseFailure when getAllGroups and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockGroupLocalDataSource.getGroupLocal(any))
            .thenThrow(DatabaseException());
        //act
        final result = await groupRepositoryImpl.getGroupLocal(userPhoneNumber);
        //assert
        verify(mockGroupLocalDataSource.getGroupLocal(userPhoneNumber));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("removeGroupLocal", () {
      test("should return true when removeGroup and call to local datasource is success", () async {
        //arrange
        when(mockGroupLocalDataSource.removeGroupLocal(any))
            .thenAnswer((_) async => true);
        //act
        final result = await groupRepositoryImpl.removeGroupLocal(groupId);
        //assert
        verify(mockGroupLocalDataSource.removeGroupLocal(groupId));
        expect(result, const Right(true));
      });
      test("should return DatabaseFailure when removeGroup and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockGroupLocalDataSource.removeGroupLocal(any))
            .thenThrow(DatabaseException());
        //act
        final result = await groupRepositoryImpl.removeGroupLocal(groupId);
        //assert
        verify(mockGroupLocalDataSource.removeGroupLocal(groupId));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("saveGroupLocal", () {
      test("should return true when saveGroup and call to local datasource is success", () async {
        //arrange
        when(mockGroupLocalDataSource.saveGroupLocal(any))
            .thenAnswer((_) async => true);
        //act
        final result = await groupRepositoryImpl.saveGroupLocal(testGroupModel);
        //assert
        verify(mockGroupLocalDataSource.saveGroupLocal(testGroupModel));
        expect(result, const Right(true));
      });
      test("should return DatabaseFailure when saveGroup and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockGroupLocalDataSource.saveGroupLocal(any))
            .thenThrow(DatabaseException());
        //act
        final result = await groupRepositoryImpl.saveGroupLocal(testGroupModel);
        //assert
        verify(mockGroupLocalDataSource.saveGroupLocal(testGroupModel));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });
  });
}