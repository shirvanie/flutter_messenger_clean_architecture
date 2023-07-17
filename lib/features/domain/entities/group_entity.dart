

import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';


@Entity()
class GroupEntity extends Equatable {
  const GroupEntity({
    this.id,
    this.groupId,
    this.groupCreatorUserPhoneNumber,
    this.groupName,
    this.groupAvatar,
    this.createDateTime,
    this.lastMessageSenderFullName,
    this.lastMessageBody,
    this.lastMessageDateTime,
    this.lastMessageCategory,
    this.lastMessageType,
    this.lastMessageIsReadByGroupUser,
    this.isConfirm,
    this.notReadMessageCount,
  });

  @Id(assignable: true)
  final int? id;
  final String? groupId;
  final String? groupCreatorUserPhoneNumber;
  final String? groupName;
  final String? groupAvatar;
  final String? createDateTime;
  final String? lastMessageSenderFullName;
  final String? lastMessageBody;
  final String? lastMessageDateTime;
  final String? lastMessageCategory;
  final String? lastMessageType;
  final bool? lastMessageIsReadByGroupUser;
  final bool? isConfirm;
  final int? notReadMessageCount;

  @override
  List<Object?> get props => [
    id,
    groupId,
    groupCreatorUserPhoneNumber,
    groupName,
    groupAvatar,
    createDateTime,
    lastMessageSenderFullName,
    lastMessageBody,
    lastMessageDateTime,
    lastMessageCategory,
    lastMessageType,
    lastMessageIsReadByGroupUser,
    isConfirm,
    notReadMessageCount,
  ];

}
