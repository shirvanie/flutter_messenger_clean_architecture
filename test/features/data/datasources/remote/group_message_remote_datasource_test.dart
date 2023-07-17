

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/features/data/datasources/remote/group_message_remote_datasource.dart';
import 'package:messenger/features/data/models/group_message_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';


void main() {
  late MockDio mockDio;
  late GroupMessageRemoteDataSourceImpl groupMessageRemoteDataSourceImpl;

  final testJson = fixtureReader("group_message_model.json");
  final testGroupMessageModel = GroupMessageModel
      .fromJson(json.decode(testJson));

  final messageId = testGroupMessageModel.messageId!;
  final groupId = testGroupMessageModel.groupId!;
  final receiverPhoneNumber = testGroupMessageModel.senderPhoneNumber!;

  setUp(() {
    mockDio = MockDio();
    groupMessageRemoteDataSourceImpl =
        GroupMessageRemoteDataSourceImpl(dio: mockDio);
  });

  group("getAllGroupMessagesRemote", () {
    test("should perform a POST request", () async {
      // arrange
      when(mockDio.post(Constants.getAllGroupMessagesApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async => dioResponse(data: [testJson], statusCode: 200,));
      // act
      groupMessageRemoteDataSourceImpl.getAllGroupMessagesRemote(groupId);
      // assert
      verify(mockDio.post(Constants.getAllGroupMessagesApiUrl,
        data: json.encode({
          "groupId": groupId,
        }),
      ));
    });

    test(
        "should return all groupMessages when the response code is 200",
            () async {
          // arrange
          when(mockDio.post(Constants.getAllGroupMessagesApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async => dioResponse(data: [testJson], statusCode: 200,));
          // act
          final result = await groupMessageRemoteDataSourceImpl
              .getAllGroupMessagesRemote(groupId);
          // assert
          expect(result, equals([testGroupMessageModel]));
        });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockDio.post(Constants.getAllGroupMessagesApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(data: "Something went wrong",
                    statusCode: 404,));
          // act
          final call = groupMessageRemoteDataSourceImpl
              .getAllGroupMessagesRemote;
          // assert
          expect(() => call(groupId), throwsA(isA<ServerException>()));
        });
  });

  group("removeGroupMessageRemote", () {
    test("should perform a POST request", () async {
      // arrange
      when(mockDio.post(Constants.removeGroupMessageApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.encode("Data Removed"), statusCode: 200,));
      // act
      groupMessageRemoteDataSourceImpl.removeGroupMessageRemote(messageId);
      // assert
      verify(mockDio.post(Constants.removeGroupMessageApiUrl,
        data: json.encode({
          "messageId": messageId
        }),
      ));
    });

    test(
        "should remove a groupMessage when the response code is 200", () async {
      // arrange
      when(mockDio.post(Constants.removeGroupMessageApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.encode("Data Removed"), statusCode: 200,));
      // act
      final result = await groupMessageRemoteDataSourceImpl
          .removeGroupMessageRemote(messageId);
      // assert
      expect(result, equals(true));
    });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockDio.post(Constants.removeGroupMessageApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(data: "Something went wrong",
                    statusCode: 404,));
          // act
          final call = groupMessageRemoteDataSourceImpl
              .removeGroupMessageRemote;
          // assert
          expect(() => call(messageId), throwsA(isA<ServerException>()));
        });
  });

  group("getGroupMessageRemote", () {
    test("should perform a POST request", () async {
      // arrange
      when(mockDio.post(Constants.getGroupMessageApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.decode(testJson), statusCode: 200,));
      // act
      groupMessageRemoteDataSourceImpl.getGroupMessageRemote(messageId);
      // assert
      verify(mockDio.post(Constants.getGroupMessageApiUrl,
        data: json.encode({
          "messageId": messageId,
        }),
      ));
    });

    test(
        "should return a groupMessage model when the response code is 200", () async {
      // arrange
      when(mockDio.post(Constants.getGroupMessageApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.decode(testJson), statusCode: 200,));
      // act
      final result = await groupMessageRemoteDataSourceImpl
          .getGroupMessageRemote(messageId);
      // assert
      expect(result, equals(testGroupMessageModel));
    });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockDio.post(Constants.getGroupMessageApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(data: "Something went wrong",
                    statusCode: 404,));
          // act
          final call = groupMessageRemoteDataSourceImpl.getGroupMessageRemote;
          // assert
          expect(() => call(messageId), throwsA(isA<ServerException>()));
        });
  });

  group("getMissedGroupMessagesRemote", () {
    test("should perform a POST request", () async {
      // arrange
      when(mockDio.post(Constants.getMissedGroupMessagesApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async => dioResponse(data: [testJson], statusCode: 200,));
      // act
      groupMessageRemoteDataSourceImpl
          .getMissedGroupMessagesRemote(groupId, receiverPhoneNumber);
      // assert
      verify(mockDio.post(Constants.getMissedGroupMessagesApiUrl,
        data: json.encode({
          "groupId": groupId,
          "receiverPhoneNumber": receiverPhoneNumber
        }),
      ));
    });
    test(
        "should return missedGroupMessages when the response code is 200"
            "the response code is 200", () async {
      // arrange
      when(mockDio.post(Constants.getMissedGroupMessagesApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async => dioResponse(data: [testJson], statusCode: 200,));
      // act
      final result = await groupMessageRemoteDataSourceImpl
          .getMissedGroupMessagesRemote(groupId, receiverPhoneNumber);
      // assert
      expect(result, equals([testGroupMessageModel]));
    });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockDio.post(Constants.getMissedGroupMessagesApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(data: "Something went wrong",
                    statusCode: 404,));
          // act
          final call = groupMessageRemoteDataSourceImpl
              .getMissedGroupMessagesRemote;
          // assert
          expect(() => call(groupId, receiverPhoneNumber),
              throwsA(isA<ServerException>()));
        });
  });

  group("saveGroupMessageRemote", () {
    test("should perform a POST request", () async {
      // arrange
      when(mockDio.post(Constants.saveGroupMessageApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.encode("Data Saved"), statusCode: 200,));
      // act
      groupMessageRemoteDataSourceImpl
          .saveGroupMessageRemote(testGroupMessageModel);
      // assert
      verify(mockDio.post(Constants.saveGroupMessageApiUrl,
        data: json.encode(
            testGroupMessageModel
        ),
      ));
    });

    test(
        "should save a groupMessage when the response code is 200",
            () async {
          // arrange
          when(mockDio.post(Constants.saveGroupMessageApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(
                    data: json.encode("Data Saved"), statusCode: 200,));
          // act
          final result = await groupMessageRemoteDataSourceImpl
              .saveGroupMessageRemote(testGroupMessageModel);
          // assert
          expect(result, equals(true));
        });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockDio.post(Constants.saveGroupMessageApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(data: "Something went wrong",
                    statusCode: 404,));
          // act
          final call = groupMessageRemoteDataSourceImpl.saveGroupMessageRemote;
          // assert
          expect(() => call(testGroupMessageModel),
              throwsA(isA<ServerException>()));
        });
  });

  group("updateAllGroupMessagesRemote", () {
    test("should perform a POST request", () async {
      // arrange
      when(mockDio.post(Constants.updateAllGroupMessagesApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.encode("Data Updated"), statusCode: 200,));
      // act
      groupMessageRemoteDataSourceImpl.updateAllGroupMessagesRemote(
          [testGroupMessageModel]);
      // assert
      verify(mockDio.post(Constants.updateAllGroupMessagesApiUrl,
        data: json.encode(
            [testGroupMessageModel]
        ),
      ));
    });

    test(
        "should update a groupMessages list when the response code is 200",
            () async {
      // arrange
      when(mockDio.post(Constants.updateAllGroupMessagesApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.encode("Data Updated"), statusCode: 200,));
      // act
      final result = await groupMessageRemoteDataSourceImpl
          .updateAllGroupMessagesRemote([testGroupMessageModel]);
      // assert
      expect(result, equals(true));
    });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockDio.post(Constants.updateAllGroupMessagesApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(data: "Something went wrong",
                    statusCode: 404,));
          // act
          final call = groupMessageRemoteDataSourceImpl
              .updateAllGroupMessagesRemote;
          // assert
          expect(() => call([testGroupMessageModel]),
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
