

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/features/data/datasources/local/group_message_local_datasource.dart';
import 'package:messenger/features/data/models/group_message_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDatabaseHelper mockDatabaseHelper;
  late GroupMessageLocalDataSourceImpl groupMessageLocalDataSourceImpl;

  final testJson = fixtureReader("group_message_model.json");
  final testGroupMessageModel = GroupMessageModel.fromJson(json.decode(testJson));
  String groupId = testGroupMessageModel.groupId.toString();
  String messageId = testGroupMessageModel.messageId.toString();
  String senderPhoneNumber = testGroupMessageModel.senderPhoneNumber.toString();

  setUp(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    groupMessageLocalDataSourceImpl = GroupMessageLocalDataSourceImpl(mockDatabaseHelper);
  });

  group('existGroupMessageLocal', () {
    test('should return true when groupMessage exist in database',
            () async {
          // arrange
          when(mockDatabaseHelper.existGroupMessageLocal(any))
              .thenAnswer((_) async => true);
          // act
          groupMessageLocalDataSourceImpl.existGroupMessageLocal(messageId);
          // assert
          verify(mockDatabaseHelper.existGroupMessageLocal(messageId));
        });
    test('should throw DatabaseException when groupMessage exist is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.existGroupMessageLocal(any))
              .thenThrow(Exception());
          // act
          final call = groupMessageLocalDataSourceImpl.existGroupMessageLocal;
          // assert
          expect(() => call(messageId), throwsA(isA<DatabaseException>()));
        });
  });

  group('getAllGroupMessagesLocal', () {
    test('should return all groupMessages',
            () async {
          // arrange
          when(mockDatabaseHelper.getAllGroupMessagesLocal(any))
              .thenAnswer((_) async => [testGroupMessageModel]);
          // act
          groupMessageLocalDataSourceImpl.getAllGroupMessagesLocal(groupId);
          // assert
          verify(mockDatabaseHelper.getAllGroupMessagesLocal(groupId));
        });
    test('should throw DatabaseException when getAllGroupMessages is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.getAllGroupMessagesLocal(any))
              .thenThrow(Exception());
          // act
          final call = groupMessageLocalDataSourceImpl.getAllGroupMessagesLocal;
          // assert
          expect(() => call(groupId), throwsA(isA<DatabaseException>()));
        });
  });

  group('getGroupMessageLocal', () {
    test('should return a groupMessage model',
            () async {
          // arrange
          when(mockDatabaseHelper.getGroupMessageLocal(any))
              .thenAnswer((_) async => testGroupMessageModel);
          // act
          groupMessageLocalDataSourceImpl.getGroupMessageLocal(messageId);
          // assert
          verify(mockDatabaseHelper.getGroupMessageLocal(messageId));
        });
    test('should throw DatabaseException when getGroupMessage is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.getGroupMessageLocal(any))
              .thenThrow(Exception());
          // act
          final call = groupMessageLocalDataSourceImpl.getGroupMessageLocal;
          // assert
          expect(() => call(messageId), throwsA(isA<DatabaseException>()));
        });
  });

  group('removeGroupMessageLocal', () {
    test('should return true when remove from database is success',
            () async {
          // arrange
          when(mockDatabaseHelper.removeGroupMessageLocal(any))
              .thenAnswer((_) async => true);
          // act
          groupMessageLocalDataSourceImpl.removeGroupMessageLocal(messageId);
          // assert
          verify(mockDatabaseHelper.removeGroupMessageLocal(messageId));
        });
    test('should throw DatabaseException when remove from database is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.removeGroupMessageLocal(any))
              .thenThrow(Exception());
          // act
          final call = groupMessageLocalDataSourceImpl.removeGroupMessageLocal;
          // assert
          expect(() => call(messageId), throwsA(isA<DatabaseException>()));
        });
  });

  group('saveGroupMessageLocal', () {
    test('should return true when save to database is success',
            () async {
          // arrange
          when(mockDatabaseHelper.saveGroupMessageLocal(any))
              .thenAnswer((_) async => true);
          // act
          groupMessageLocalDataSourceImpl.saveGroupMessageLocal(testGroupMessageModel);
          // assert
          verify(mockDatabaseHelper.saveGroupMessageLocal(testGroupMessageModel));
        });
    test('should throw DatabaseException when save to database is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.saveGroupMessageLocal(any))
              .thenThrow(Exception());
          // act
          final call = groupMessageLocalDataSourceImpl.saveGroupMessageLocal;
          // assert
          expect(() => call(testGroupMessageModel), throwsA(isA<DatabaseException>()));
        });
  });

  group('getAllUnsendGroupMessagesLocal', () {
    test('should return all unSendGroupMessages',
            () async {
          // arrange
          when(mockDatabaseHelper.getAllUnsendGroupMessagesLocal(any))
              .thenAnswer((_) async => [testGroupMessageModel]);
          // act
          groupMessageLocalDataSourceImpl.getAllUnsendGroupMessagesLocal(senderPhoneNumber);
          // assert
          verify(mockDatabaseHelper.getAllUnsendGroupMessagesLocal(senderPhoneNumber));
        });
    test('should throw DatabaseException when getAllUnsendGroupMessages is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.getAllUnsendGroupMessagesLocal(any))
              .thenThrow(Exception());
          // act
          final call = groupMessageLocalDataSourceImpl.getAllUnsendGroupMessagesLocal;
          // assert
          expect(() => call(senderPhoneNumber), throwsA(isA<DatabaseException>()));
        });
  });
}