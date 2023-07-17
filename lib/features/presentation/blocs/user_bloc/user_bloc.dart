import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/data/models/sms_model.dart';
import 'package:messenger/features/domain/entities/user_entity.dart';
import 'package:messenger/features/domain/usecases/user_usecases/exist_user_local_usecase.dart';
import 'package:messenger/features/domain/usecases/user_usecases/get_all_users_local_usecase.dart';
import 'package:messenger/features/domain/usecases/user_usecases/get_all_users_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/user_usecases/get_user_local_usecase.dart';
import 'package:messenger/features/domain/usecases/user_usecases/get_user_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/user_usecases/remove_user_local_usecase.dart';
import 'package:messenger/features/domain/usecases/user_usecases/save_user_local_usecase.dart';
import 'package:messenger/features/domain/usecases/user_usecases/save_user_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/user_usecases/send_sms_verifycode_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/user_usecases/set_user_lastseen_datetime_remote_usecase.dart';



part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ExistUserLocalUseCase existUserLocalUseCase;
  final GetAllUsersLocalUseCase getAllUsersLocalUseCase;
  final GetAllUsersRemoteUseCase getAllUsersRemoteUseCase;
  final GetUserLocalUseCase getUserLocalUseCase;
  final GetUserRemoteUseCase getUserRemoteUseCase;
  final RemoveUserLocalUseCase removeUserLocalUseCase;
  final SaveUserLocalUseCase saveUserLocalUseCase;
  final SaveUserRemoteUseCase saveUserRemoteUseCase;
  final SendSMSVerifyCodeRemoteUseCase sendSMSVerifyCodeRemoteUseCase;
  final SetUserLastSeenDateTimeRemoteUseCase setUserLastSeenDateTimeRemoteUseCase;

  UserBloc({
    required this.existUserLocalUseCase,
    required this.getAllUsersLocalUseCase,
    required this.getAllUsersRemoteUseCase,
    required this.getUserLocalUseCase,
    required this.getUserRemoteUseCase,
    required this.removeUserLocalUseCase,
    required this.saveUserLocalUseCase,
    required this.saveUserRemoteUseCase,
    required this.sendSMSVerifyCodeRemoteUseCase,
    required this.setUserLastSeenDateTimeRemoteUseCase
  }) : super(const InitUserState()) {
    on<ExistUserLocalEvent>(existUserLocalEvent);
    on<GetAllUsersLocalEvent>(getAllUsersLocalEvent);
    on<GetAllUsersRemoteEvent>(getAllUsersRemoteEvent);
    on<GetUserLocalEvent>(getUserLocalEvent);
    on<GetUserRemoteEvent>(getUserRemoteEvent);
    on<RemoveUserLocalEvent>(removeUserLocalEvent);
    on<SaveUserLocalEvent>(saveUserLocalEvent);
    on<SaveUserRemoteEvent>(saveUserRemoteEvent);
    on<SendSMSVerifyCodeRemoteEvent>(sendSMSVerifyCodeRemoteEvent);
    on<SetUserLastSeenDateTimeRemoteEvent>(setUserLastSeenDateTimeRemoteEvent);
  }

  Future<void> existUserLocalEvent(event, emit) async {
    emit(const LoadingUserState());
    try{
      final userPhoneNumber = event.userPhoneNumber;
      final function = await existUserLocalUseCase.call(ParamsExistUserLocalUseCase(userPhoneNumber: userPhoneNumber));
      function.fold(
        (failure) {
          emit(const ErrorUserState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(ExistUserLocalState(hasExistUser: data));
        }
      );
    } catch(e) {
      emit(ErrorUserState(message: e.toString()));
    }
  }

  Future<void> getAllUsersLocalEvent(event, emit) async {
    emit(const LoadingUserState());
    try{
      final function = await getAllUsersLocalUseCase.call(NoParams());
      function.fold(
        (failure) {
          emit(const ErrorUserState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(GetAllUserLocalState(userItems: data));
        }
      );
    } catch(e) {
      emit(ErrorUserState(message: e.toString()));
    }
  }

  Future<void> getUserLocalEvent(event, emit) async {
    emit(const LoadingUserState());
    try{
      final userPhoneNumber = event.userPhoneNumber;
      final function = await getUserLocalUseCase.call(ParamsGetUserLocalUseCase(userPhoneNumber: userPhoneNumber));
      function.fold(
        (failure) {
          emit(const ErrorUserState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(GetUserLocalState(userItem: data));
        }
      );
    } catch(e) {
      emit(ErrorUserState(message: e.toString()));
    }
  }

  Future<void> removeUserLocalEvent(event, emit) async {
    emit(const LoadingUserState());
    try{
      final userPhoneNumber = event.userPhoneNumber;
      final function = await removeUserLocalUseCase.call(ParamsRemoveUserLocalUseCase(userPhoneNumber: userPhoneNumber));
      function.fold(
        (failure) {
          emit(const ErrorUserState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(RemoveUserLocalState(hasRemoved: data));
        }
      );
    } catch(e) {
      emit(ErrorUserState(message: e.toString()));
    }
  }

  Future<void> saveUserLocalEvent(event, emit) async {
    emit(const LoadingUserState());
    try{
      final userItem = event.userItem;
      final function = await saveUserLocalUseCase.call(ParamsSaveUserLocalUseCase(userItem: userItem));
      function.fold(
        (failure) {
          emit(const ErrorUserState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(SaveUserLocalState(hasSaved: data));
        }
      );
    } catch(e) {
      emit(ErrorUserState(message: e.toString()));
    }
  }

  Future<void> getAllUsersRemoteEvent(event, emit) async {
    emit(const LoadingUserState());
    try{
      final function = await getAllUsersRemoteUseCase.call(NoParams());
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorUserState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorUserState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(GetAllUserRemoteState(userItems: data));
        }
      );
    } catch(e) {
      emit(ErrorUserState(message: e.toString()));
    }
  }

  Future<void> getUserRemoteEvent(event, emit) async {
    emit(const LoadingUserState());
    try{
      final userPhoneNumber = event.userPhoneNumber;
      final function = await getUserRemoteUseCase.call(ParamsGetUserRemoteUseCase(userPhoneNumber: userPhoneNumber));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorUserState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorUserState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(GetUserRemoteState(userItem: data));
        }
      );
    } catch(e) {
      emit(ErrorUserState(message: e.toString()));
    }
  }

  Future<void> saveUserRemoteEvent(event, emit) async {
    emit(const LoadingUserState());
    try{
      final userItem = event.userItem;
      final function = await saveUserRemoteUseCase.call(ParamsSaveUserRemoteUseCase(userItem: userItem));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorUserState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorUserState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(SaveUserRemoteState(hasSaved: data));
        }
      );
    } catch(e) {
      emit(ErrorUserState(message: e.toString()));
    }
  }

  Future<void> sendSMSVerifyCodeRemoteEvent(event, emit) async {
    emit(const LoadingUserState());
    try{
      final smsItem = event.smsItem;
      final function = await sendSMSVerifyCodeRemoteUseCase.call(ParamsSendSMSVerifyCodeRemoteUseCase(smsItem: smsItem));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorUserState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorUserState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(SendSMSVerifyCodeRemoteState(hasSent: data));
        }
      );
    } catch(e) {
      emit(ErrorUserState(message: e.toString()));
    }
  }

  Future<void> setUserLastSeenDateTimeRemoteEvent(event, emit) async {
    emit(const LoadingUserState());
    try{
      final userPhoneNumber = event.userPhoneNumber;
      final lastSeenDateTime = event.lastSeenDateTime;
      final function = await setUserLastSeenDateTimeRemoteUseCase.call(ParamsSetUserLastSeenDateTimeRemoteUseCase(userPhoneNumber: userPhoneNumber, lastSeenDateTime: lastSeenDateTime));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorUserState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorUserState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(SetUserLastSeenDateTimeRemoteState(hasSet: data));
        }
      );
    } catch(e) {
      emit(ErrorUserState(message: e.toString()));
    }
  }
}
