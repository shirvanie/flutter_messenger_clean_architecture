

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/features/data/datasources/local/group_local_datasource.dart';
import 'package:messenger/features/data/models/group_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDatabaseHelper mockDatabaseHelper;
  late GroupLocalDataSourceImpl groupLocalDataSourceImpl;

  final testJson = fixtureReader("group_model.json");
  final testGroupModel = GroupModel.fromJson(json.decode(testJson));
  String groupId = testGroupModel.groupId.toString();


  setUp(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    groupLocalDataSourceImpl = GroupLocalDataSourceImpl(mockDatabaseHelper);
  });

  group('getAllGroupsLocal', () {
    test('should return all groups',
            () async {
          // arrange
          when(mockDatabaseHelper.getAllGroupsLocal())
              .thenAnswer((_) async => [testGroupModel]);
          // act
          groupLocalDataSourceImpl.getAllGroupsLocal();
          // assert
          verify(mockDatabaseHelper.getAllGroupsLocal());
        });
    test('should throw DatabaseException when getAllGroups is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.getAllGroupsLocal())
              .thenThrow(Exception());
          // act
          final call = groupLocalDataSourceImpl.getAllGroupsLocal;
          // assert
          expect(() => call(), throwsA(isA<DatabaseException>()));
        });
  });

  group('getGroupLocal', () {
    test('should return a group model',
            () async {
          // arrange
          when(mockDatabaseHelper.getGroupLocal(any))
              .thenAnswer((_) async => testGroupModel);
          // act
          groupLocalDataSourceImpl.getGroupLocal(groupId);
          // assert
          verify(mockDatabaseHelper.getGroupLocal(groupId));
        });
    test('should throw DatabaseException when getGroup is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.getGroupLocal(any))
              .thenThrow(Exception());
          // act
          final call = groupLocalDataSourceImpl.getGroupLocal;
          // assert
          expect(() => call(groupId), throwsA(isA<DatabaseException>()));
        });
  });

  group('removeGroupLocal', () {
    test('should return true when remove from database is success',
            () async {
          // arrange
          when(mockDatabaseHelper.removeGroupLocal(any))
              .thenAnswer((_) async => true);
          // act
          groupLocalDataSourceImpl.removeGroupLocal(groupId);
          // assert
          verify(mockDatabaseHelper.removeGroupLocal(groupId));
        });
    test('should throw DatabaseException when remove from database is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.removeGroupLocal(any))
              .thenThrow(Exception());
          // act
          final call = groupLocalDataSourceImpl.removeGroupLocal;
          // assert
          expect(() => call(groupId), throwsA(isA<DatabaseException>()));
        });
  });

  group('saveGroupLocal', () {
    test('should return true when save to database is success',
            () async {
          // arrange
          when(mockDatabaseHelper.saveGroupLocal(any))
              .thenAnswer((_) async => true);
          // act
          groupLocalDataSourceImpl.saveGroupLocal(testGroupModel);
          // assert
          verify(mockDatabaseHelper.saveGroupLocal(testGroupModel));
        });
    test('should throw DatabaseException when save to database is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.saveGroupLocal(any))
              .thenThrow(Exception());
          // act
          final call = groupLocalDataSourceImpl.saveGroupLocal;
          // assert
          expect(() => call(testGroupModel), throwsA(isA<DatabaseException>()));
        });
  });
}