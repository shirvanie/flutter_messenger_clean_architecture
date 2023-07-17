

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/features/data/datasources/remote/group_remote_datasource.dart';
import 'package:messenger/features/data/models/group_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';


void main() {
  late MockDio mockDio;
  late GroupRemoteDataSourceImpl groupRemoteDataSourceImpl;

  final testJson = fixtureReader("group_model.json");
  final testGroupModel = GroupModel.fromJson(json.decode(testJson));

  final groupId = testGroupModel.groupId!;

  setUp(() {
    mockDio = MockDio();
    groupRemoteDataSourceImpl = GroupRemoteDataSourceImpl(dio: mockDio);
  });

  group("getAllGroupsRemote", () {
    test("should perform a GET request", () async {
      // arrange
      when(mockDio.get(Constants.getAllGroupsApiUrl)).thenAnswer(
              (_) async => dioResponse(data: [testJson], statusCode: 200,));
      // act
      groupRemoteDataSourceImpl.getAllGroupsRemote();
      // assert
      verify(mockDio.get(Constants.getAllGroupsApiUrl),);
    });

    test(
        "should return all groups when the response code is 200",
            () async {
          // arrange
          when(mockDio.get(Constants.getAllGroupsApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async => dioResponse(data: [testJson], statusCode: 200,));
          // act
          final result = await groupRemoteDataSourceImpl
              .getAllGroupsRemote();
          // assert
          expect(result, equals([testGroupModel]));
        });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockDio.get(Constants.getAllGroupsApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(data: "Something went wrong",
                    statusCode: 404,));
          // act
          final call = groupRemoteDataSourceImpl.getAllGroupsRemote;
          // assert
          expect(() => call(), throwsA(isA<ServerException>()));
        });
  });

  group("getGroupRemote", () {
    test("should perform a POST request", () async {
      // arrange
      when(mockDio.post(Constants.getGroupApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.decode(testJson), statusCode: 200,));
      // act
      groupRemoteDataSourceImpl.getGroupRemote(groupId);
      // assert
      verify(mockDio.post(Constants.getGroupApiUrl,
        data: json.encode({
          "groupId": groupId,
        }),
      ));
    });

    test("should return a group model when the response code is 200", () async {
      // arrange
      when(mockDio.post(Constants.getGroupApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.decode(testJson), statusCode: 200,));
      // act
      final result = await groupRemoteDataSourceImpl
          .getGroupRemote(groupId);
      // assert
      expect(result, equals(testGroupModel));
    });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockDio.post(Constants.getGroupApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(data: "Something went wrong",
                    statusCode: 404,));
          // act
          final call = groupRemoteDataSourceImpl.getGroupRemote;
          // assert
          expect(() => call(groupId), throwsA(isA<ServerException>()));
        });
  });

  group("saveGroupRemote", () {
    test("should perform a POST request", () async {
      // arrange
      when(mockDio.post(Constants.saveGroupApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.encode("Data Saved"), statusCode: 200,));
      // act
      groupRemoteDataSourceImpl.saveGroupRemote(testGroupModel);
      // assert
      verify(mockDio.post(Constants.saveGroupApiUrl,
        data: json.encode(
            testGroupModel
        ),
      ));
    });

    test("should save a group when the response code is 200", () async {
      // arrange
      when(mockDio.post(Constants.saveGroupApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.encode("Data Saved"), statusCode: 200,));
      // act
      final result = await groupRemoteDataSourceImpl
          .saveGroupRemote(testGroupModel);
      // assert
      expect(result, equals(true));
    });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockDio.post(Constants.saveGroupApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(data: "Something went wrong",
                    statusCode: 404,));
          // act
          final call = groupRemoteDataSourceImpl.saveGroupRemote;
          // assert
          expect(() => call(testGroupModel), throwsA(isA<ServerException>()));
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
    )
  );
}
