

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/features/data/datasources/remote/group_user_remote_datasource.dart';
import 'package:messenger/features/data/models/group_user_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';


void main() {
  late MockDio mockDio;
  late GroupUserRemoteDataSourceImpl groupUserRemoteDataSourceImpl;

  final testJson = fixtureReader("group_user_model.json");
  final testGroupUserModel = GroupUserModel.fromJson(json.decode(testJson));

  final groupId = testGroupUserModel.groupId!;
  final userPhoneNumber = testGroupUserModel.userPhoneNumber!;

  setUp(() {
    mockDio = MockDio();
    groupUserRemoteDataSourceImpl = GroupUserRemoteDataSourceImpl(dio: mockDio);
  });

  group("getAllGroupUsersRemote", () {
    test("should perform a POST request", () async {
      // arrange
      when(mockDio.post(Constants.getAllGroupUsersApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async => dioResponse(data: [testJson], statusCode: 200,));
      // act
      groupUserRemoteDataSourceImpl.getAllGroupUsersRemote(groupId);
      // assert
      verify(mockDio.post(Constants.getAllGroupUsersApiUrl,
        data: json.encode({
          "groupId": groupId
        }),
      ));
    });

    test(
        "should return all groupUsers when the response code is 200",
            () async {
          // arrange
          when(mockDio.post(Constants.getAllGroupUsersApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async => dioResponse(data: [testJson], statusCode: 200,));
          // act
          final result = await groupUserRemoteDataSourceImpl
              .getAllGroupUsersRemote(groupId);
          // assert
          expect(result, equals([testGroupUserModel]));
        });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockDio.post(Constants.getAllGroupUsersApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(data: "Something went wrong",
                    statusCode: 404,));
          // act
          final call = groupUserRemoteDataSourceImpl.getAllGroupUsersRemote;
          // assert
          expect(() => call(groupId), throwsA(isA<ServerException>()));
        });
  });

  group("getAllGroupUsersByPhoneNumberRemote", () {
    test("should perform a POST request", () async {
      // arrange
      when(mockDio.post(Constants.getAllGroupUsersByPhoneNumberApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async => dioResponse(data: [testJson], statusCode: 200,));
      // act
      groupUserRemoteDataSourceImpl
          .getAllGroupUsersByPhoneNumberRemote(userPhoneNumber);
      // assert
      verify(mockDio.post(Constants.getAllGroupUsersByPhoneNumberApiUrl,
        data: json.encode({
          "userPhoneNumber": userPhoneNumber
        }),
      ));
    });

    test(
        "should return all groupUsers by userPhoneNumber when the response code is 200",
            () async {
          // arrange
          when(mockDio.post(Constants.getAllGroupUsersByPhoneNumberApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async => dioResponse(data: [testJson], statusCode: 200,));
          // act
          final result = await groupUserRemoteDataSourceImpl
              .getAllGroupUsersByPhoneNumberRemote(userPhoneNumber);
          // assert
          expect(result, equals([testGroupUserModel]));
        });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockDio.post(Constants.getAllGroupUsersByPhoneNumberApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(data: "Something went wrong",
                    statusCode: 404,));
          // act
          final call = groupUserRemoteDataSourceImpl
              .getAllGroupUsersByPhoneNumberRemote;
          // assert
          expect(() => call(groupId), throwsA(isA<ServerException>()));
        });
  });

  group("saveGroupUserRemote", () {
    test("should perform a POST request", () async {
      // arrange
      when(mockDio.post(Constants.saveGroupUserApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.encode("Data Saved"), statusCode: 200,));
      // act
      groupUserRemoteDataSourceImpl.saveGroupUserRemote(testGroupUserModel);
      // assert
      verify(mockDio.post(Constants.saveGroupUserApiUrl,
        data: json.encode(
            testGroupUserModel
        ),
      ));
    });

    test(
        "should save a groupUser when the response code is 200", () async {
      // arrange
      when(mockDio.post(Constants.saveGroupUserApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.encode("Data Saved"), statusCode: 200,));
      // act
      final result = await groupUserRemoteDataSourceImpl
          .saveGroupUserRemote(testGroupUserModel);
      // assert
      expect(result, equals(true));
    });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockDio.post(Constants.saveGroupUserApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(data: "Something went wrong",
                    statusCode: 404,));
          // act
          final call = groupUserRemoteDataSourceImpl.saveGroupUserRemote;
          // assert
          expect(() => call(testGroupUserModel), throwsA(isA<ServerException>()));
        });
  });

  group("removeGroupUserRemote", () {
    test("should perform a POST request", () async {
      // arrange
      when(mockDio.post(Constants.removeGroupUserApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.encode("Data Removed"), statusCode: 200,));
      // act
      groupUserRemoteDataSourceImpl
          .removeGroupUserRemote(groupId, userPhoneNumber);
      // assert
      verify(mockDio.post(Constants.removeGroupUserApiUrl,
        data: json.encode({
          "groupId": groupId,
          "userPhoneNumber": userPhoneNumber
        }),
      ));
    });

    test(
        "should save a groupUser when the response code is 200", () async {
      // arrange
      when(mockDio.post(Constants.removeGroupUserApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.encode("Data Removed"), statusCode: 200,));
      // act
      final result = await groupUserRemoteDataSourceImpl
          .removeGroupUserRemote(groupId, userPhoneNumber);
      // assert
      expect(result, equals(true));
    });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockDio.post(Constants.removeGroupUserApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(data: "Something went wrong",
                    statusCode: 404,));
          // act
          final call = groupUserRemoteDataSourceImpl.removeGroupUserRemote;
          // assert
          expect(() => call(groupId, userPhoneNumber),
              throwsA(isA<ServerException>()));
        });
  });
}

Response dioResponse({required dynamic data, required int statusCode}) {
  return Response(
      data: data,
      statusCode: statusCode,
      requestOptions: RequestOptions(
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
          Headers.acceptHeader: [Headers.jsonContentType],
        },
      ));
}
