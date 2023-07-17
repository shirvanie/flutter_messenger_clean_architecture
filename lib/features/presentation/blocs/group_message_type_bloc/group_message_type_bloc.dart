import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/features/domain/entities/group_message_type_entity.dart';
import 'package:messenger/features/domain/usecases/group_message_type_usecases/exist_group_message_type_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_type_usecases/get_all_group_message_types_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_type_usecases/get_all_group_message_types_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_type_usecases/get_all_notread_group_message_types_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_type_usecases/get_all_unsend_group_message_types_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_type_usecases/get_group_message_type_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_type_usecases/get_group_message_type_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_type_usecases/remove_group_message_type_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_type_usecases/remove_group_message_type_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_type_usecases/save_group_message_type_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_type_usecases/save_group_message_type_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_type_usecases/update_all_group_message_types_remote_usecase.dart';

part 'group_message_type_event.dart';
part 'group_message_type_state.dart';


class GroupMessageTypeBloc extends Bloc<GroupMessageTypeEvent, GroupMessageTypeState> {
  final ExistGroupMessageTypeLocalUseCase existGroupMessageTypeLocalUseCase;
  final GetAllGroupMessageTypesLocalUseCase getAllGroupMessageTypesLocalUseCase;
  final GetAllGroupMessageTypesRemoteUseCase getAllGroupMessageTypesRemoteUseCase;
  final GetAllNotReadGroupMessageTypesLocalUseCase getAllNotReadGroupMessageTypesLocalUseCase;
  final GetAllUnsendGroupMessageTypesLocalUseCase getAllUnsendGroupMessageTypesLocalUseCase;
  final GetGroupMessageTypeLocalUseCase getGroupMessageTypeLocalUseCase;
  final GetGroupMessageTypeRemoteUseCase getGroupMessageTypeRemoteUseCase;
  final RemoveGroupMessageTypeLocalUseCase removeGroupMessageTypeLocalUseCase;
  final RemoveGroupMessageTypeRemoteUseCase removeGroupMessageTypeRemoteUseCase;
  final SaveGroupMessageTypeLocalUseCase saveGroupMessageTypeLocalUseCase;
  final SaveGroupMessageTypeRemoteUseCase saveGroupMessageTypeRemoteUseCase;
  final UpdateAllGroupMessageTypesRemoteUseCase updateAllGroupMessageTypesRemoteUseCase;

  GroupMessageTypeBloc({
    required this.existGroupMessageTypeLocalUseCase,
    required this.getAllGroupMessageTypesLocalUseCase,
    required this.getAllGroupMessageTypesRemoteUseCase,
    required this.getAllNotReadGroupMessageTypesLocalUseCase,
    required this.getAllUnsendGroupMessageTypesLocalUseCase,
    required this.getGroupMessageTypeLocalUseCase,
    required this.getGroupMessageTypeRemoteUseCase,
    required this.removeGroupMessageTypeLocalUseCase,
    required this.removeGroupMessageTypeRemoteUseCase,
    required this.saveGroupMessageTypeLocalUseCase,
    required this.saveGroupMessageTypeRemoteUseCase,
    required this.updateAllGroupMessageTypesRemoteUseCase,
  }) : super(const InitGroupMessageTypeState()) {
    on<ExistGroupMessageTypeLocalEvent>(existGroupMessageTypeLocalEvent);
    on<GetAllGroupMessageTypesLocalEvent>(getAllGroupMessageTypesLocalEvent);
    on<GetAllGroupMessageTypesRemoteEvent>(getAllGroupMessageTypesRemoteEvent);
    on<GetAllNotReadGroupMessageTypesLocalEvent>(getAllNotReadGroupMessageTypesLocalEvent);
    on<GetAllUnsendGroupMessageTypesLocalEvent>(getAllUnsendGroupMessageTypesLocalEvent);
    on<GetGroupMessageTypeLocalEvent>(getGroupMessageTypeLocalEvent);
    on<GetGroupMessageTypeRemoteEvent>(getGroupMessageTypeRemoteEvent);
    on<RemoveGroupMessageTypeLocalEvent>(removeGroupMessageTypeLocalEvent);
    on<RemoveGroupMessageTypeRemoteEvent>(removeGroupMessageTypeRemoteEvent);
    on<SaveGroupMessageTypeLocalEvent>(saveGroupMessageTypeLocalEvent);
    on<SaveGroupMessageTypeRemoteEvent>(saveGroupMessageTypeRemoteEvent);
    on<UpdateAllGroupMessageTypesRemoteEvent>(updateAllGroupMessageTypesRemoteEvent);
  }

