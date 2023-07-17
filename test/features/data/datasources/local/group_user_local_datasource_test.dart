

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/features/data/datasources/local/group_user_local_datasource.dart';
import 'package:messenger/features/data/models/group_user_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDatabaseHelper mockDatabaseHelper;
  late GroupUserLocalDataSourceImpl groupUserLocalDataSourceImpl;

  final testJson = fixtureReader("group_user_model.json");
  final testGroupUserModel = GroupUserModel.fromJson(json.decode(testJson));
  String groupId = testGroupUserModel.groupId.toString();
  String userPhoneNumber = testGroupUserModel.userPhoneNumber.toString();


  setUp(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    groupUserLocalDataSourceImpl = GroupUserLocalDataSourceImpl(mockDatabaseHelper);
  });

  group('getAllGroupUsersLocal', () {
    test('should return all groupUsers',
            () async {
          // arrange
          when(mockDatabaseHelper.getAllGroupUsersLocal(any))
              .thenAnswer((_) async => [testGroupUserModel]);
          // act
          groupUserLocalDataSourceImpl.getAllGroupUsersLocal(groupId);
          // assert
          verify(mockDatabaseHelper.getAllGroupUsersLocal(groupId));
        });
    test('should throw DatabaseException when get allGroupUsers is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.getAllGroupUsersLocal(any))
              .thenThrow(Exception());
          // act
          final call = groupUserLocalDataSourceImpl.getAllGroupUsersLocal;
          // assert
          expect(() => call(groupId), throwsA(isA<DatabaseException>()));
        });
  });

  group('getGroupUserLocal', () {
    test('should return a group user model',
            () async {
          // arrange
          when(mockDatabaseHelper.getGroupUserLocal(any, any))
              .thenAnswer((_) async => testGroupUserModel);
          // act
          groupUserLocalDataSourceImpl.getGroupUserLocal(groupId, userPhoneNumber);
          // assert
          verify(mockDatabaseHelper.getGroupUserLocal(groupId, userPhoneNumber));
        });
    test('should throw DatabaseException when getGroupUser is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.getGroupUserLocal(any, any))
              .thenThrow(Exception());
          // act
          final call = groupUserLocalDataSourceImpl.getGroupUserLocal;
          // assert
          expect(() => call(groupId, userPhoneNumber), throwsA(isA<DatabaseException>()));
        });
  });

  group('removeGroupUserLocal', () {
    test('should return true when remove from database is success',
            () async {
          // arrange
          when(mockDatabaseHelper.removeGroupUserLocal(any, any))
              .thenAnswer((_) async => true);
          // act
          groupUserLocalDataSourceImpl.removeGroupUserLocal(groupId, userPhoneNumber);
          // assert
          verify(mockDatabaseHelper.removeGroupUserLocal(groupId, userPhoneNumber));
        });
    test('should throw DatabaseException when remove from database is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.removeGroupUserLocal(any, any))
              .thenThrow(Exception());
          // act
          final call = groupUserLocalDataSourceImpl.removeGroupUserLocal;
          // assert
          expect(() => call(groupId, userPhoneNumber), throwsA(isA<DatabaseException>()));
        });
  });

  group('saveGroupUserLocal', () {
    test('should return true when save to database is success',
            () async {
          // arrange
          when(mockDatabaseHelper.saveGroupUserLocal(any))
              .thenAnswer((_) async => true);
          // act
          groupUserLocalDataSourceImpl.saveGroupUserLocal(testGroupUserModel);
          // assert
          verify(mockDatabaseHelper.saveGroupUserLocal(testGroupUserModel));
        });
    test('should throw DatabaseException when save to database is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.saveGroupUserLocal(any))
              .thenThrow(Exception());
          // act
          final call = groupUserLocalDataSourceImpl.saveGroupUserLocal;
          // assert
          expect(() => call(testGroupUserModel), throwsA(isA<DatabaseException>()));
        });
  });
}