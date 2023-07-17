


import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/features/data/datasources/db/database_helper.dart';
import 'package:messenger/features/domain/entities/user_entity.dart';

abstract class UserLocalDataSource {
  Future<bool> existUserLocal(String userPhoneNumber);
  Future<List<UserEntity>> getAllUsersLocal();
  Future<UserEntity> getUserLocal(String userPhoneNumber);
  Future<bool> removeUserLocal(String userPhoneNumber);
  Future<bool> saveUserLocal(UserEntity userItem);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {

  final DatabaseHelper databaseHelper;
  UserLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<bool> existUserLocal(String userPhoneNumber) async {
    try{
      return await databaseHelper.existUserLocal(userPhoneNumber);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<List<UserEntity>> getAllUsersLocal() async {
    try{
      return await databaseHelper.getAllUsersLocal();
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<UserEntity> getUserLocal(String userPhoneNumber) async {
    try{
      return await databaseHelper.getUserLocal(userPhoneNumber);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<bool> removeUserLocal(String userPhoneNumber) async {
    try{
      return await databaseHelper.removeUserLocal(userPhoneNumber);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<bool> saveUserLocal(UserEntity userItem) async {
    try{
      return await databaseHelper.saveUserLocal(userItem);
    } catch (e) {
      throw DatabaseException();
    }
  }
}
