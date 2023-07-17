

import 'package:equatable/equatable.dart';


class SMSModel extends Equatable {
  const SMSModel({
    required this.userPhoneNumber,
    required this.verifyCode,
  });

  final String userPhoneNumber;
  final String verifyCode;

  Map<String, dynamic> toJson() => {
    "mobile": userPhoneNumber,
    "templateId": 654321,
    "parameters": [
      {
        "name": "AppName",
        "value": "Messenger"
      },
      {
        "name": "VerifyCode",
        "value": verifyCode
      }
    ],
  };

  @override
  List<Object?> get props => [
    userPhoneNumber,
    verifyCode
  ];


}

