// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupMessageModel _$GroupMessageModelFromJson(Map<String, dynamic> json) =>
    GroupMessageModel(
      id: json['id'],
      messageId: json['messageId'],
      groupId: json['groupId'],
      senderPhoneNumber: json['senderPhoneNumber'],
      messageCategory: json['messageCategory'],
      messageBody: json['messageBody'],
      messageDateTime: json['messageDateTime'],
    );

Map<String, dynamic> _$GroupMessageModelToJson(GroupMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'messageId': instance.messageId,
      'groupId': instance.groupId,
      'senderPhoneNumber': instance.senderPhoneNumber,
      'messageCategory': instance.messageCategory,
      'messageBody': instance.messageBody,
      'messageDateTime': instance.messageDateTime,
    };
