import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/features/domain/entities/group_message_entity.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/exist_group_message_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/get_all_group_messages_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/get_all_group_messages_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/get_all_unsend_group_messages_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/get_group_message_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/get_group_message_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/get_missed_group_messages_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/remove_group_message_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/remove_group_message_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/save_group_message_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/save_group_message_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/update_all_group_messages_remote_usecase.dart';

part 'group_message_event.dart';
part 'group_message_state.dart';


class GroupMessageBloc extends Bloc<GroupMessageEvent, GroupMessageState> {
  final ExistGroupMessageLocalUseCase existGroupMessageLocalUseCase;
  final GetAllGroupMessagesLocalUseCase getAllGroupMessagesLocalUseCase;
  final GetAllGroupMessagesRemoteUseCase getAllGroupMessagesRemoteUseCase;
  final GetAllUnsendGroupMessagesLocalUseCase getAllUnsendGroupMessagesLocalUseCase;
  final GetGroupMessageLocalUseCase getGroupMessageLocalUseCase;
  final GetGroupMessageRemoteUseCase getGroupMessageRemoteUseCase;
  final GetMissedGroupMessagesRemoteUseCase getMissedGroupMessagesRemoteUseCase;
  final RemoveGroupMessageLocalUseCase removeGroupMessageLocalUseCase;
  final RemoveGroupMessageRemoteUseCase removeGroupMessageRemoteUseCase;
  final SaveGroupMessageLocalUseCase saveGroupMessageLocalUseCase;
  final SaveGroupMessageRemoteUseCase saveGroupMessageRemoteUseCase;
  final UpdateAllGroupMessagesRemoteUseCase updateAllGroupMessagesRemoteUseCase;

  GroupMessageBloc({
    required this.existGroupMessageLocalUseCase,
    required this.getAllGroupMessagesLocalUseCase,
    required this.getAllGroupMessagesRemoteUseCase,
    required this.getAllUnsendGroupMessagesLocalUseCase,
    required this.getGroupMessageLocalUseCase,
    required this.getGroupMessageRemoteUseCase,
    required this.getMissedGroupMessagesRemoteUseCase,
    required this.removeGroupMessageLocalUseCase,
    required this.removeGroupMessageRemoteUseCase,
    required this.saveGroupMessageLocalUseCase,
    required this.saveGroupMessageRemoteUseCase,
    required this.updateAllGroupMessagesRemoteUseCase,
  }) : super(const InitGroupMessageState()) {
    on<ExistGroupMessageLocalEvent>(existGroupMessageLocalEvent);
    on<GetAllGroupMessagesLocalEvent>(getAllGroupMessagesLocalEvent);
    on<GetAllGroupMessagesRemoteEvent>(getAllGroupMessagesRemoteEvent);
    on<GetAllUnsendGroupMessagesLocalEvent>(getAllUnsendGroupMessagesLocalEvent);
    on<GetGroupMessageLocalEvent>(getGroupMessageLocalEvent);
    on<GetGroupMessageRemoteEvent>(getGroupMessageRemoteEvent);
    on<GetMissedGroupMessagesRemoteEvent>(getMissedGroupMessagesRemoteEvent);
    on<RemoveGroupMessageLocalEvent>(removeGroupMessageLocalEvent);
    on<RemoveGroupMessageRemoteEvent>(removeGroupMessageRemoteEvent);
    on<SaveGroupMessageLocalEvent>(saveGroupMessageLocalEvent);
    on<SaveGroupMessageRemoteEvent>(saveGroupMessageRemoteEvent);
    on<UpdateAllGroupMessagesRemoteEvent>(updateAllGroupMessagesRemoteEvent);
  }

