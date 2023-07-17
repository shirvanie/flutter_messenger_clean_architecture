import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/group_entity.dart';
import 'package:messenger/features/domain/usecases/group_usecases/get_all_groups_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_usecases/get_all_groups_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_usecases/get_group_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_usecases/get_group_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_usecases/remove_group_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_usecases/save_group_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_usecases/save_group_remote_usecase.dart';

part 'group_event.dart';
part 'group_state.dart';


class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GetAllGroupsLocalUseCase getAllGroupsLocalUseCase;
  final GetAllGroupsRemoteUseCase getAllGroupsRemoteUseCase;
  final GetGroupLocalUseCase getGroupLocalUseCase;
  final GetGroupRemoteUseCase getGroupRemoteUseCase;
  final RemoveGroupLocalUseCase removeGroupLocalUseCase;
  final SaveGroupLocalUseCase saveGroupLocalUseCase;
  final SaveGroupRemoteUseCase saveGroupRemoteUseCase;

  GroupBloc({
    required this.getAllGroupsLocalUseCase,
    required this.getAllGroupsRemoteUseCase,
    required this.getGroupLocalUseCase,
    required this.getGroupRemoteUseCase,
    required this.removeGroupLocalUseCase,
    required this.saveGroupLocalUseCase,
    required this.saveGroupRemoteUseCase,
  }) : super(const InitGroupState()) {
    on<GetAllGroupsLocalEvent>(getAllGroupsLocalEvent);
    on<GetAllGroupsRemoteEvent>(getAllGroupsRemoteEvent);
    on<GetGroupLocalEvent>(getGroupLocalEvent);
    on<GetGroupRemoteEvent>(getGroupRemoteEvent);
    on<RemoveGroupLocalEvent>(removeGroupLocalEvent);
    on<SaveGroupLocalEvent>(saveGroupLocalEvent);
    on<SaveGroupRemoteEvent>(saveGroupRemoteEvent);
  }

  Future<void> getAllGroupsLocalEvent(event, emit) async {
    emit(const LoadingGroupState());
    try{
      final function = await getAllGroupsLocalUseCase.call(NoParams());
      function.fold(
        (failure) {
          emit(const ErrorGroupState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(GetAllGroupsLocalState(groupItems: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupState(message: e.toString()));
    }
  }

  Future<void> getGroupLocalEvent(event, emit) async {
    emit(const LoadingGroupState());
    try{
      final groupId = event.groupId;
      final function = await getGroupLocalUseCase.call(ParamsGetGroupLocalUseCase(groupId: groupId));
      function.fold(
        (failure) {
          emit(const ErrorGroupState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(GetGroupLocalState(groupItem: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupState(message: e.toString()));
    }
  }

  Future<void> removeGroupLocalEvent(event, emit) async {
    emit(const LoadingGroupState());
    try{
      final groupId = event.groupId;
      final function = await removeGroupLocalUseCase.call(ParamsRemoveGroupLocalUseCase(groupId: groupId));
      function.fold(
        (failure) {
          emit(const ErrorGroupState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(RemoveGroupLocalState(hasRemoved: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupState(message: e.toString()));
    }
  }

  Future<void> saveGroupLocalEvent(event, emit) async {
    emit(const LoadingGroupState());
    try{
      final groupItem = event.groupItem;
      final function = await saveGroupLocalUseCase.call(ParamsSaveGroupLocalUseCase(groupItem: groupItem));
      function.fold(
        (failure) {
          emit(const ErrorGroupState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(SaveGroupLocalState(hasSaved: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupState(message: e.toString()));
    }
  }

  Future<void> getAllGroupsRemoteEvent(event, emit) async {
    emit(const LoadingGroupState());
    try{
      final function = await getAllGroupsRemoteUseCase.call(NoParams());
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorGroupState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorGroupState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(GetAllGroupsRemoteState(groupItems: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupState(message: e.toString()));
    }
  }

  Future<void> getGroupRemoteEvent(event, emit) async {
    emit(const LoadingGroupState());
    try{
      final groupId = event.groupId;
      final function = await getGroupRemoteUseCase.call(ParamsGetGroupRemoteUseCase(groupId: groupId));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorGroupState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorGroupState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(GetGroupRemoteState(groupItem: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupState(message: e.toString()));
    }
  }

  Future<void> saveGroupRemoteEvent(event, emit) async {
    emit(const LoadingGroupState());
    try{
      final groupItem = event.groupItem;
      final function = await saveGroupRemoteUseCase.call(ParamsSaveGroupRemoteUseCase(groupItem: groupItem));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorGroupState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorGroupState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(SaveGroupRemoteState(hasSaved: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupState(message: e.toString()));
    }
  }


}
