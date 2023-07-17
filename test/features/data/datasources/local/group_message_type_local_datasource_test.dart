

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/features/data/datasources/local/group_message_type_local_datasource.dart';
import 'package:messenger/features/data/models/group_message_type_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDatabaseHelper mockDatabaseHelper;
  late GroupMessageTypeLocalDataSourceImpl groupMessageTypeLocalDataSourceImpl;

  final testJson = fixtureReader("group_message_type_model.json");
  final testGroupMessageTypeModel = GroupMessageTypeModel.fromJson(json.decode(testJson));
  String groupId = testGroupMessageTypeModel.groupId.toString();
  String messageId = testGroupMessageTypeModel.messageId.toString();
  String receiverPhoneNumber = testGroupMessageTypeModel.receiverPhoneNumber.toString();


  setUp(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    groupMessageTypeLocalDataSourceImpl = GroupMessageTypeLocalDataSourceImpl(mockDatabaseHelper);
  });

  group('existGroupMessageTypeLocal', () {
    test('should return true when groupMessageType exist in database',
            () async {
          // arrange
          when(mockDatabaseHelper.existGroupMessageTypeLocal(any))
              .thenAnswer((_) async => true);
          // act
          groupMessageTypeLocalDataSourceImpl.existGroupMessageTypeLocal(messageId);
          // assert
          verify(mockDatabaseHelper.existGroupMessageTypeLocal(messageId));
        });
    test('should throw DatabaseException when groupMessageType exist is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.existGroupMessageTypeLocal(any))
              .thenThrow(Exception());
          // act
          final call = groupMessageTypeLocalDataSourceImpl.existGroupMessageTypeLocal;
          // assert
          expect(() => call(messageId), throwsA(isA<DatabaseException>()));
        });
  });

  group('getAllGroupMessageTypesLocal', () {
    test('should return all groupMessageTypes',
            () async {
          // arrange
          when(mockDatabaseHelper.getAllGroupMessageTypesLocal(any, any))
              .thenAnswer((_) async => [testGroupMessageTypeModel]);
          // act
          groupMessageTypeLocalDataSourceImpl.getAllGroupMessageTypesLocal(groupId, messageId);
          // assert
          verify(mockDatabaseHelper.getAllGroupMessageTypesLocal(groupId, messageId));
        });
    test('should throw DatabaseException when getAllGroupMessageTypes is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.getAllGroupMessageTypesLocal(any, any))
              .thenThrow(Exception());
          // act
          final call = groupMessageTypeLocalDataSourceImpl.getAllGroupMessageTypesLocal;
          // assert
          expect(() => call(groupId, messageId), throwsA(isA<DatabaseException>()));
        });
  });

  group('getGroupMessageTypeLocal', () {
    test('should return a groupMessageType model',
            () async {
          // arrange
          when(mockDatabaseHelper.getGroupMessageTypeLocal(any))
              .thenAnswer((_) async => testGroupMessageTypeModel);
          // act
          groupMessageTypeLocalDataSourceImpl.getGroupMessageTypeLocal(messageId);
          // assert
          verify(mockDatabaseHelper.getGroupMessageTypeLocal(messageId));
        });
    test('should throw DatabaseException when getGroupMessageType is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.getGroupMessageTypeLocal(any))
              .thenThrow(Exception());
          // act
          final call = groupMessageTypeLocalDataSourceImpl.getGroupMessageTypeLocal;
          // assert
          expect(() => call(messageId), throwsA(isA<DatabaseException>()));
        });
  });

  group('removeGroupMessageTypeLocal', () {
    test('should return true when remove from database is success',
            () async {
          // arrange
          when(mockDatabaseHelper.removeGroupMessageTypeLocal(any))
              .thenAnswer((_) async => true);
          // act
          groupMessageTypeLocalDataSourceImpl.removeGroupMessageTypeLocal(messageId);
          // assert
          verify(mockDatabaseHelper.removeGroupMessageTypeLocal(messageId));
        });
    test('should throw DatabaseException when remove from database is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.removeGroupMessageTypeLocal(any))
              .thenThrow(Exception());
          // act
          final call = groupMessageTypeLocalDataSourceImpl.removeGroupMessageTypeLocal;
          // assert
          expect(() => call(messageId), throwsA(isA<DatabaseException>()));
        });
  });

  group('saveGroupMessageTypeLocal', () {
    test('should return true when save to database is success',
            () async {
          // arrange
          when(mockDatabaseHelper.saveGroupMessageTypeLocal(any))
              .thenAnswer((_) async => true);
          // act
          groupMessageTypeLocalDataSourceImpl.saveGroupMessageTypeLocal(testGroupMessageTypeModel);
          // assert
          verify(mockDatabaseHelper.saveGroupMessageTypeLocal(testGroupMessageTypeModel));
        });
    test('should throw DatabaseException when save to database is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.saveGroupMessageTypeLocal(any))
              .thenThrow(Exception());
          // act
          final call = groupMessageTypeLocalDataSourceImpl.saveGroupMessageTypeLocal;
          // assert
          expect(() => call(testGroupMessageTypeModel), throwsA(isA<DatabaseException>()));
        });
  });

  group('getAllUnsendGroupMessageTypesLocal', () {
    test('should return all unSendGroupMessageTypes',
            () async {
          // arrange
          when(mockDatabaseHelper.getAllUnsendGroupMessageTypesLocal(any))
              .thenAnswer((_) async => [testGroupMessageTypeModel]);
          // act
          groupMessageTypeLocalDataSourceImpl.getAllUnsendGroupMessageTypesLocal(groupId);
          // assert
          verify(mockDatabaseHelper.getAllUnsendGroupMessageTypesLocal(groupId));
        });
    test('should throw DatabaseException when getAllUnsendGroupMessageTypes is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.getAllUnsendGroupMessageTypesLocal(any))
              .thenThrow(Exception());
          // act
          final call = groupMessageTypeLocalDataSourceImpl.getAllUnsendGroupMessageTypesLocal;
          // assert
          expect(() => call(groupId), throwsA(isA<DatabaseException>()));
        });
  });

  group('getAllNotReadGroupMessageTypesLocal', () {
    test('should return all notReadGroupMessageTypes',
            () async {
          // arrange
          when(mockDatabaseHelper.getAllNotReadGroupMessageTypesLocal(any))
              .thenAnswer((_) async => [testGroupMessageTypeModel]);
          // act
          groupMessageTypeLocalDataSourceImpl.getAllNotReadGroupMessageTypesLocal(receiverPhoneNumber);
          // assert
          verify(mockDatabaseHelper.getAllNotReadGroupMessageTypesLocal(receiverPhoneNumber));
        });
    test('should throw DatabaseException when getAllNotReadGroupMessageTypes save is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.getAllNotReadGroupMessageTypesLocal(any))
              .thenThrow(Exception());
          // act
          final call = groupMessageTypeLocalDataSourceImpl.getAllNotReadGroupMessageTypesLocal;
          // assert
          expect(() => call(receiverPhoneNumber), throwsA(isA<DatabaseException>()));
        });
  });
}