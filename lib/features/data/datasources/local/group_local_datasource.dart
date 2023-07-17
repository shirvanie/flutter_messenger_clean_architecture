



import 'package:messenger/core/errors/exceptions.dart';
import 'package:messenger/features/data/datasources/db/database_helper.dart';
import 'package:messenger/features/domain/entities/group_entity.dart';

abstract class GroupLocalDataSource {
  Future<List<GroupEntity>> getAllGroupsLocal();
  Future<GroupEntity> getGroupLocal(String userPhoneNumber);
  Future<bool> removeGroupLocal(String groupId);
  Future<bool> saveGroupLocal(GroupEntity groupItem);
}

class GroupLocalDataSourceImpl implements GroupLocalDataSource {

  final DatabaseHelper databaseHelper;
  GroupLocalDataSourceImpl(this.databaseHelper);


  @override
  Future<List<GroupEntity>> getAllGroupsLocal() async {
    try{
      return await databaseHelper.getAllGroupsLocal();
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<GroupEntity> getGroupLocal(String groupId) async {
    try{
      return await databaseHelper.getGroupLocal(groupId);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<bool> removeGroupLocal(String groupId) async {
    try{
      return await databaseHelper.removeGroupLocal(groupId);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<bool> saveGroupLocal(GroupEntity groupItem) async {
    try{
      return await databaseHelper.saveGroupLocal(groupItem);
    } catch (e) {
      throw DatabaseException();
    }
  }

}
