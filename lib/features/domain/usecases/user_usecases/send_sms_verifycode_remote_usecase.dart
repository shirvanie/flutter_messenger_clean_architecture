
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/data/models/sms_model.dart';
import 'package:messenger/features/domain/repositories/user_repository.dart';

class SendSMSVerifyCodeRemoteUseCase implements UseCase<bool, ParamsSendSMSVerifyCodeRemoteUseCase> {
  final UserRepository repository;

  SendSMSVerifyCodeRemoteUseCase(this.repository);


  @override
  Future<Either<Failure, bool>> call(ParamsSendSMSVerifyCodeRemoteUseCase params) async {
    return await repository.sendSMSVerifyCodeRemote(params.smsItem);
  }
}

class ParamsSendSMSVerifyCodeRemoteUseCase extends Equatable {
  final SMSModel smsItem;

  const ParamsSendSMSVerifyCodeRemoteUseCase({required this.smsItem});

  @override
  List<Object> get props => [smsItem];

  @override
  String toString() {
    return 'SendSMSVerifyCodeRemoteUseCase Params{smsItem: $smsItem}';
  }
}
