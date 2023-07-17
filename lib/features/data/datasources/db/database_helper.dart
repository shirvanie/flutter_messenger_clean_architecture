
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:messenger/features/domain/entities/group_entity.dart';
import 'package:messenger/features/domain/entities/group_message_entity.dart';
import 'package:messenger/features/domain/entities/group_message_type_entity.dart';
import 'package:messenger/features/domain/entities/group_user_entity.dart';
import 'package:messenger/features/domain/entities/message_entity.dart';
import 'package:messenger/features/domain/entities/user_entity.dart';
import 'package:messenger/objectbox.g.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Store? _store;

  Future<Store?> get store async {
    _store ??= await _create();
    return _store;
  }

  Future<Store> _create() async {
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = path.join(appDir.path, "MessengerObjectBox");
    final store = await openStore(directory: dbPath);
    return store;
  }

  void close() async {
    try {
      _store?.close();
    } catch (e) { return; }
  }

  /// ////////////////////////
  /// User Store Functions ///
  /// ////////////////////////
  Future<bool> existUserLocal(String userPhoneNumber) async {
    final db = await store;
    final query = db!.box<UserEntity>().query(UserEntity_.userPhoneNumber.equals(userPhoneNumber)).build();
    final results = await query.findAsync();
    query.close();
    return results.isNotEmpty;
  }

  Future<List<UserEntity>> getAllUsersLocal() async {
    final db = await store;
    final query = db!.box<UserEntity>().query().order(UserEntity_.fullName).build();
    final results = await query.findAsync();
    query.close();
    return results;
  }

  Future<UserEntity> getUserLocal(String userPhoneNumber) async {
    final db = await store;
    final query = db!.box<UserEntity>().query(UserEntity_.userPhoneNumber.equals(userPhoneNumber)).build();
    final results = await query.findAsync();
    query.close();
    return results[0];
  }

  Future<bool> removeUserLocal(String userPhoneNumber) async {
    final db = await store;
    final query = db!.box<UserEntity>().query(UserEntity_.userPhoneNumber.equals(userPhoneNumber)).build();
    final results = await query.findAsync();
    query.close();
    await db.box<UserEntity>().removeAsync(results[0].id!);
    return true;
  }

  Future<bool> saveUserLocal(UserEntity userItem) async {
    final db = await store;
    await db!.box<UserEntity>().putAsync(userItem, mode: PutMode.put);
    return true;
  }

  /// ///////////////////////////
  /// Message Store Functions ///
  /// ///////////////////////////
  Future<bool> existMessageLocal(String messageId) async {
    final db = await store;
    final query = db!.box<MessageEntity>().query(MessageEntity_.messageId.equals(messageId)).build();
    final results = await query.findAsync();
    query.close();
    return results.isNotEmpty;
  }

  Future<List<MessageEntity>> getAllMessagesLocal(String senderPhoneNumber, String targetPhoneNumber) async {
    final db = await store;
    final query = db!.box<MessageEntity>().query(
      MessageEntity_.senderPhoneNumber.equals(senderPhoneNumber).and(
          MessageEntity_.targetPhoneNumber.equals(targetPhoneNumber))
      | MessageEntity_.senderPhoneNumber.equals(targetPhoneNumber).and(
          MessageEntity_.targetPhoneNumber.equals(senderPhoneNumber)),)
            .order(MessageEntity_.id, flags: Order.descending).build();
    //
    //
    final results = await query.findAsync();
    query.close();
    return results;
  }

  Future<MessageEntity> getMessageLocal(String messageId) async {
    final db = await store;
    final query = db!.box<MessageEntity>().query(MessageEntity_.messageId.equals(messageId)).build();
    final results = await query.findAsync();
    query.close();
    return results[0];
  }

  Future<bool> removeMessageLocal(String messageId) async {
    final db = await store;
    final query = db!.box<MessageEntity>().query(MessageEntity_.messageId.equals(messageId)).build();
    final results = await query.findAsync();
    query.close();
    await db.box<MessageEntity>().removeAsync(results[0].id!);
    return true;
  }

  Future<bool> saveMessageLocal(MessageEntity messageItem) async {
    final db = await store;
    await db!.box<MessageEntity>().putAsync(messageItem, mode: PutMode.insert);
    return true;
  }

  Future<List<MessageEntity>> getAllUnsendMessagesLocal() async {
    final db = await store;
    final query = db!.box<MessageEntity>().query(MessageEntity_.messageType.equals("sending"))
      .order(MessageEntity_.id, flags: Order.descending).build();
    final results = await query.findAsync();
    query.close();
    return results;
  }

  Future<List<MessageEntity>> getAllNotReadMessagesLocal(String senderPhoneNumber, String targetPhoneNumber) async {
    final db = await store;
    final query = db!.box<MessageEntity>().query(MessageEntity_.senderPhoneNumber.equals(senderPhoneNumber)
    & MessageEntity_.targetPhoneNumber.equals(targetPhoneNumber)
    & MessageEntity_.messageType.equals("received")
    & MessageEntity_.messageIsReadByTargetUser.equals(false),)
      .order(MessageEntity_.id, flags: Order.descending).build();
    final results = await query.findAsync();
    query.close();
    return results;
  }

  /// ///////////////////////////
  /// Group Store Functions   ///
  /// ///////////////////////////
  Future<List<GroupEntity>> getAllGroupsLocal() async {
    final db = await store;
    final query = db!.box<GroupEntity>().query().build();
    final results = await query.findAsync();
    query.close();
    return results;
  }

  Future<GroupEntity> getGroupLocal(String groupId) async {
    final db = await store;
    final query = db!.box<GroupEntity>().query(GroupEntity_.groupId.equals(groupId)).build();
    final results = await query.findAsync();
    query.close();
    return results[0];
  }

  Future<bool> removeGroupLocal(String groupId) async {
    final db = await store;
    final query = db!.box<GroupEntity>().query(GroupEntity_.groupId.equals(groupId)).build();
    final results = await query.findAsync();
    query.close();
    await db.box<GroupEntity>().removeAsync(results[0].id!);
    return true;
  }

  Future<bool> saveGroupLocal(GroupEntity groupItem) async {
    final db = await store;
    await db!.box<GroupEntity>().putAsync(groupItem, mode: PutMode.put);
    return true;
  }

  /// ///////////////////////////////
  /// GroupUser Store Functions   ///
  /// ///////////////////////////////
  Future<List<GroupUserEntity>> getAllGroupUsersLocal(String groupId) async {
    final db = await store;
    final query = db!.box<GroupUserEntity>().query(GroupUserEntity_.groupId.equals(groupId)).build();
    final results = await query.findAsync();
    query.close();
    return results;
  }

  Future<GroupUserEntity> getGroupUserLocal(String groupId, String userPhoneNumber) async {
    final db = await store;
    final query = db!.box<GroupUserEntity>().query(GroupUserEntity_.groupId.equals(groupId) & GroupUserEntity_.userPhoneNumber.equals(userPhoneNumber)).build();
    final results = await query.findAsync();
    query.close();
    return results[0];
  }

  Future<bool> removeGroupUserLocal(String groupId, String userPhoneNumber) async {
    final db = await store;
    final query = db!.box<GroupUserEntity>().query(GroupUserEntity_.groupId.equals(groupId) & GroupUserEntity_.userPhoneNumber.equals(userPhoneNumber)).build();
    final results = await query.findAsync();
    query.close();
    await db.box<GroupUserEntity>().removeAsync(results[0].id!);
    return true;
  }

  Future<bool> saveGroupUserLocal(GroupUserEntity groupUserItem) async {
    final db = await store;
    await db!.box<GroupUserEntity>().putAsync(groupUserItem, mode: PutMode.put);
    return true;
  }

  /// //////////////////////////////////
  /// GroupMessage Store Functions   ///
  /// //////////////////////////////////
  Future<bool> existGroupMessageLocal(String messageId) async {
    final db = await store;
    final query = db!.box<GroupMessageEntity>().query(GroupMessageEntity_.messageId.equals(messageId)).build();
    final results = await query.findAsync();
    query.close();
    return results.isNotEmpty;
  }

  Future<List<GroupMessageEntity>> getAllGroupMessagesLocal(String groupId) async {
    final db = await store;
    final query = db!.box<GroupMessageEntity>().query(GroupMessageEntity_.groupId.equals(groupId)).build();
    final results = await query.findAsync();
    query.close();
    return results;
  }

  Future<GroupMessageEntity> getGroupMessageLocal(String messageId) async {
    final db = await store;
    final query = db!.box<GroupMessageEntity>().query(GroupMessageEntity_.messageId.equals(messageId)).build();
    final results = await query.findAsync();
    query.close();
    return results[0];
  }

  Future<bool> removeGroupMessageLocal(String messageId) async {
    final db = await store;
    final query = db!.box<GroupMessageEntity>().query(GroupMessageEntity_.messageId.equals(messageId)).build();
    final results = await query.findAsync();
    query.close();
    await db.box<GroupMessageEntity>().removeAsync(results[0].id!);
    return true;
  }

  Future<bool> saveGroupMessageLocal(GroupMessageEntity groupMessageItem) async {
    final db = await store;
    await db!.box<GroupMessageEntity>().putAsync(groupMessageItem, mode: PutMode.put);
    return true;
  }

  Future<List<GroupMessageEntity>> getAllUnsendGroupMessagesLocal(String senderPhoneNumber) async {
    final db = await store;
    final query = db!.box<GroupMessageEntity>().query(GroupMessageEntity_.senderPhoneNumber.equals(senderPhoneNumber)).build();
    final results = await query.findAsync();
    query.close();
    return results;
  }

  /// //////////////////////////////////////
  /// GroupMessageType Store Functions   ///
  /// //////////////////////////////////////
  Future<bool> existGroupMessageTypeLocal(String messageId) async {
    final db = await store;
    final query = db!.box<GroupMessageTypeEntity>().query(GroupMessageTypeEntity_.messageId.equals(messageId)).build();
    final results = await query.findAsync();
    query.close();
    return results.isNotEmpty;
  }

  Future<List<GroupMessageTypeEntity>> getAllGroupMessageTypesLocal(String groupId, String messageId) async {
    final db = await store;
    final query = db!.box<GroupMessageTypeEntity>().query(GroupMessageTypeEntity_.groupId.equals(groupId) & GroupMessageTypeEntity_.messageId.equals(messageId)).build();
    final results = await query.findAsync();
    query.close();
    return results;
  }

  Future<GroupMessageTypeEntity> getGroupMessageTypeLocal(String messageId) async {
    final db = await store;
    final query = db!.box<GroupMessageTypeEntity>().query(GroupMessageTypeEntity_.messageId.equals(messageId)).build();
    final results = await query.findAsync();
    query.close();
    return results[0];
  }

  Future<bool> removeGroupMessageTypeLocal(String messageId) async {
    final db = await store;
    final query = db!.box<GroupMessageTypeEntity>().query(GroupMessageTypeEntity_.messageId.equals(messageId)).build();
    final results = await query.findAsync();
    query.close();
    await db.box<GroupMessageTypeEntity>().removeAsync(results[0].id!);
    return true;
  }

  Future<bool> saveGroupMessageTypeLocal(GroupMessageTypeEntity groupMessageTypeItem) async {
    final db = await store;
    await db!.box<GroupMessageTypeEntity>().putAsync(groupMessageTypeItem, mode: PutMode.put);
    return true;
  }

  Future<List<GroupMessageTypeEntity>> getAllUnsendGroupMessageTypesLocal(String groupId) async {
    final db = await store;
    final query = db!.box<GroupMessageTypeEntity>().query(GroupMessageTypeEntity_.groupId.equals(groupId)
    & GroupMessageTypeEntity_.messageType.equals("received")
    & GroupMessageTypeEntity_.messageIsReadByGroupUser.equals(false),).build();
    final results = await query.findAsync();
    query.close();
    return results;
  }

  Future<List<GroupMessageTypeEntity>> getAllNotReadGroupMessageTypesLocal(String receiverPhoneNumber) async {
    final db = await store;
    final query = db!.box<GroupMessageTypeEntity>().query(GroupMessageTypeEntity_.receiverPhoneNumber.equals(receiverPhoneNumber)).build();
    final results = await query.findAsync();
    query.close();
    return results;
  }
}