

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/features/data/datasources/remote/message_remote_datasource.dart';
import 'package:messenger/features/data/models/message_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';


void main() {
  late MockDio mockDio;
  late MessageRemoteDataSourceImpl messageRemoteDataSourceImpl;

  final testJson = fixtureReader("message_model.json");
  final testMessageModel = MessageModel.fromJson(json.decode(testJson));

  final messageId = testMessageModel.messageId!;
  final senderPhoneNumber = testMessageModel.senderPhoneNumber!;
  final targetPhoneNumber = testMessageModel.targetPhoneNumber!;

  setUp(() {
    mockDio = MockDio();
    messageRemoteDataSourceImpl = MessageRemoteDataSourceImpl(dio: mockDio);
  });

  group("getAllMessagesRemote", () {
    test("should perform a POST request", () async {
      // arrange
      when(mockDio.post(Constants.getAllMessagesApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async => dioResponse(data: [testJson], statusCode: 200,));
      // act
      messageRemoteDataSourceImpl.getAllMessagesRemote(
          senderPhoneNumber,
          targetPhoneNumber
      );
      // assert
      verify(mockDio.post(Constants.getAllMessagesApiUrl,
        data: json.encode({
          "senderPhoneNumber": senderPhoneNumber,
          "targetPhoneNumber": targetPhoneNumber
        }),
      ));
    });

    test(
        "should return all messages when the response code is 200",
            () async {
          // arrange
          when(mockDio.post(Constants.getAllMessagesApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async => dioResponse(data: [testJson], statusCode: 200,));
          // act
          final result = await messageRemoteDataSourceImpl
              .getAllMessagesRemote(senderPhoneNumber, targetPhoneNumber);
          // assert
          expect(result, equals([testMessageModel]));
        });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockDio.post(Constants.getAllMessagesApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(data: "Something went wrong",
                    statusCode: 404,));
          // act
          final call = messageRemoteDataSourceImpl.getAllMessagesRemote;
          // assert
          expect(() => call(senderPhoneNumber, targetPhoneNumber),
              throwsA(isA<ServerException>()));
        });
  });

  group("removeMessageRemote", () {
    test("should perform a POST request", () async {
      // arrange
      when(mockDio.post(Constants.removeMessageApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.encode("Data Removed"), statusCode: 200,));
      // act
      messageRemoteDataSourceImpl.removeMessageRemote(messageId);
      // assert
      verify(mockDio.post(Constants.removeMessageApiUrl,
        data: json.encode({
          "messageId": messageId
        }),
      ));
    });

    test("should save a message when the response code is 200", () async {
      // arrange
      when(mockDio.post(Constants.removeMessageApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.encode("Data Removed"), statusCode: 200,));
      // act
      final result = await messageRemoteDataSourceImpl
          .removeMessageRemote(messageId);
      // assert
      expect(result, equals(true));
    });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockDio.post(Constants.removeMessageApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(data: "Something went wrong",
                    statusCode: 404,));
          // act
          final call = messageRemoteDataSourceImpl.removeMessageRemote;
          // assert
          expect(() => call(messageId), throwsA(isA<ServerException>()));
        });
  });

  group("getMessageRemote", () {
    test("should perform a POST request", () async {
      // arrange
      when(mockDio.post(Constants.getMessageApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.decode(testJson), statusCode: 200,));
      // act
      messageRemoteDataSourceImpl.getMessageRemote(messageId);
      // assert
      verify(mockDio.post(Constants.getMessageApiUrl,
        data: json.encode({
          "messageId": messageId,
        }),
      ));
    });

    test(
        "should return a message model when the response code is 200", () async {
      // arrange
      when(mockDio.post(Constants.getMessageApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.decode(testJson), statusCode: 200,));
      // act
      final result = await messageRemoteDataSourceImpl
          .getMessageRemote(messageId);
      // assert
      expect(result, equals(testMessageModel));
    });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockDio.post(Constants.getMessageApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(data: "Something went wrong",
                    statusCode: 404,));
          // act
          final call = messageRemoteDataSourceImpl.getMessageRemote;
          // assert
          expect(() => call(messageId), throwsA(isA<ServerException>()));
        });
  });

  group("getMissedMessagesRemote", () {
    test("should perform a POST request", () async {
      // arrange
      when(mockDio.post(Constants.getMissedMessagesApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async => dioResponse(data: [testJson], statusCode: 200,));
      // act
      messageRemoteDataSourceImpl.getMissedMessagesRemote(targetPhoneNumber);
      // assert
      verify(mockDio.post(Constants.getMissedMessagesApiUrl,
        data: json.encode({
          "targetPhoneNumber": targetPhoneNumber
        }),
      ));
    });
    test(
        "should return missedMessages when the response code is 200",
            () async {
      // arrange
      when(mockDio.post(Constants.getMissedMessagesApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async => dioResponse(data: [testJson], statusCode: 200,));
      // act
      final result = await messageRemoteDataSourceImpl
          .getMissedMessagesRemote(targetPhoneNumber);
      // assert
      expect(result, equals([testMessageModel]));
    });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockDio.post(Constants.getMissedMessagesApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(data: "Something went wrong",
                    statusCode: 404,));
          // act
          final call = messageRemoteDataSourceImpl.getMissedMessagesRemote;
          // assert
          expect(() => call(targetPhoneNumber), throwsA(isA<ServerException>()));
        });
  });

  group("saveMessageRemote", () {
    test("should perform a POST request", () async {
      // arrange
      when(mockDio.post(Constants.saveMessageApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.encode("Data Saved"), statusCode: 200,));
      // act
      messageRemoteDataSourceImpl.saveMessageRemote(testMessageModel);
      // assert
      verify(mockDio.post(Constants.saveMessageApiUrl,
        data: json.encode(
            testMessageModel
        ),
      ));
    });

    test("should save a message when the response code is 200", () async {
      // arrange
      when(mockDio.post(Constants.saveMessageApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.encode("Data Saved"), statusCode: 200,));
      // act
      final result = await messageRemoteDataSourceImpl
          .saveMessageRemote(testMessageModel);
      // assert
      expect(result, equals(true));
    });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockDio.post(Constants.saveMessageApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(data: "Something went wrong",
                    statusCode: 404,));
          // act
          final call = messageRemoteDataSourceImpl.saveMessageRemote;
          // assert
          expect(() => call(testMessageModel), throwsA(isA<ServerException>()));
        });
  });

  group("updateAllMessagesRemote", () {
    test("should perform a POST request", () async {
      // arrange
      when(mockDio.post(Constants.updateAllMessagesApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.encode("Data Updated"), statusCode: 200,));
      // act
      messageRemoteDataSourceImpl.updateAllMessagesRemote([testMessageModel]);
      // assert
      verify(mockDio.post(Constants.updateAllMessagesApiUrl,
        data: json.encode(
            [testMessageModel]
        ),
      ));
    });

    test(
        "should update a messages list when the response code is 200",
            () async {
      // arrange
      when(mockDio.post(Constants.updateAllMessagesApiUrl,
          data: anyNamed("data"))).thenAnswer(
              (_) async =>
              dioResponse(data: json.encode("Data Updated"), statusCode: 200,));
      // act
      final result = await messageRemoteDataSourceImpl
          .updateAllMessagesRemote([testMessageModel]);
      // assert
      expect(result, equals(true));
    });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          // arrange
          when(mockDio.post(Constants.updateAllMessagesApiUrl,
              data: anyNamed("data"))).thenAnswer(
                  (_) async =>
                  dioResponse(data: "Something went wrong",
                    statusCode: 404,));
          // act
          final call = messageRemoteDataSourceImpl.updateAllMessagesRemote;
          // assert
          expect(() => call([testMessageModel]),
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
