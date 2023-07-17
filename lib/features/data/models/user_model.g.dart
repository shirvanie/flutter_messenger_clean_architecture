// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      userPhoneNumber: json['userPhoneNumber'],
      fullName: json['fullName'],
      userAvatar: json['userAvatar'],
      lastSeenDateTime: json['lastSeenDateTime'],
      lastMessageBody: json['lastMessageBody'],
      lastMessageDateTime: json['lastMessageDateTime'],
      lastMessageCategory: json['lastMessageCategory'],
      lastMessageType: json['lastMessageType'],
      lastMessageIsReadByTargetUser: json['lastMessageIsReadByTargetUser'],
      isConfirm: json['isConfirm'],
      notReadMessageCount: json['notReadMessageCount'],
      verifyCode: json['verifyCode'],
      verifyProfile: json['verifyProfile'],
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'userPhoneNumber': instance.userPhoneNumber,
      'fullName': instance.fullName,
      'userAvatar': instance.userAvatar,
      'lastSeenDateTime': instance.lastSeenDateTime,
      'lastMessageBody': instance.lastMessageBody,
      'lastMessageDateTime': instance.lastMessageDateTime,
      'lastMessageCategory': instance.lastMessageCategory,
      'lastMessageType': instance.lastMessageType,
      'lastMessageIsReadByTargetUser': instance.lastMessageIsReadByTargetUser,
      'isConfirm': instance.isConfirm,
      'notReadMessageCount': instance.notReadMessageCount,
      'verifyCode': instance.verifyCode,
      'verifyProfile': instance.verifyProfile,
    };
