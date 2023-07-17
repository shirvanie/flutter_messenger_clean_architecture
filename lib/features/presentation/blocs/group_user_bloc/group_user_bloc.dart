import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/features/domain/entities/group_user_entity.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/get_all_group_users_by_phone_number_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/get_all_group_users_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/get_all_group_users_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/get_group_user_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/remove_group_user_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/remove_group_user_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/save_group_user_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/save_group_user_remote_usecase.dart';

part 'group_user_event.dart';
part 'group_user_state.dart';


class GroupUserBloc extends Bloc<GroupUserEvent, GroupUserState> {
  final GetAllGroupUsersLocalUseCase getAllGroupUsersLocalUseCase;
  final GetAllGroupUsersRemoteUseCase getAllGroupUsersRemoteUseCase;
  final GetAllGroupUsersByPhoneNumberRemoteUseCase getAllGroupUsersByPhoneNumberRemoteUseCase;
  final GetGroupUserLocalUseCase getGroupUserLocalUseCase;
  final RemoveGroupUserLocalUseCase removeGroupUserLocalUseCase;
  final RemoveGroupUserRemoteUseCase removeGroupUserRemoteUseCase;
  final SaveGroupUserLocalUseCase saveGroupUserLocalUseCase;
  final SaveGroupUserRemoteUseCase saveGroupUserRemoteUseCase;

  GroupUserBloc({
    required this.getAllGroupUsersLocalUseCase,
    required this.getAllGroupUsersRemoteUseCase,
    required this.getAllGroupUsersByPhoneNumberRemoteUseCase,
    required this.getGroupUserLocalUseCase,
    required this.removeGroupUserLocalUseCase,
    required this.removeGroupUserRemoteUseCase,
    required this.saveGroupUserLocalUseCase,
    required this.saveGroupUserRemoteUseCase,
  }) : super(const InitGroupUserState()) {
    on<GetAllGroupUsersLocalEvent>(getAllGroupUsersLocalEvent);
    on<GetAllGroupUsersRemoteEvent>(getAllGroupUsersRemoteEvent);
    on<GetAllGroupUsersByPhoneNumberRemoteEvent>(getAllGroupUsersByPhoneNumberRemoteEvent);
    on<GetGroupUserLocalEvent>(getGroupUserLocalEvent);
    on<RemoveGroupUserLocalEvent>(removeGroupUserLocalEvent);
    on<RemoveGroupUserRemoteEvent>(removeGroupUserRemoteEvent);
    on<SaveGroupUserLocalEvent>(saveGroupUserLocalEvent);
    on<SaveGroupUserRemoteEvent>(saveGroupUserRemoteEvent);
  }


  Future<void> getAllGroupUsersLocalEvent(event, emit) async {
    emit(const LoadingGroupUserState());
    try{
      final groupId = event.groupId;
      final function = await getAllGroupUsersLocalUseCase.call(ParamsGetAllGroupUsersLocalUseCase(groupId: groupId));
      function.fold(
        (failure) {
          emit(const ErrorGroupUserState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(GetAllGroupUsersLocalState(groupUserItems: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupUserState(message: e.toString()));
    }
  }

  Future<void> getGroupUserLocalEvent(event, emit) async {
    emit(const LoadingGroupUserState());
    try{
      final groupId = event.groupId;
      final userPhoneNumber = event.userPhoneNumber;
      final function = await getGroupUserLocalUseCase.call(ParamsGetGroupUserLocalUseCase(groupId: groupId, userPhoneNumber: userPhoneNumber));
      function.fold(
        (failure) {
          emit(const ErrorGroupUserState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(GetGroupUserLocalState(groupUserItem: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupUserState(message: e.toString()));
    }
  }

  Future<void> removeGroupUserLocalEvent(event, emit) async {
    emit(const LoadingGroupUserState());
    try{
      final groupId = event.groupId;
      final userPhoneNumber = event.userPhoneNumber;
      final function = await removeGroupUserLocalUseCase.call(ParamsRemoveGroupUserLocalUseCase(groupId: groupId, userPhoneNumber: userPhoneNumber));
      function.fold(
        (failure) {
          emit(const ErrorGroupUserState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(RemoveGroupUserLocalState(hasRemoved: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupUserState(message: e.toString()));
    }
  }

  Future<void> saveGroupUserLocalEvent(event, emit) async {
    emit(const LoadingGroupUserState());
    try{
      final groupUserItem = event.groupUserItem;
      final function = await saveGroupUserLocalUseCase.call(ParamsSaveGroupUserLocalUseCase(groupUserItem: groupUserItem));
      function.fold(
        (failure) {
          emit(const ErrorGroupUserState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(SaveGroupUserLocalState(hasSaved: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupUserState(message: e.toString()));
    }
  }

  Future<void> getAllGroupUsersRemoteEvent(event, emit) async {
    emit(const LoadingGroupUserState());
    try{
      final groupId = event.groupId;
      final function = await getAllGroupUsersRemoteUseCase.call(ParamsGetAllGroupUsersRemoteUseCase(groupId: groupId));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorGroupUserState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorGroupUserState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(GetAllGroupUsersRemoteState(groupUserItems: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupUserState(message: e.toString()));
    }
  }

  Future<void> getAllGroupUsersByPhoneNumberRemoteEvent(event, emit) async {
    emit(const LoadingGroupUserState());
    try{
      final userPhoneNumber = event.userPhoneNumber;
      final function = await getAllGroupUsersByPhoneNumberRemoteUseCase.call(ParamsGetAllGroupUsersByPhoneNumberRemoteUseCase(userPhoneNumber: userPhoneNumber));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorGroupUserState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorGroupUserState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(GetAllGroupUsersByPhoneNumberRemoteState(groupUserItems: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupUserState(message: e.toString()));
    }
  }

  Future<void> removeGroupUserRemoteEvent(event, emit) async {
    emit(const LoadingGroupUserState());
    try{
      final groupId = event.groupId;
      final userPhoneNumber = event.userPhoneNumber;
      final function = await removeGroupUserRemoteUseCase.call(ParamsRemoveGroupUserRemoteUseCase(groupId: groupId, userPhoneNumber: userPhoneNumber));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorGroupUserState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorGroupUserState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(RemoveGroupUserRemoteState(hasRemoved: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupUserState(message: e.toString()));
    }
  }

  Future<void> saveGroupUserRemoteEvent(event, emit) async {
    emit(const LoadingGroupUserState());
    try{
      final groupUserItem = event.groupUserItem;
      final function = await saveGroupUserRemoteUseCase.call(ParamsSaveGroupUserRemoteUseCase(groupUserItem: groupUserItem));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorGroupUserState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorGroupUserState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(SaveGroupUserRemoteState(hasSaved: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupUserState(message: e.toString()));
    }
  }

}
