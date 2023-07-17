

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:messenger/features/data/models/sms_model.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/features/data/models/user_model.dart';
import 'package:messenger/features/data/repositories/user_repository_impl.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../helpers/test_helper.mocks.dart';


void main() {
  late MockUserLocalDataSource mockUserLocalDataSource;
  late MockUserRemoteDataSource mockUserRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late UserRepositoryImpl userRepositoryImpl;

  final testJson = fixtureReader("user_model.json");
  final testUserModel = UserModel.fromJson(json.decode(testJson));
  String userPhoneNumber = testUserModel.userPhoneNumber.toString();
  String lastSeenDateTime = testUserModel.lastSeenDateTime.toString();



  setUp(() {
    mockUserLocalDataSource = MockUserLocalDataSource();
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    userRepositoryImpl = UserRepositoryImpl(
      userLocalDataSource: mockUserLocalDataSource,
      userRemoteDataSource: mockUserRemoteDataSource,
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

  group("UserRemoteDataSource", () {
    group("getAllUsersRemote", () {
      runTestsOnline(() {
        test(
            "should return all Users when call to remote datasource is success", () async {
          //arrange
          when(mockUserRemoteDataSource.getAllUsersRemote())
              .thenAnswer((_) async => [testUserModel]);
          //act
          final result = await userRepositoryImpl.getAllUsersRemote();
          //assert
          verify(mockUserRemoteDataSource.getAllUsersRemote());
          expect(result.getOrElse(() => []), [testUserModel]);
        });
        test("should return ServerFailure when getAllUsers and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockUserRemoteDataSource.getAllUsersRemote())
              .thenThrow(ServerException());
          //act
          final result = await userRepositoryImpl.getAllUsersRemote();
          //assert
          verify(mockUserRemoteDataSource.getAllUsersRemote());
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockUserRemoteDataSource.getAllUsersRemote())
              .thenThrow(ConnectionException());
          //act
          final result = await userRepositoryImpl.getAllUsersRemote();
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });

    group("getUserRemote", () {
      runTestsOnline(() {
        test("should return a User model when call to remote datasource is success", () async {
          //arrange
          when(mockUserRemoteDataSource.getUserRemote(any))
              .thenAnswer((_) async => testUserModel);
          //act
          final result = await userRepositoryImpl.getUserRemote(userPhoneNumber);
          //assert
          verify(mockUserRemoteDataSource.getUserRemote(userPhoneNumber));
          expect(result, Right(testUserModel));
        });

        test("should return ServerFailure when getUser and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockUserRemoteDataSource.getUserRemote(any))
              .thenThrow(ServerException());
          //act
          final result = await userRepositoryImpl.getUserRemote(userPhoneNumber);
          //assert
          verify(mockUserRemoteDataSource.getUserRemote(userPhoneNumber));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockUserRemoteDataSource.getUserRemote(any))
              .thenThrow(ConnectionException());
          //act
          final result = await userRepositoryImpl.getUserRemote(userPhoneNumber);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });

    group("saveUserRemote", () {
      runTestsOnline(() {
        test("should return true when saveUser and call to remote datasource is success", () async {
          //arrange
          when(mockUserRemoteDataSource.saveUserRemote(any))
              .thenAnswer((_) async => true);
          //act
          final result = await userRepositoryImpl.saveUserRemote(testUserModel);
          //assert
          verify(mockUserRemoteDataSource.saveUserRemote(testUserModel));
          expect(result, const Right(true));
        });

        test("should return ServerFailure when saveUser and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockUserRemoteDataSource.saveUserRemote(any))
              .thenThrow(ServerException());
          //act
          final result = await userRepositoryImpl.saveUserRemote(testUserModel);
          //assert
          verify(mockUserRemoteDataSource.saveUserRemote(testUserModel));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockUserRemoteDataSource.saveUserRemote(any))
              .thenThrow(ConnectionException());
          //act
          final result = await userRepositoryImpl.saveUserRemote(testUserModel);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });

    group("setUserLastSeenDateTimeRemote", () {
      runTestsOnline(() {
        test("should return true when setUserLastSeenDateTime and call to remote datasource is success", () async {
          //arrange
          when(mockUserRemoteDataSource.setUserLastSeenDateTimeRemote(any, any))
              .thenAnswer((_) async => true);
          //act
          final result = await userRepositoryImpl.setUserLastSeenDateTimeRemote(userPhoneNumber, lastSeenDateTime);
          //assert
          verify(mockUserRemoteDataSource.setUserLastSeenDateTimeRemote(userPhoneNumber, lastSeenDateTime));
          expect(result, const Right(true));
        });

        test("should return ServerFailure when setUserLastSeenDateTime and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockUserRemoteDataSource.setUserLastSeenDateTimeRemote(any, any))
              .thenThrow(ServerException());
          //act
          final result = await userRepositoryImpl.setUserLastSeenDateTimeRemote(userPhoneNumber, lastSeenDateTime);
          //assert
          verify(mockUserRemoteDataSource.setUserLastSeenDateTimeRemote(userPhoneNumber, lastSeenDateTime));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockUserRemoteDataSource.setUserLastSeenDateTimeRemote(any, any))
              .thenThrow(ConnectionException());
          //act
          final result = await userRepositoryImpl.setUserLastSeenDateTimeRemote(userPhoneNumber, lastSeenDateTime);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });

    group("sendSMSVerifyCodeRemote", () {
      final testSMSModel = SMSModel(userPhoneNumber: testUserModel.userPhoneNumber!,
          verifyCode: testUserModel.verifyCode!);

      runTestsOnline(() {
        test("should return true when sendSMSVerify and call to remote datasource is success", () async {
          //arrange
          when(mockUserRemoteDataSource.sendSMSVerifyCodeRemote(any))
              .thenAnswer((_) async => true);
          //act
          final result = await userRepositoryImpl.sendSMSVerifyCodeRemote(testSMSModel);
          //assert
          verify(mockUserRemoteDataSource.sendSMSVerifyCodeRemote(testSMSModel));
          expect(result, const Right(true));
        });

        test("should return ServerFailure when sendSMSVerify and call to remote datasource is unsuccessful", () async {
          //arrange
          when(mockUserRemoteDataSource.sendSMSVerifyCodeRemote(any))
              .thenThrow(ServerException());
          //act
          final result = await userRepositoryImpl.sendSMSVerifyCodeRemote(testSMSModel);
          //assert
          verify(mockUserRemoteDataSource.sendSMSVerifyCodeRemote(testSMSModel));
          expect(result, equals(Left(ServerFailure())));
        });
      });
      runTestsOffline(() {
        test("should return ConnectionFailure when network disconnected", () async {
          //arrange
          when(mockUserRemoteDataSource.sendSMSVerifyCodeRemote(any))
              .thenThrow(ConnectionException());
          //act
          final result = await userRepositoryImpl.sendSMSVerifyCodeRemote(testSMSModel);
          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });
  });

  group("UserLocalDataSource", () {
    group("existUserLocal", () {
      test("should return true when existUser and call to local datasource is success", () async {
        //arrange
        when(mockUserLocalDataSource.existUserLocal(any))
            .thenAnswer((_) async => true);
        //act
        final result = await userRepositoryImpl.existUserLocal(userPhoneNumber);
        //assert
        verify(mockUserLocalDataSource.existUserLocal(userPhoneNumber));
        expect(result, const Right(true));
      });
      test("should return DatabaseFailure when existUser and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockUserLocalDataSource.existUserLocal(any))
            .thenThrow(DatabaseException());
        //act
        final result = await userRepositoryImpl.existUserLocal(userPhoneNumber);
        //assert
        verify(mockUserLocalDataSource.existUserLocal(userPhoneNumber));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("getAllUsersLocal", () {
      test("should return all Users when call to local datasource is successful", () async {
        //arrange
        when(mockUserLocalDataSource.getAllUsersLocal())
            .thenAnswer((_) async => [testUserModel]);
        //act
        final result = await userRepositoryImpl.getAllUsersLocal();
        //assert
        verify(mockUserLocalDataSource.getAllUsersLocal());
        expect(result.getOrElse(() => []), [testUserModel]);
      });
      test("should return DatabaseFailure when getAllUsers and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockUserLocalDataSource.getAllUsersLocal())
            .thenThrow(DatabaseException());
        //act
        final result = await userRepositoryImpl.getAllUsersLocal();
        //assert
        verify(mockUserLocalDataSource.getAllUsersLocal());
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("getUserLocal", () {
      test("should return a User model when call to local datasource is success", () async {
        //arrange
        when(mockUserLocalDataSource.getUserLocal(any))
            .thenAnswer((_) async => testUserModel);
        //act
        final result = await userRepositoryImpl.getUserLocal(userPhoneNumber);
        //assert
        verify(mockUserLocalDataSource.getUserLocal(userPhoneNumber));
        expect(result, Right(testUserModel));
      });
      test("should return DatabaseFailure when getUser and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockUserLocalDataSource.getUserLocal(any))
            .thenThrow(DatabaseException());
        //act
        final result = await userRepositoryImpl.getUserLocal(userPhoneNumber);
        //assert
        verify(mockUserLocalDataSource.getUserLocal(userPhoneNumber));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("removeUserLocal", () {
      test("should return true when removeUser and call to local datasource is success", () async {
        //arrange
        when(mockUserLocalDataSource.removeUserLocal(any))
            .thenAnswer((_) async => true);
        //act
        final result = await userRepositoryImpl.removeUserLocal(userPhoneNumber);
        //assert
        verify(mockUserLocalDataSource.removeUserLocal(userPhoneNumber));
        expect(result, const Right(true));
      });
      test("should return DatabaseFailure when removeUser and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockUserLocalDataSource.removeUserLocal(any))
            .thenThrow(DatabaseException());
        //act
        final result = await userRepositoryImpl.removeUserLocal(userPhoneNumber);
        //assert
        verify(mockUserLocalDataSource.removeUserLocal(userPhoneNumber));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });

    group("saveUserLocal", () {
      test("should return true when saveUser and call to local datasource is success", () async {
        //arrange
        when(mockUserLocalDataSource.saveUserLocal(any))
            .thenAnswer((_) async => true);
        //act
        final result = await userRepositoryImpl.saveUserLocal(testUserModel);
        //assert
        verify(mockUserLocalDataSource.saveUserLocal(testUserModel));
        expect(result, const Right(true));
      });
      test("should return DatabaseFailure when saveUser and call to local datasource is unsuccessful", () async {
        //arrange
        when(mockUserLocalDataSource.saveUserLocal(any))
            .thenThrow(DatabaseException());
        //act
        final result = await userRepositoryImpl.saveUserLocal(testUserModel);
        //assert
        verify(mockUserLocalDataSource.saveUserLocal(testUserModel));
        expect(result, equals(Left(DatabaseFailure())));
      });
    });
  });

}