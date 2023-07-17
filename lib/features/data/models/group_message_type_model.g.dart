// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_message_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupMessageTypeModel _$GroupMessageTypeModelFromJson(
        Map<String, dynamic> json) =>
    GroupMessageTypeModel(
      id: json['id'],
      groupId: json['groupId'],
      messageId: json['messageId'],
      receiverPhoneNumber: json['receiverPhoneNumber'],
      messageType: json['messageType'],
      messageIsReadByGroupUser: json['messageIsReadByGroupUser'],
    );

Map<String, dynamic> _$GroupMessageTypeModelToJson(
        GroupMessageTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'messageId': instance.messageId,
      'receiverPhoneNumber': instance.receiverPhoneNumber,
      'messageType': instance.messageType,
      'messageIsReadByGroupUser': instance.messageIsReadByGroupUser,
    };
