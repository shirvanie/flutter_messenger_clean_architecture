


import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';


@Entity()
class GroupMessageEntity extends Equatable {
  const GroupMessageEntity({
    this.id,
    this.messageId,
    this.groupId,
    this.senderPhoneNumber,
    this.messageCategory,
    this.messageBody,
    this.messageDateTime,
  });

  @Id(assignable: true)
  final int? id;
  final String? messageId;
  final String? groupId;
  final String? senderPhoneNumber;
  final String? messageCategory;
  final String? messageBody;
  final String? messageDateTime;

  @override
  List<Object?> get props => [
    id,
    messageId,
    groupId,
    senderPhoneNumber,
    messageCategory,
    messageBody,
    messageDateTime,
  ];

}
