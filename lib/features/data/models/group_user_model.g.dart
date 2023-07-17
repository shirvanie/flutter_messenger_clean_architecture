// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupUserModel _$GroupUserModelFromJson(Map<String, dynamic> json) =>
    GroupUserModel(
      id: json['id'],
      groupId: json['groupId'],
      userPhoneNumber: json['userPhoneNumber'],
      isAdmin: json['isAdmin'],
    );

Map<String, dynamic> _$GroupUserModelToJson(GroupUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'userPhoneNumber': instance.userPhoneNumber,
      'isAdmin': instance.isAdmin,
    };
