

import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';


@Entity()
class GroupUserEntity extends Equatable {
  const GroupUserEntity({
    this.id,
    this.groupId,
    this.userPhoneNumber,
    this.isAdmin,
  });

  @Id(assignable: true)
  final int? id;
  final String? groupId;
  final String? userPhoneNumber;
  final bool? isAdmin;

  @override
  List<Object?> get props => [
    id,
    groupId,
    userPhoneNumber,
    isAdmin,
  ];

}
