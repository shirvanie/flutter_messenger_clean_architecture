

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:messenger/features/data/models/sms_model.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/features/data/models/user_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';


void main() {
  late MockUserRemoteDataSource mockUserRemoteDataSource;

  final testJson = fixtureReader("user_model.json");
  final testUserModel = UserModel.fromJson(json.decode(testJson));

  final userPhoneNumber = testUserModel.userPhoneNumber!;

  setUp(() {
    mockUserRemoteDataSource = MockUserRemoteDataSource();
  });

  group("getAllUsersRemote", () {
    test("should perform a GET request", () async {
      // arrange
      when(mockUserRemoteDataSource.getAllUsersRemote()).thenAnswer(
              (_) async => [testUserModel]);
      // act
      mockUserRemoteDataSource.getAllUsersRemote();
      // assert
      verify(mockUserRemoteDataSource.getAllUsersRemote());
    });

    test(
        "should return all users when the response code is 200", () async {
      // arrange
      when(mockUserRemoteDataSource.getAllUsersRemote()).thenAnswer(
              (_) async => [testUserModel]);
      // act
      final result = await mockUserRemoteDataSource
          .getAllUsersRemote();
      // assert
      expect(result, equals([testUserModel]));
    });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockUserRemoteDataSource.getAllUsersRemote())
              .thenThrow(ServerException());
          // act
          final call = mockUserRemoteDataSource.getAllUsersRemote;
          // assert
          expect(() => call(), throwsA(isA<ServerException>()));
        });
  });

  group("getUserRemote", () {
    test("should perform a POST request", () async {
      // arrange
      when(mockUserRemoteDataSource.getUserRemote(userPhoneNumber)).thenAnswer(
              (_) async => testUserModel);
      // act
      mockUserRemoteDataSource.getUserRemote(userPhoneNumber);
      // assert
      verify(mockUserRemoteDataSource.getUserRemote(userPhoneNumber));
    });

    test("should return a user when the response code is 200", () async {
      // arrange
      when(mockUserRemoteDataSource.getUserRemote(userPhoneNumber)).thenAnswer(
              (_) async => testUserModel);
      // act
      final result = await mockUserRemoteDataSource
          .getUserRemote(userPhoneNumber);
      // assert
      expect(result, equals(testUserModel));
    });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockUserRemoteDataSource.getUserRemote(userPhoneNumber))
              .thenThrow(ServerException());
          // act
          final call = mockUserRemoteDataSource.getUserRemote;
          // assert
          expect(() => call(userPhoneNumber), throwsA(isA<ServerException>()));
        });
  });

  group("saveUserRemote", () {
    test("should perform a POST request", () async {
      // arrange
      when(mockUserRemoteDataSource.saveUserRemote(testUserModel)).thenAnswer(
              (_) async => true);
      // act
      mockUserRemoteDataSource.saveUserRemote(testUserModel);
      // assert
      verify(mockUserRemoteDataSource.saveUserRemote(testUserModel));
    });

    test("should save a user when the response code is 200", () async {
      // arrange
      when(mockUserRemoteDataSource.saveUserRemote(testUserModel)).thenAnswer(
              (_) async => true);
      // act
      final result = await mockUserRemoteDataSource
          .saveUserRemote(testUserModel);
      // assert
      expect(result, equals(true));
    });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockUserRemoteDataSource.saveUserRemote(testUserModel))
              .thenThrow(ServerException());
          // act
          final call = mockUserRemoteDataSource.saveUserRemote;
          // assert
          expect(() => call(testUserModel), throwsA(isA<ServerException>()));
        });
  });

  group("setUserLastSeenDateTimeRemote", () {
    String lastSeenDateTime = DateTime.now().toString();

    test("should perform a POST request", () async {
      // arrange
      when(mockUserRemoteDataSource
          .setUserLastSeenDateTimeRemote(userPhoneNumber, lastSeenDateTime))
          .thenAnswer((_) async => true);
      // act
      mockUserRemoteDataSource.setUserLastSeenDateTimeRemote(
        userPhoneNumber,
        lastSeenDateTime,
      );
      // assert
      verify(mockUserRemoteDataSource
          .setUserLastSeenDateTimeRemote(userPhoneNumber, lastSeenDateTime));
    });

    test(
        "should set user lastSeenDateTime when the response code is 200", () async {
      // arrange
      when(mockUserRemoteDataSource
          .setUserLastSeenDateTimeRemote(userPhoneNumber, lastSeenDateTime))
          .thenAnswer((_) async => true);
      // act
      final result = await mockUserRemoteDataSource
          .setUserLastSeenDateTimeRemote(
        userPhoneNumber,
        lastSeenDateTime,
      );
      // assert
      expect(result, equals(true));
    });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockUserRemoteDataSource
              .setUserLastSeenDateTimeRemote(userPhoneNumber, lastSeenDateTime))
              .thenThrow(ServerException());
          // act
          final call = mockUserRemoteDataSource.setUserLastSeenDateTimeRemote;
          // assert
          expect(() => call(userPhoneNumber, lastSeenDateTime,),
              throwsA(isA<ServerException>()));
        });
  });

  group("sendSMSVerifyCodeRemote", () {
    final testSMSModel = SMSModel(
        userPhoneNumber: testUserModel.userPhoneNumber!,
        verifyCode: testUserModel.verifyCode!);

    test("should perform a POST request", () async {
      // arrange
      when(mockUserRemoteDataSource.sendSMSVerifyCodeRemote(testSMSModel))
          .thenAnswer((_) async => true);
      // act
      mockUserRemoteDataSource.sendSMSVerifyCodeRemote(testSMSModel);
      // assert
      verify(mockUserRemoteDataSource.sendSMSVerifyCodeRemote(testSMSModel));
    });

    test(
        "should send a sms with verifyCode to user when the response code is 200", () async {
      // arrange
      when(mockUserRemoteDataSource.sendSMSVerifyCodeRemote(testSMSModel))
          .thenAnswer((_) async => true);
      // act
      final result = await mockUserRemoteDataSource
          .sendSMSVerifyCodeRemote(testSMSModel);
      // assert
      expect(result, equals(true));
    });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockUserRemoteDataSource.sendSMSVerifyCodeRemote(testSMSModel))
              .thenThrow(ServerException());
          // act
          final call = mockUserRemoteDataSource.sendSMSVerifyCodeRemote;
          // assert
          expect(() => call(testSMSModel), throwsA(isA<ServerException>()));
        });
  });
}
