

import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class GroupMessageTypeEntity extends Equatable {
  const GroupMessageTypeEntity({
    this.id,
    this.groupId,
    this.messageId,
    this.receiverPhoneNumber,
    this.messageType,
    this.messageIsReadByGroupUser,
  });

  @Id(assignable: true)
  final int? id;
  final String? groupId;
  final String? messageId;
  final String? receiverPhoneNumber;
  final String? messageType;
  final bool? messageIsReadByGroupUser;

  @override
  List<Object?> get props => [
    id,
    groupId,
    messageId,
    receiverPhoneNumber,
    messageType,
    messageIsReadByGroupUser,
  ];

}
