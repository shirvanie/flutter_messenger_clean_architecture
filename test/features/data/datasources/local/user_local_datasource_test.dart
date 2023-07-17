

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/features/data/datasources/local/user_local_datasource.dart';
import 'package:messenger/features/data/models/user_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';


void main() {
  late MockDatabaseHelper mockDatabaseHelper;
  late UserLocalDataSourceImpl userLocalDataSourceImpl;

  final testJson = fixtureReader("user_model.json");
  final testUserModel = UserModel.fromJson(json.decode(testJson));
  String userPhoneNumber = testUserModel.userPhoneNumber.toString();


  setUp(() async{
    mockDatabaseHelper = MockDatabaseHelper();
    userLocalDataSourceImpl = UserLocalDataSourceImpl(mockDatabaseHelper);
  });

  group('existUserLocal', () {
    test('should return true when user exist in database',
      () async {
      // arrange
      when(mockDatabaseHelper.existUserLocal(any))
          .thenAnswer((_) async => true);
      // act
      userLocalDataSourceImpl.existUserLocal(userPhoneNumber);
      // assert
      verify(mockDatabaseHelper.existUserLocal(userPhoneNumber));
    });
    test('should throw DatabaseException when user exist is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.existUserLocal(any))
          .thenThrow(Exception());
      // act
      final call = userLocalDataSourceImpl.existUserLocal;
      // assert
      expect(() => call(userPhoneNumber), throwsA(isA<DatabaseException>()));
    });
  });

  group('getAllUsersLocal', () {
    test('should return all users',
      () async {
      // arrange
      when(mockDatabaseHelper.getAllUsersLocal())
          .thenAnswer((_) async => [testUserModel]);
      // act
      userLocalDataSourceImpl.getAllUsersLocal();
      // assert
      verify(mockDatabaseHelper.getAllUsersLocal());
    });
    test('should throw DatabaseException when getAllUsers is failed',
      () async {
      // arrange
      when(mockDatabaseHelper.getAllUsersLocal())
          .thenThrow(Exception());
      // act
      final call = userLocalDataSourceImpl.getAllUsersLocal;
      // assert
      expect(() => call(), throwsA(isA<DatabaseException>()));
    });
  });

  group('getUserLocal', () {
    test('should return a user model',
        () async {
      // arrange
      when(mockDatabaseHelper.getUserLocal(any))
          .thenAnswer((_) async => testUserModel);
      // act
      userLocalDataSourceImpl.getUserLocal(userPhoneNumber);
      // assert
      verify(mockDatabaseHelper.getUserLocal(userPhoneNumber));
    });
    test('should throw DatabaseException when getUser is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.getUserLocal(any))
          .thenThrow(Exception());
      // act
      final call = userLocalDataSourceImpl.getUserLocal;
      // assert
      expect(() => call(userPhoneNumber), throwsA(isA<DatabaseException>()));
    });
  });

  group('removeUserLocal', () {
    test('should return true when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeUserLocal(any))
          .thenAnswer((_) async => true);
      // act
      userLocalDataSourceImpl.removeUserLocal(userPhoneNumber);
      // assert
      verify(mockDatabaseHelper.removeUserLocal(userPhoneNumber));
    });
    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeUserLocal(any))
          .thenThrow(Exception());
      // act
      final call = userLocalDataSourceImpl.removeUserLocal;
      // assert
      expect(() => call(userPhoneNumber), throwsA(isA<DatabaseException>()));
    });
  });

  group('saveUserLocal', () {
    test('should return true when save to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.saveUserLocal(any))
          .thenAnswer((_) async => true);
      // act
      userLocalDataSourceImpl.saveUserLocal(testUserModel);
      // assert
      verify(mockDatabaseHelper.saveUserLocal(testUserModel));
    });
    test('should throw DatabaseException when save to database is failed',
          () async {
        // arrange
        when(mockDatabaseHelper.saveUserLocal(any))
            .thenThrow(Exception());
        // act
        final call = userLocalDataSourceImpl.saveUserLocal;
        // assert
        expect(() => call(testUserModel), throwsA(isA<DatabaseException>()));
      });
  });
}
