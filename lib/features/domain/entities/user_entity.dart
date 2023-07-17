
import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';


@Entity()
class UserEntity extends Equatable {
  const UserEntity({
    this.id,
    this.userPhoneNumber,
    this.fullName,
    this.userAvatar,
    this.lastSeenDateTime,
    this.lastMessageBody,
    this.lastMessageDateTime,
    this.lastMessageCategory,
    this.lastMessageType,
    this.lastMessageIsReadByTargetUser,
    this.isConfirm,
    this.notReadMessageCount,
    this.verifyCode,
    this.verifyProfile,
  });

  @Id(assignable: true)
  final int? id;
  final String? userPhoneNumber;
  final String? fullName;
  final String? userAvatar;
  final String? lastSeenDateTime;
  final String? lastMessageBody;
  final String? lastMessageDateTime;
  final String? lastMessageCategory;
  final String? lastMessageType;
  final bool? lastMessageIsReadByTargetUser;
  final bool? isConfirm;
  final int? notReadMessageCount;
  final String? verifyCode;
  final bool? verifyProfile;

  @override
  List<Object?> get props => [
    id,
    userPhoneNumber,
    fullName,
    userAvatar,
    lastSeenDateTime,
    lastMessageBody,
    lastMessageDateTime,
    lastMessageCategory,
    lastMessageType,
    lastMessageIsReadByTargetUser,
    isConfirm,
    notReadMessageCount,
    verifyCode,
    verifyProfile,
  ];

}
