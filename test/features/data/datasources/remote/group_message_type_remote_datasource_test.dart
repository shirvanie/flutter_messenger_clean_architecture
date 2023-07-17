

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/features/data/datasources/remote/group_message_type_remote_datasource.dart';
import 'package:messenger/features/data/models/group_message_type_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';


void main() {
  late MockDio mockDio;
  late GroupMessageTypeRemoteDataSourceImpl groupMessageTypeRemoteDataSourceImpl;

  final testJson = fixtureReader("group_message_type_model.json");
  final testGroupMessageTypeModel = GroupMessageTypeModel
      .fromJson(json.decode(testJson));

  final messageId = testGroupMessageTypeModel.messageId!;
  final groupId = testGroupMessageTypeModel.groupId!;

  setUp(() {
    mockDio = MockDio();
    groupMessageTypeRemoteDataSourceImpl =
        GroupMessageTypeRemoteDataSourceImpl(dio: mockDio);
  });

  group("getAllGroupMessageTypesRemote", () {
    test("should perform a POST request", () async {
      // arrange
      when(mockDio.post(Constants.getAllGroupMessageTypesApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async => dioResponse(data: [testJson], statusCode: 200,));
      // act
      groupMessageTypeRemoteDataSourceImpl
          .getAllGroupMessageTypesRemote(groupId, messageId);
      // assert
      verify(mockDio.post(Constants.getAllGroupMessageTypesApiUrl,
        data: json.encode({
          "groupId": groupId,
          "messageId": messageId
        }),
      ));
    });

    test(
        "should return all groupMessageTypes when the response code is 200"
            "when the response code is 200",
            () async {
          // arrange
          when(mockDio.post(Constants.getAllGroupMessageTypesApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async => dioResponse(data: [testJson], statusCode: 200,));
          // act
          final result = await groupMessageTypeRemoteDataSourceImpl
              .getAllGroupMessageTypesRemote(groupId, messageId);
          // assert
          expect(result, equals([testGroupMessageTypeModel]));
        });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockDio.post(Constants.getAllGroupMessageTypesApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(data: "Something went wrong",
                    statusCode: 404,));
          // act
          final call = groupMessageTypeRemoteDataSourceImpl
              .getAllGroupMessageTypesRemote;
          // assert
          expect(() => call(groupId, messageId), throwsA(isA<ServerException>()));
        });
  });

  group("removeGroupMessageTypeRemote", () {
    test("should perform a POST request", () async {
      // arrange
      when(mockDio.post(Constants.removeGroupMessageTypeApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.encode("Data Removed"), statusCode: 200,));
      // act
      groupMessageTypeRemoteDataSourceImpl
          .removeGroupMessageTypeRemote(messageId);
      // assert
      verify(mockDio.post(Constants.removeGroupMessageTypeApiUrl,
        data: json.encode({
          "messageId": messageId
        }),
      ));
    });

    test(
        "should save a groupMessageType when the response code is 200",
            () async {
      // arrange
      when(mockDio.post(Constants.removeGroupMessageTypeApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.encode("Data Removed"), statusCode: 200,));
      // act
      final result = await groupMessageTypeRemoteDataSourceImpl
          .removeGroupMessageTypeRemote(messageId);
      // assert
      expect(result, equals(true));
    });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockDio.post(Constants.removeGroupMessageTypeApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(data: "Something went wrong",
                    statusCode: 404,));
          // act
          final call = groupMessageTypeRemoteDataSourceImpl
              .removeGroupMessageTypeRemote;
          // assert
          expect(() => call(messageId), throwsA(isA<ServerException>()));
        });
  });

  group("getGroupMessageTypeRemote", () {
    test("should perform a POST request", () async {
      // arrange
      when(mockDio.post(Constants.getGroupMessageTypeApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.decode(testJson), statusCode: 200,));
      // act
      groupMessageTypeRemoteDataSourceImpl
          .getGroupMessageTypeRemote(messageId);
      // assert
      verify(mockDio.post(Constants.getGroupMessageTypeApiUrl,
        data: json.encode({
          "messageId": messageId,
        }),
      ));
    });

    test(
        "should return a groupMessageType when the response code is 200",
            () async {
      // arrange
      when(mockDio.post(Constants.getGroupMessageTypeApiUrl,
        data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.decode(testJson), statusCode: 200,));
      // act
      final result = await groupMessageTypeRemoteDataSourceImpl
          .getGroupMessageTypeRemote(messageId);
      // assert
      expect(result, equals(testGroupMessageTypeModel));
    });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockDio.post(Constants.getGroupMessageTypeApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(data: "Something went wrong",
                    statusCode: 404,));
          // act
          final call = groupMessageTypeRemoteDataSourceImpl
              .getGroupMessageTypeRemote;
          // assert
          expect(() => call(messageId), throwsA(isA<ServerException>()));
        });
  });

  group("saveGroupMessageTypeRemote", () {
    test("should perform a POST request", () async {
      // arrange
      when(mockDio.post(Constants.saveGroupMessageTypeApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.encode("Data Saved"), statusCode: 200,));
      // act
      groupMessageTypeRemoteDataSourceImpl
          .saveGroupMessageTypeRemote(testGroupMessageTypeModel);
      // assert
      verify(mockDio.post(Constants.saveGroupMessageTypeApiUrl,
        data: json.encode(
            testGroupMessageTypeModel
        ),
      ));
    });

    test(
        "should save a groupMessageType when the response code is 200",
            () async {
          // arrange
          when(mockDio.post(Constants.saveGroupMessageTypeApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(
                    data: json.encode("Data Saved"), statusCode: 200,));
          // act
          final result = await groupMessageTypeRemoteDataSourceImpl
              .saveGroupMessageTypeRemote(testGroupMessageTypeModel);
          // assert
          expect(result, equals(true));
        });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockDio.post(Constants.saveGroupMessageTypeApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(data: "Something went wrong",
                    statusCode: 404,));
          // act
          final call = groupMessageTypeRemoteDataSourceImpl
              .saveGroupMessageTypeRemote;
          // assert
          expect(() => call(testGroupMessageTypeModel),
              throwsA(isA<ServerException>()));
        });
  });

  group("updateAllGroupMessageTypesRemote", () {
    test("should perform a POST request", () async {
      // arrange
      when(mockDio.post(Constants.updateAllGroupMessageTypesApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.encode("Data Updated"), statusCode: 200,));
      // act
      groupMessageTypeRemoteDataSourceImpl
          .updateAllGroupMessageTypesRemote([testGroupMessageTypeModel]);
      // assert
      verify(mockDio.post(Constants.updateAllGroupMessageTypesApiUrl,
        data: json.encode(
            [testGroupMessageTypeModel]
        ),
      ));
    });

    test(
        "should update a groupMessageTypes list when the response code is 200",
            () async {
      // arrange
      when(mockDio.post(Constants.updateAllGroupMessageTypesApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.encode("Data Updated"), statusCode: 200,));
      // act
      final result = await groupMessageTypeRemoteDataSourceImpl
          .updateAllGroupMessageTypesRemote([testGroupMessageTypeModel]);
      // assert
      expect(result, equals(true));
    });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockDio.post(Constants.updateAllGroupMessageTypesApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(data: "Something went wrong",
                    statusCode: 404,));
          // act
          final call = groupMessageTypeRemoteDataSourceImpl
              .updateAllGroupMessageTypesRemote;
          // assert
          expect(() => call([testGroupMessageTypeModel]),
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
