



import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/features/data/datasources/db/database_helper.dart';
import 'package:messenger/features/domain/entities/group_user_entity.dart';

abstract class GroupUserLocalDataSource {
  Future<List<GroupUserEntity>> getAllGroupUsersLocal(String groupId);
  Future<GroupUserEntity> getGroupUserLocal(String groupId, String userPhoneNumber);
  Future<bool> removeGroupUserLocal(String groupId, String userPhoneNumber);
  Future<bool> saveGroupUserLocal(GroupUserEntity groupItem);
}

class GroupUserLocalDataSourceImpl implements GroupUserLocalDataSource {

  final DatabaseHelper databaseHelper;
  GroupUserLocalDataSourceImpl(this.databaseHelper) ;


  @override
  Future<List<GroupUserEntity>> getAllGroupUsersLocal(String groupId) async {
    try{
      return await databaseHelper.getAllGroupUsersLocal(groupId);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<GroupUserEntity> getGroupUserLocal(String groupId, String userPhoneNumber) async {
    try{
      return await databaseHelper.getGroupUserLocal(groupId, userPhoneNumber);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<bool> removeGroupUserLocal(String groupId, String userPhoneNumber) async {
    try{
      return await databaseHelper.removeGroupUserLocal(groupId, userPhoneNumber);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<bool> saveGroupUserLocal(GroupUserEntity groupUserItem) async {
    try{
      return await databaseHelper.saveGroupUserLocal(groupUserItem);
    } catch (e) {
      throw DatabaseException();
    }
  }

}
