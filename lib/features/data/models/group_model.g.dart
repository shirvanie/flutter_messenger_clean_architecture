// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupModel _$GroupModelFromJson(Map<String, dynamic> json) => GroupModel(
      id: json['id'],
      groupId: json['groupId'],
      groupCreatorUserPhoneNumber: json['groupCreatorUserPhoneNumber'],
      groupName: json['groupName'],
      groupAvatar: json['groupAvatar'],
      createDateTime: json['createDateTime'],
      lastMessageSenderFullName: json['lastMessageSenderFullName'],
      lastMessageBody: json['lastMessageBody'],
      lastMessageDateTime: json['lastMessageDateTime'],
      lastMessageCategory: json['lastMessageCategory'],
      lastMessageType: json['lastMessageType'],
      lastMessageIsReadByGroupUser: json['lastMessageIsReadByGroupUser'],
      isConfirm: json['isConfirm'],
      notReadMessageCount: json['notReadMessageCount'],
    );

Map<String, dynamic> _$GroupModelToJson(GroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'groupCreatorUserPhoneNumber': instance.groupCreatorUserPhoneNumber,
      'groupName': instance.groupName,
      'groupAvatar': instance.groupAvatar,
      'createDateTime': instance.createDateTime,
      'lastMessageSenderFullName': instance.lastMessageSenderFullName,
      'lastMessageBody': instance.lastMessageBody,
      'lastMessageDateTime': instance.lastMessageDateTime,
      'lastMessageCategory': instance.lastMessageCategory,
      'lastMessageType': instance.lastMessageType,
      'lastMessageIsReadByGroupUser': instance.lastMessageIsReadByGroupUser,
      'isConfirm': instance.isConfirm,
      'notReadMessageCount': instance.notReadMessageCount,
    };
