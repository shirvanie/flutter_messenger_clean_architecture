

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/features/data/datasources/local/message_local_datasource.dart';
import 'package:messenger/features/data/models/message_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDatabaseHelper mockDatabaseHelper;
  late MessageLocalDataSourceImpl messageLocalDataSourceImpl;

  final testJson = fixtureReader("message_model.json");
  final testMessageModel = MessageModel.fromJson(json.decode(testJson));
  String messageId = testMessageModel.messageId.toString();
  String senderPhoneNumber = testMessageModel.senderPhoneNumber.toString();
  String targetPhoneNumber = testMessageModel.targetPhoneNumber.toString();


  setUp(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    messageLocalDataSourceImpl = MessageLocalDataSourceImpl(mockDatabaseHelper);
  });


  group('existMessageLocal', () {
    test('should return true when message exist in database',
        () async {
      // arrange
      when(mockDatabaseHelper.existMessageLocal(any))
          .thenAnswer((_) async => true);
      // act
      messageLocalDataSourceImpl.existMessageLocal(messageId);
      // assert
      verify(mockDatabaseHelper.existMessageLocal(messageId));
    });
    test('should throw DatabaseException when message exist is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.existMessageLocal(any))
              .thenThrow(Exception());
          // act
          final call = messageLocalDataSourceImpl.existMessageLocal;
          // assert
          expect(() => call(messageId), throwsA(isA<DatabaseException>()));
        });
  });

  group('getAllMessagesLocal', () {
    test('should return all messages',
            () async {
          // arrange
          when(mockDatabaseHelper.getAllMessagesLocal(any, any))
              .thenAnswer((_) async => [testMessageModel]);
          // act
          messageLocalDataSourceImpl.getAllMessagesLocal(senderPhoneNumber, targetPhoneNumber);
          // assert
          verify(mockDatabaseHelper.getAllMessagesLocal(senderPhoneNumber, targetPhoneNumber));
        });
    test('should throw DatabaseException when getAllMessages is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.getAllMessagesLocal(any, any))
              .thenThrow(Exception());
          // act
          final call = messageLocalDataSourceImpl.getAllMessagesLocal;
          // assert
          expect(() => call(senderPhoneNumber, targetPhoneNumber), throwsA(isA<DatabaseException>()));
        });
  });

  group('getMessageLocal', () {
    test('should return a message model',
            () async {
          // arrange
          when(mockDatabaseHelper.getMessageLocal(any))
              .thenAnswer((_) async => testMessageModel);
          // act
          messageLocalDataSourceImpl.getMessageLocal(messageId);
          // assert
          verify(mockDatabaseHelper.getMessageLocal(messageId));
        });
    test('should throw DatabaseException when getMessage is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.getMessageLocal(any))
              .thenThrow(Exception());
          // act
          final call = messageLocalDataSourceImpl.getMessageLocal;
          // assert
          expect(() => call(messageId), throwsA(isA<DatabaseException>()));
        });
  });

  group('removeMessageLocal', () {
    test('should return true when remove from database is success',
            () async {
          // arrange
          when(mockDatabaseHelper.removeMessageLocal(any))
              .thenAnswer((_) async => true);
          // act
          messageLocalDataSourceImpl.removeMessageLocal(messageId);
          // assert
          verify(mockDatabaseHelper.removeMessageLocal(messageId));
        });
    test('should throw DatabaseException when remove from database is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.removeMessageLocal(any))
              .thenThrow(Exception());
          // act
          final call = messageLocalDataSourceImpl.removeMessageLocal;
          // assert
          expect(() => call(messageId), throwsA(isA<DatabaseException>()));
        });
  });

  group('saveMessageLocal', () {
    test('should return true when save to database is success',
            () async {
          // arrange
          when(mockDatabaseHelper.saveMessageLocal(any))
              .thenAnswer((_) async => true);
          // act
          messageLocalDataSourceImpl.saveMessageLocal(testMessageModel);
          // assert
          verify(mockDatabaseHelper.saveMessageLocal(testMessageModel));
        });
    test('should throw DatabaseException when save to database is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.saveMessageLocal(any))
              .thenThrow(Exception());
          // act
          final call = messageLocalDataSourceImpl.saveMessageLocal;
          // assert
          expect(() => call(testMessageModel), throwsA(isA<DatabaseException>()));
        });
  });

  group('getAllUnsendMessagesLocal', () {
    test('should return all unSendMessages',
            () async {
          // arrange
          when(mockDatabaseHelper.getAllUnsendMessagesLocal())
              .thenAnswer((_) async => [testMessageModel]);
          // act
          messageLocalDataSourceImpl.getAllUnsendMessagesLocal();
          // assert
          verify(mockDatabaseHelper.getAllUnsendMessagesLocal());
        });
    test('should throw DatabaseException when getAllUnsendMessages is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.getAllUnsendMessagesLocal())
              .thenThrow(Exception());
          // act
          final call = messageLocalDataSourceImpl.getAllUnsendMessagesLocal;
          // assert
          expect(() => call(), throwsA(isA<DatabaseException>()));
        });
  });

  group('getAllNotReadMessagesLocal', () {
    test('should return all notReadMessages',
            () async {
          // arrange
          when(mockDatabaseHelper.getAllNotReadMessagesLocal(any, any))
              .thenAnswer((_) async => [testMessageModel]);
          // act
          messageLocalDataSourceImpl.getAllNotReadMessagesLocal(senderPhoneNumber, targetPhoneNumber);
          // assert
          verify(mockDatabaseHelper.getAllNotReadMessagesLocal(senderPhoneNumber, targetPhoneNumber));
        });
    test('should throw DatabaseException when getAllNotReadMessages is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.getAllNotReadMessagesLocal(any, any))
              .thenThrow(Exception());
          // act
          final call = messageLocalDataSourceImpl.getAllNotReadMessagesLocal;
          // assert
          expect(() => call(senderPhoneNumber, targetPhoneNumber), throwsA(isA<DatabaseException>()));
        });
  });
}