  Future<void> existGroupMessageTypeLocalEvent(event, emit) async {
    emit(const LoadingGroupMessageTypeState());
    try{
      final messageId = event.messageId;
      final function = await existGroupMessageTypeLocalUseCase.call(ParamsExistGroupMessageTypeLocalUseCase(messageId: messageId));
      function.fold(
        (failure) {
          emit(const ErrorGroupMessageTypeState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(ExistGroupMessageTypeLocalState(hasExistGroupMessageType: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupMessageTypeState(message: e.toString()));
    }
  }

  Future<void> getAllGroupMessageTypesLocalEvent(event, emit) async {
    emit(const LoadingGroupMessageTypeState());
    try{
      final groupId = event.groupId;
      final messageId = event.messageId;
      final function = await getAllGroupMessageTypesLocalUseCase.call(ParamsGetAllGroupMessageTypesLocalUseCase(groupId: groupId, messageId: messageId));
      function.fold(
        (failure) {
          emit(const ErrorGroupMessageTypeState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(GetAllGroupMessageTypesLocalState(groupMessageTypeItems: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupMessageTypeState(message: e.toString()));
    }
  }

  Future<void> getAllNotReadGroupMessageTypesLocalEvent(event, emit) async {
    emit(const LoadingGroupMessageTypeState());
    try{
      final groupId = event.groupId;
      final function = await getAllNotReadGroupMessageTypesLocalUseCase.call(ParamsGetAllNotReadGroupMessageTypesLocalUseCase(groupId: groupId));
      function.fold(
        (failure) {
          emit(const ErrorGroupMessageTypeState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(GetAllNotReadGroupMessageTypesLocalState(groupMessageTypeItems: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupMessageTypeState(message: e.toString()));
    }
  }

  Future<void> getAllUnsendGroupMessageTypesLocalEvent(event, emit) async {
    emit(const LoadingGroupMessageTypeState());
    try{
      final receiverPhoneNumber = event.receiverPhoneNumber;
      final function = await getAllUnsendGroupMessageTypesLocalUseCase.call(ParamsGetAllUnsendGroupMessageTypesLocalUseCase(receiverPhoneNumber: receiverPhoneNumber));
      function.fold(
        (failure) {
          emit(const ErrorGroupMessageTypeState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(GetAllUnsendGroupMessageTypesLocalState(groupMessageTypeItems: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupMessageTypeState(message: e.toString()));
    }
  }

  Future<void> getGroupMessageTypeLocalEvent(event, emit) async {
    emit(const LoadingGroupMessageTypeState());
    try{
      final messageId = event.messageId;
      final function = await getGroupMessageTypeLocalUseCase.call(ParamsGetGroupMessageTypeLocalUseCase(messageId: messageId));
      function.fold(
        (failure) {
          emit(const ErrorGroupMessageTypeState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(GetGroupMessageTypeLocalState(groupMessageTypeItem: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupMessageTypeState(message: e.toString()));
    }
  }

  Future<void> removeGroupMessageTypeLocalEvent(event, emit) async {
    emit(const LoadingGroupMessageTypeState());
    try{
      final messageId = event.messageId;
      final function = await removeGroupMessageTypeLocalUseCase.call(ParamsRemoveGroupMessageTypeLocalUseCase(messageId: messageId));
      function.fold(
        (failure) {
          emit(const ErrorGroupMessageTypeState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(RemoveGroupMessageTypeLocalState(hasRemoved: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupMessageTypeState(message: e.toString()));
    }
  }

  Future<void> saveGroupMessageTypeLocalEvent(event, emit) async {
    emit(const LoadingGroupMessageTypeState());
    try{
      final groupMessageTypeItem = event.groupMessageTypeItem;
      final function = await saveGroupMessageTypeLocalUseCase.call(ParamsSaveGroupMessageTypeLocalUseCase(groupMessageTypeItem: groupMessageTypeItem));
      function.fold(
        (failure) {
          emit(const ErrorGroupMessageTypeState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(SaveGroupMessageTypeLocalState(hasSaved: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupMessageTypeState(message: e.toString()));
    }
  }

  Future<void> getAllGroupMessageTypesRemoteEvent(event, emit) async {
    emit(const LoadingGroupMessageTypeState());
    try{
      final groupId = event.groupId;
      final messageId = event.messageId;
      final function = await getAllGroupMessageTypesRemoteUseCase.call(ParamsGetAllGroupMessageTypesRemoteUseCase(groupId: groupId, messageId: messageId));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorGroupMessageTypeState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorGroupMessageTypeState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(GetAllGroupMessageTypesRemoteState(groupMessageTypeItems: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupMessageTypeState(message: e.toString()));
    }
  }

  Future<void> getGroupMessageTypeRemoteEvent(event, emit) async {
    emit(const LoadingGroupMessageTypeState());
    try{
      final messageId = event.messageId;
      final function = await getGroupMessageTypeRemoteUseCase.call(ParamsGetGroupMessageTypeRemoteUseCase(messageId: messageId));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorGroupMessageTypeState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorGroupMessageTypeState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(GetGroupMessageTypeRemoteState(groupMessageTypeItem: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupMessageTypeState(message: e.toString()));
    }
  }

  Future<void> removeGroupMessageTypeRemoteEvent(event, emit) async {
    emit(const LoadingGroupMessageTypeState());
    try{
      final messageId = event.messageId;
      final function = await removeGroupMessageTypeRemoteUseCase.call(ParamsRemoveGroupMessageTypeRemoteUseCase(messageId: messageId));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorGroupMessageTypeState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorGroupMessageTypeState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(RemoveGroupMessageTypeRemoteState(hasRemoved: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupMessageTypeState(message: e.toString()));
    }
  }

  Future<void> saveGroupMessageTypeRemoteEvent(event, emit) async {
    emit(const LoadingGroupMessageTypeState());
    try{
      final groupMessageTypeItem = event.groupMessageTypeItem;
      final function = await saveGroupMessageTypeRemoteUseCase.call(ParamsSaveGroupMessageTypeRemoteUseCase(groupMessageTypeItem: groupMessageTypeItem));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorGroupMessageTypeState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorGroupMessageTypeState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(SaveGroupMessageTypeRemoteState(hasSaved: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupMessageTypeState(message: e.toString()));
    }
  }

  Future<void> updateAllGroupMessageTypesRemoteEvent(event, emit) async {
    emit(const LoadingGroupMessageTypeState());
    try{
      final groupMessageTypeItems = event.groupMessageTypeItems;
      final function = await updateAllGroupMessageTypesRemoteUseCase.call(ParamsUpdateAllGroupMessageTypesRemoteUseCase(groupMessageTypeItems: groupMessageTypeItems));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorGroupMessageTypeState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorGroupMessageTypeState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(UpdateAllGroupMessageTypesRemoteState(hasUpdate: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupMessageTypeState(message: e.toString()));
    }
  }



}