  Future<void> existGroupMessageLocalEvent(event, emit) async {
    emit(const LoadingGroupMessageState());
    try{
      final messageId = event.messageId;
      final function = await existGroupMessageLocalUseCase.call(ParamsExistGroupMessageLocalUseCase(messageId: messageId));
      function.fold(
        (failure) {
          emit(const ErrorGroupMessageState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(ExistGroupMessageLocalState(hasExistGroupMessage: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupMessageState(message: e.toString()));
    }
  }

  Future<void> getAllGroupMessagesLocalEvent(event, emit) async {
    emit(const LoadingGroupMessageState());
    try{
      final groupId = event.groupId;
      final function = await getAllGroupMessagesLocalUseCase.call(ParamsGetAllGroupMessagesLocalUseCase(groupId: groupId));
      function.fold(
        (failure) {
          emit(const ErrorGroupMessageState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(GetAllGroupMessagesLocalState(groupMessageItems: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupMessageState(message: e.toString()));
    }
  }

  Future<void> getAllUnsendGroupMessagesLocalEvent(event, emit) async {
    emit(const LoadingGroupMessageState());
    try{
      final senderPhoneNumber = event.senderPhoneNumber;
      final function = await getAllUnsendGroupMessagesLocalUseCase.call(ParamsGetAllUnsendGroupMessagesLocalUseCase(senderPhoneNumber: senderPhoneNumber));
      function.fold(
        (failure) {
          emit(const ErrorGroupMessageState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(GetAllUnsendGroupMessagesLocalState(groupMessageItems: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupMessageState(message: e.toString()));
    }
  }

  Future<void> getGroupMessageLocalEvent(event, emit) async {
    emit(const LoadingGroupMessageState());
    try{
      final messageId = event.messageId;
      final function = await getGroupMessageLocalUseCase.call(ParamsGetGroupMessageLocalUseCase(messageId: messageId));
      function.fold(
        (failure) {
          emit(const ErrorGroupMessageState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(GetGroupMessageLocalState(groupMessageItem: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupMessageState(message: e.toString()));
    }
  }

  Future<void> removeGroupMessageLocalEvent(event, emit) async {
    emit(const LoadingGroupMessageState());
    try{
      final messageId = event.messageId;
      final function = await removeGroupMessageLocalUseCase.call(ParamsRemoveGroupMessageLocalUseCase(messageId: messageId));
      function.fold(
        (failure) {
          emit(const ErrorGroupMessageState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(RemoveGroupMessageLocalState(hasRemoved: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupMessageState(message: e.toString()));
    }
  }

  Future<void> saveGroupMessageLocalEvent(event, emit) async {
    emit(const LoadingGroupMessageState());
    try{
      final groupMessageItem = event.groupMessageItem;
      final function = await saveGroupMessageLocalUseCase.call(ParamsSaveGroupMessageLocalUseCase(groupMessageItem: groupMessageItem));
      function.fold(
        (failure) {
          emit(const ErrorGroupMessageState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(SaveGroupMessageLocalState(hasSaved: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupMessageState(message: e.toString()));
    }
  }

  Future<void> getAllGroupMessagesRemoteEvent(event, emit) async {
    emit(const LoadingGroupMessageState());
    try{
      final groupId = event.groupId;
      final function = await getAllGroupMessagesRemoteUseCase.call(ParamsGetAllGroupMessagesRemoteUseCase(groupId: groupId));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorGroupMessageState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorGroupMessageState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(GetAllGroupMessagesRemoteState(groupMessageItems: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupMessageState(message: e.toString()));
    }
  }

  Future<void> getGroupMessageRemoteEvent(event, emit) async {
    emit(const LoadingGroupMessageState());
    try{
      final messageId = event.messageId;
      final function = await getGroupMessageRemoteUseCase.call(ParamsGetGroupMessageRemoteUseCase(messageId: messageId));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorGroupMessageState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorGroupMessageState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(GetGroupMessageRemoteState(groupMessageItem:  data));
        }
      );
    } catch(e) {
      emit(ErrorGroupMessageState(message: e.toString()));
    }
  }

  Future<void> getMissedGroupMessagesRemoteEvent(event, emit) async {
    emit(const LoadingGroupMessageState());
    try{
      final groupId = event.groupId;
      final receiverPhoneNumber = event.receiverPhoneNumber;
      final function = await getMissedGroupMessagesRemoteUseCase.call(ParamsGetMissedGroupMessagesRemoteUseCase(groupId: groupId, receiverPhoneNumber: receiverPhoneNumber));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorGroupMessageState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorGroupMessageState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(GetMissedGroupMessagesRemoteState(groupMessageItems: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupMessageState(message: e.toString()));
    }
  }

  Future<void> removeGroupMessageRemoteEvent(event, emit) async {
    emit(const LoadingGroupMessageState());
    try{
      final messageId = event.messageId;
      final function = await removeGroupMessageRemoteUseCase.call(ParamsRemoveGroupMessageRemoteUseCase(messageId: messageId));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorGroupMessageState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorGroupMessageState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(RemoveGroupMessageRemoteState(hasRemoved: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupMessageState(message: e.toString()));
    }
  }

  Future<void> saveGroupMessageRemoteEvent(event, emit) async {
    emit(const LoadingGroupMessageState());
    try{
      final groupMessageItem = event.groupMessageItem;
      final function = await saveGroupMessageRemoteUseCase.call(ParamsSaveGroupMessageRemoteUseCase(groupMessageItem: groupMessageItem));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorGroupMessageState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorGroupMessageState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(SaveGroupMessageRemoteState(hasSaved: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupMessageState(message: e.toString()));
    }
  }

  Future<void> updateAllGroupMessagesRemoteEvent(event, emit) async {
    emit(const LoadingGroupMessageState());
    try{
      final groupMessageItems = event.groupMessageItems;
      final function = await updateAllGroupMessagesRemoteUseCase.call(ParamsUpdateAllGroupMessagesRemoteUseCase(groupMessageItems: groupMessageItems));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorGroupMessageState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorGroupMessageState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(UpdateAllGroupMessagesRemoteState(hasUpdate: data));
        }
      );
    } catch(e) {
      emit(ErrorGroupMessageState(message: e.toString()));
    }
  }

}
