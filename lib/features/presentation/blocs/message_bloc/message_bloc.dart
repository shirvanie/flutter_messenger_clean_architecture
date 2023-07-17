

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/domain/entities/message_entity.dart';
import 'package:messenger/features/domain/usecases/message_usecases/exist_message_local_usecase.dart';
import 'package:messenger/features/domain/usecases/message_usecases/get_all_messages_local_usecase.dart';
import 'package:messenger/features/domain/usecases/message_usecases/get_all_messages_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/message_usecases/get_all_notread_messages_local_usecase.dart';
import 'package:messenger/features/domain/usecases/message_usecases/get_all_unsend_messages_local_usecase.dart';
import 'package:messenger/features/domain/usecases/message_usecases/get_message_local_usecase.dart';
import 'package:messenger/features/domain/usecases/message_usecases/get_message_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/message_usecases/get_missed_messages_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/message_usecases/remove_message_local_usecase.dart';
import 'package:messenger/features/domain/usecases/message_usecases/remove_message_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/message_usecases/save_message_local_usecase.dart';
import 'package:messenger/features/domain/usecases/message_usecases/save_message_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/message_usecases/update_all_messages_remote_usecase.dart';




part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final ExistMessageLocalUseCase existMessageLocalUseCase;
  final GetAllMessagesLocalUseCase getAllMessagesLocalUseCase;
  final GetAllMessagesRemoteUseCase getAllMessagesRemoteUseCase;
  final GetAllNotReadMessagesLocalUseCase getAllNotReadMessagesLocalUseCase;
  final GetAllUnsendMessagesLocalUseCase getAllUnsendMessagesLocalUseCase;
  final GetMessageLocalUseCase getMessageLocalUseCase;
  final GetMessageRemoteUseCase getMessageRemoteUseCase;
  final GetMissedMessagesRemoteUseCase getMissedMessagesRemoteUseCase;
  final RemoveMessageLocalUseCase removeMessageLocalUseCase;
  final RemoveMessageRemoteUseCase removeMessageRemoteUseCase;
  final SaveMessageLocalUseCase saveMessageLocalUseCase;
  final SaveMessageRemoteUseCase saveMessageRemoteUseCase;
  final UpdateAllMessagesRemoteUseCase updateAllMessagesRemoteUseCase;

  MessageBloc({
    required this.existMessageLocalUseCase,
    required this.getAllMessagesLocalUseCase,
    required this.getAllMessagesRemoteUseCase,
    required this.getAllNotReadMessagesLocalUseCase,
    required this.getAllUnsendMessagesLocalUseCase,
    required this.getMessageLocalUseCase,
    required this.getMessageRemoteUseCase,
    required this.getMissedMessagesRemoteUseCase,
    required this.removeMessageLocalUseCase,
    required this.removeMessageRemoteUseCase,
    required this.saveMessageLocalUseCase,
    required this.saveMessageRemoteUseCase,
    required this.updateAllMessagesRemoteUseCase,
  }) : super(const InitMessageState()) {
    on<ExistMessageLocalEvent>(existMessageLocalEvent);
    on<GetAllMessagesLocalEvent>(getAllMessagesLocalEvent);
    on<GetAllMessagesRemoteEvent>(getAllMessagesRemoteEvent);
    on<GetAllNotReadMessagesLocalEvent>(getAllNotReadMessagesLocalEvent);
    on<GetAllUnsendMessagesLocalEvent>(getAllUnsendMessagesLocalEvent);
    on<GetMessageLocalEvent>(getMessageLocalEvent);
    on<GetMessageRemoteEvent>(getMessageRemoteEvent);
    on<GetMissedMessagesRemoteEvent>(getMissedMessagesRemoteEvent);
    on<RemoveMessageLocalEvent>(removeMessageLocalEvent);
    on<RemoveMessageRemoteEvent>(removeMessageRemoteEvent);
    on<SaveMessageLocalEvent>(saveMessageLocalEvent);
    on<SaveMessageRemoteEvent>(saveMessageRemoteEvent);
    on<UpdateAllMessagesRemoteEvent>(updateAllMessagesRemoteEvent);
  }


  Future<void> existMessageLocalEvent(event, emit) async {
    emit(const LoadingMessageState());
    try{
      final messageId = event.messageId;
      final function = await existMessageLocalUseCase.call(ParamsExistMessageLocalUseCase(messageId: messageId));
      function.fold(
        (failure) {
          emit(const ErrorMessageState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(ExistMessageLocalState(hasExistMessage: data));
        }
      );
    } catch(e) {
      emit(ErrorMessageState(message: e.toString()));
    }
  }

  Future<void> getAllMessagesLocalEvent(event, emit) async {
    emit(const LoadingMessageState());
    try{
      final senderPhoneNumber = event.senderPhoneNumber;
      final targetPhoneNumber = event.targetPhoneNumber;
      final function = await getAllMessagesLocalUseCase.call(ParamsGetAllMessagesLocalUseCase(senderPhoneNumber: senderPhoneNumber, targetPhoneNumber: targetPhoneNumber));
      function.fold(
        (failure) {
          emit(const ErrorMessageState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(GetAllMessagesLocalState(messageItems: data));
        }
      );
    } catch(e) {
      emit(ErrorMessageState(message: e.toString()));
    }
  }

  Future<void> getAllNotReadMessagesLocalEvent(event, emit) async {
    emit(const LoadingMessageState());
    try{
      final senderPhoneNumber = event.senderPhoneNumber;
      final targetPhoneNumber = event.targetPhoneNumber;
      final function = await getAllNotReadMessagesLocalUseCase.call(ParamsGetAllNotReadMessagesLocalUseCase(senderPhoneNumber: senderPhoneNumber, targetPhoneNumber: targetPhoneNumber));
      function.fold(
        (failure) {
          emit(const ErrorMessageState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(GetAllNotReadMessagesLocalState(messageItems: data));
        }
      );
    } catch(e) {
      emit(ErrorMessageState(message: e.toString()));
    }
  }

  Future<void> getAllUnsendMessagesLocalEvent(event, emit) async {
    emit(const LoadingMessageState());
    try{
      final function = await getAllUnsendMessagesLocalUseCase.call(NoParams());
      function.fold(
        (failure) {
          emit(const ErrorMessageState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(GetAllUnsendMessagesLocalState(messageItems: data));
        }
      );
    } catch(e) {
      emit(ErrorMessageState(message: e.toString()));
    }
  }

  Future<void> getMessageLocalEvent(event, emit) async {
    emit(const LoadingMessageState());
    try{
      final messageId = event.messageId;
      final function = await getMessageLocalUseCase.call(ParamsGetMessageLocalUseCase(messageId: messageId));
      function.fold(
        (failure) {
          emit(const ErrorMessageState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(GetMessageLocalState(messageItem: data));
        }
      );
    } catch(e) {
      emit(ErrorMessageState(message: e.toString()));
    }
  }

  Future<void> removeMessageLocalEvent(event, emit) async {
    emit(const LoadingMessageState());
    try{
      final messageId = event.messageId;
      final function = await removeMessageLocalUseCase.call(ParamsRemoveMessageLocalUseCase(messageId: messageId));
      function.fold(
        (failure) {
          emit(const ErrorMessageState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(RemoveMessageLocalState(hasRemoved: data));
        }
      );
    } catch(e) {
      emit(ErrorMessageState(message: e.toString()));
    }
  }

  Future<void> saveMessageLocalEvent(event, emit) async {
    emit(const LoadingMessageState());
    try{
      final messageItem = event.messageItem;
      final function = await saveMessageLocalUseCase.call(ParamsSaveMessageLocalUseCase(messageItem: messageItem));
      function.fold(
        (failure) {
          emit(const ErrorMessageState(message: Constants.databaseFailureMessage));
        },
        (data) {
          emit(SaveMessageLocalState(hasSaved: data));
        }
      );
    } catch(e) {
      emit(ErrorMessageState(message: e.toString()));
    }
  }

  Future<void> getAllMessagesRemoteEvent(event, emit) async {
    emit(const LoadingMessageState());
    try{
      final senderPhoneNumber = event.senderPhoneNumber;
      final targetPhoneNumber = event.targetPhoneNumber;
      final function = await getAllMessagesRemoteUseCase.call(ParamsGetAllMessagesRemoteUseCase(senderPhoneNumber: senderPhoneNumber, targetPhoneNumber: targetPhoneNumber));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorMessageState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorMessageState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(GetAllMessagesRemoteState(messageItems: data));
        }
      );
    } catch(e) {
      emit(ErrorMessageState(message: e.toString()));
    }
  }

  Future<void> getMessageRemoteEvent(event, emit) async {
    emit(const LoadingMessageState());
    try{
      final messageId = event.messageId;
      final function = await getMessageRemoteUseCase.call(ParamsGetMessageRemoteUseCase(messageId: messageId));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorMessageState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorMessageState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(GetMessageRemoteState(messageItem: data));
        }
      );
    } catch(e) {
      emit(ErrorMessageState(message: e.toString()));
    }
  }

  Future<void> getMissedMessagesRemoteEvent(event, emit) async {
    emit(const LoadingMessageState());
    try{
      final targetPhoneNumber = event.targetPhoneNumber;
      final function = await getMissedMessagesRemoteUseCase.call(ParamsGetMissedMessagesRemoteUseCase(targetPhoneNumber: targetPhoneNumber));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorMessageState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorMessageState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(GetMissedMessagesRemoteState(messageItems: data));
        }
      );
    } catch(e) {
      emit(ErrorMessageState(message: e.toString()));
    }
  }

  Future<void> removeMessageRemoteEvent(event, emit) async {
    emit(const LoadingMessageState());
    try{
      final messageId = event.messageId;
      final function = await removeMessageRemoteUseCase.call(ParamsRemoveMessageRemoteUseCase(messageId: messageId));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorMessageState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorMessageState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(RemoveMessageRemoteState(hasRemoved: data));
        }
      );
    } catch(e) {
      emit(ErrorMessageState(message: e.toString()));
    }
  }

  Future<void> saveMessageRemoteEvent(event, emit) async {
    emit(const LoadingMessageState());
    try{
      final messageItem = event.messageItem;
      final function = await saveMessageRemoteUseCase.call(ParamsSaveMessageRemoteUseCase(messageItem: messageItem));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorMessageState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorMessageState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(SaveMessageRemoteState(hasSaved: data));
        }
      );
    } catch(e) {
      emit(ErrorMessageState(message: e.toString()));
    }
  }

  Future<void> updateAllMessagesRemoteEvent(event, emit) async {
    emit(const LoadingMessageState());
    try{
      final messageItems = event.messageItems;
      final function = await updateAllMessagesRemoteUseCase.call(ParamsUpdateAllMessagesRemoteUseCase(messageItems: messageItems));
      function.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(const ErrorMessageState(message: Constants.serverFailureMessage));
          } else if (failure is ConnectionFailure) {
            emit(const ErrorMessageState(message: Constants.connectionFailureMessage));
          }
        },
        (data) {
          emit(UpdateAllMessagesRemoteState(hasUpdate: data));
        }
      );
    } catch(e) {
      emit(ErrorMessageState(message: e.toString()));
    }
  }



}
