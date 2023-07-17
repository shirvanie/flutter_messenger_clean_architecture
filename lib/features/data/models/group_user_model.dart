

import 'package:json_annotation/json_annotation.dart';
import 'package:messenger/features/domain/entities/group_user_entity.dart';

part 'group_user_model.g.dart';

@JsonSerializable()
class GroupUserModel extends GroupUserEntity {
  const GroupUserModel({
    id,
    groupId,
    userPhoneNumber,
    isAdmin,
  }) : super(
    id: id,
    groupId: groupId,
    userPhoneNumber: userPhoneNumber,
    isAdmin: isAdmin,
  );

  factory GroupUserModel.fromJson(Map<String, dynamic> json) => _$GroupUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupUserModelToJson(this);
}
