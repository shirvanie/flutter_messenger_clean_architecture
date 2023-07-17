// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      id: json['id'],
      messageId: json['messageId'],
      senderPhoneNumber: json['senderPhoneNumber'],
      targetPhoneNumber: json['targetPhoneNumber'],
      messageCategory: json['messageCategory'],
      messageBody: json['messageBody'],
      messageDateTime: json['messageDateTime'],
      messageType: json['messageType'],
      messageIsReadByTargetUser: json['messageIsReadByTargetUser'],
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'messageId': instance.messageId,
      'senderPhoneNumber': instance.senderPhoneNumber,
      'targetPhoneNumber': instance.targetPhoneNumber,
      'messageCategory': instance.messageCategory,
      'messageBody': instance.messageBody,
      'messageDateTime': instance.messageDateTime,
      'messageType': instance.messageType,
      'messageIsReadByTargetUser': instance.messageIsReadByTargetUser,
    };
