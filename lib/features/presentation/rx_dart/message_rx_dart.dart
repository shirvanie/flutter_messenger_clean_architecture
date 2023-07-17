


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
import 'package:rxdart/rxdart.dart';


class MessageRxDart {
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

  MessageRxDart({
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
  });


  final _existLocal = PublishSubject<bool>();
  final _existRemote = PublishSubject<bool>();
  final _messagesLocal = PublishSubject<List<MessageEntity>>();
  final _messagesRemote = PublishSubject<List<MessageEntity>>();
  final _messagesNotReadLocal = PublishSubject<List<MessageEntity>>();
  final _messagesUnsendLocal = PublishSubject<List<MessageEntity>>();
  final _messageLocal = PublishSubject<MessageEntity>();
  final _messageRemote = PublishSubject<MessageEntity>();
  final _missedMessagesRemote = PublishSubject<List<MessageEntity>>();
  final _removeLocal = PublishSubject<bool>();
  final _removeRemote = PublishSubject<bool>();
  final _saveLocal = PublishSubject<bool>();
  final _saveRemote = PublishSubject<bool>();
  final _updateAllRemote = PublishSubject<bool>();

  Stream<bool> get existLocal => _existLocal.stream;
  Stream<bool> get existRemote => _existRemote.stream;
  Stream<List<MessageEntity>> get messagesLocal => _messagesLocal.stream;
  Stream<List<MessageEntity>> get messagesRemote => _messagesRemote.stream;
  Stream<List<MessageEntity>> get messagesNotReadLocal => _messagesNotReadLocal.stream;
  Stream<List<MessageEntity>> get messagesUnsendLocal => _messagesUnsendLocal.stream;
  Stream<MessageEntity> get messageLocal => _messageLocal.stream;
  Stream<MessageEntity> get messageRemote => _messageRemote.stream;
  Stream<List<MessageEntity>> get missedMessagesRemote => _missedMessagesRemote.stream;
  Stream<bool> get removeLocal => _removeLocal.stream;
  Stream<bool> get removeRemote => _removeRemote.stream;
  Stream<bool> get saveLocal => _saveLocal.stream;
  Stream<bool> get saveRemote => _saveRemote.stream;
  Stream<bool> get updateAllRemote => _updateAllRemote.stream;

  void dispose() async {
    await _existLocal.drain(0);
    await _existRemote.drain(0);
    await _messagesLocal.drain(0);
    await _messagesRemote.drain(0);
    await _messagesNotReadLocal.drain(0);
    await _messagesUnsendLocal.drain(0);
    await _messageLocal.drain(0);
    await _messageRemote.drain(0);
    await _missedMessagesRemote.drain(0);
    await _removeLocal.drain(0);
    await _removeRemote.drain(0);
    await _saveLocal.drain(0);
    await _saveRemote.drain(0);
    await _updateAllRemote.drain(0);
    //
    _existLocal.close();
    _existRemote.close();
    _messagesLocal.close();
    _messagesRemote.close();
    _messagesNotReadLocal.close();
    _messagesUnsendLocal.close();
    _messageLocal.close();
    _messageRemote.close();
    _missedMessagesRemote.close();
    _removeLocal.close();
    _removeRemote.close();
    _saveLocal.close();
    _saveRemote.close();
    _updateAllRemote.close();
  }


  Future<void> existMessageLocal(String messageId) async {
    try{
      final function = await existMessageLocalUseCase.call(ParamsExistMessageLocalUseCase(messageId: messageId));
      function.fold(
              (failure) {
            _existLocal.sink.addError(Constants.databaseFailureMessage);
          },
              (data) {
            _existLocal.sink.add(data);
          }
      );
    } catch(e) {
      _existLocal.sink.addError(e.toString());
    }
  }

  Future<void> getAllMessagesLocal(String senderPhoneNumber, String targetPhoneNumber) async {
    try{
      final function = await getAllMessagesLocalUseCase.call(ParamsGetAllMessagesLocalUseCase(senderPhoneNumber: senderPhoneNumber, targetPhoneNumber: targetPhoneNumber));
      function.fold(
              (failure) {
            _messagesLocal.sink.addError(Constants.databaseFailureMessage);
          },
              (data) {
            _messagesLocal.sink.add(data);
          }
      );
    } catch(e) {
      _messagesLocal.sink.addError(e.toString());
    }
  }

  Future<void> getAllNotReadMessagesLocal(String senderPhoneNumber, String targetPhoneNumber) async {
    try{
      final function = await getAllNotReadMessagesLocalUseCase.call(ParamsGetAllNotReadMessagesLocalUseCase(senderPhoneNumber: senderPhoneNumber, targetPhoneNumber: targetPhoneNumber));
      function.fold(
              (failure) {
            _messagesNotReadLocal.sink.addError(Constants.databaseFailureMessage);
          },
              (data) {
            _messagesNotReadLocal.sink.add(data);
          }
      );
    } catch(e) {
      _messagesNotReadLocal.sink.addError(e.toString());
    }
  }

  Future<void> getAllUnsendMessagesLocal() async {
    try{
      final function = await getAllUnsendMessagesLocalUseCase.call(NoParams());
      function.fold(
              (failure) {
            _messagesUnsendLocal.sink.addError(Constants.databaseFailureMessage);
          },
              (data) {
            _messagesUnsendLocal.sink.add(data);
          }
      );
    } catch(e) {
      _messagesUnsendLocal.sink.addError(e.toString());
    }
  }

  Future<void> getMessageLocal(String messageId) async {
    try{
      final function = await getMessageLocalUseCase.call(ParamsGetMessageLocalUseCase(messageId: messageId));
      function.fold(
              (failure) {
            _messageLocal.sink.addError(Constants.databaseFailureMessage);
          },
              (data) {
            _messageLocal.sink.add(data);
          }
      );
    } catch(e) {
      _messageLocal.sink.addError(e.toString());
    }
  }

  Future<void> removeMessageLocal(String messageId) async {
    try{
      final function = await removeMessageLocalUseCase.call(ParamsRemoveMessageLocalUseCase(messageId: messageId));
      function.fold(
              (failure) {
            _removeLocal.sink.addError(Constants.databaseFailureMessage);
          },
              (data) {
            _removeLocal.sink.add(data);
          }
      );
    } catch(e) {
      _removeLocal.sink.addError(e.toString());
    }
  }

  Future<void> saveMessageLocal(MessageEntity messageItem) async {
    try{
      final function = await saveMessageLocalUseCase.call(ParamsSaveMessageLocalUseCase(messageItem: messageItem));
      function.fold(
              (failure) {
            _saveLocal.sink.addError(Constants.databaseFailureMessage);
          },
              (data) {
            _saveLocal.sink.add(data);
          }
      );
    } catch(e) {
      _saveLocal.sink.addError(e.toString());
    }
  }

  Future<void> getAllMessagesRemote(String senderPhoneNumber, String targetPhoneNumber) async {
    try{
      final function = await getAllMessagesRemoteUseCase.call(ParamsGetAllMessagesRemoteUseCase(senderPhoneNumber: senderPhoneNumber, targetPhoneNumber: targetPhoneNumber));
      function.fold(
              (failure) {
            if (failure is ServerFailure) {
              _messagesRemote.sink.addError(Constants.serverFailureMessage);
            } else if (failure is ConnectionFailure) {
              _messagesRemote.sink.addError(Constants.connectionFailureMessage);
            }
          },
              (data) {
            _messagesRemote.sink.add(data);
          }
      );
    } catch(e) {
      _messagesRemote.sink.addError(e.toString());
    }
  }

  Future<void> getMessageRemote(String messageId) async {
    try{
      final function = await getMessageRemoteUseCase.call(ParamsGetMessageRemoteUseCase(messageId: messageId));
      function.fold(
              (failure) {
            if (failure is ServerFailure) {
              _messageRemote.sink.addError(Constants.serverFailureMessage);
            } else if (failure is ConnectionFailure) {
              _messageRemote.sink.addError(Constants.connectionFailureMessage);
            }
          },
              (data) {
            _messageRemote.sink.add(data);
          }
      );
    } catch(e) {
      _messageRemote.sink.addError(e.toString());
    }
  }

  Future<void> getMissedMessagesRemote(String targetPhoneNumber) async {
    try{
      final function = await getMissedMessagesRemoteUseCase.call(ParamsGetMissedMessagesRemoteUseCase(targetPhoneNumber: targetPhoneNumber));
      function.fold(
              (failure) {
            if (failure is ServerFailure) {
              _missedMessagesRemote.sink.addError(Constants.serverFailureMessage);
            } else if (failure is ConnectionFailure) {
              _missedMessagesRemote.sink.addError(Constants.connectionFailureMessage);
            }
          },
              (data) {
            _missedMessagesRemote.sink.add(data);
          }
      );
    } catch(e) {
      _missedMessagesRemote.sink.addError(e.toString());
    }
  }

  Future<void> removeMessageRemote(String messageId) async {
    try{
      final function = await removeMessageRemoteUseCase.call(ParamsRemoveMessageRemoteUseCase(messageId: messageId));
      function.fold(
              (failure) {
            if (failure is ServerFailure) {
              _removeRemote.sink.addError(Constants.serverFailureMessage);
            } else if (failure is ConnectionFailure) {
              _removeRemote.sink.addError(Constants.connectionFailureMessage);
            }
          },
              (data) {
            _removeRemote.sink.add(data);
          }
      );
    } catch(e) {
      _removeRemote.sink.addError(e.toString());
    }
  }

  Future<void> saveMessageRemote(MessageEntity messageItem) async {
    try{
      final function = await saveMessageRemoteUseCase.call(ParamsSaveMessageRemoteUseCase(messageItem: messageItem));
      function.fold(
              (failure) {
            if (failure is ServerFailure) {
              _saveRemote.sink.addError(Constants.serverFailureMessage);
            } else if (failure is ConnectionFailure) {
              _saveRemote.sink.addError(Constants.connectionFailureMessage);
            }
          },
              (data) {
            _saveRemote.sink.add(data);
          }
      );
    } catch(e) {
      _saveRemote.sink.addError(e.toString());
    }
  }

  Future<void> updateAllMessagesRemote(List<MessageEntity> messageItems) async {
    try{
      final function = await updateAllMessagesRemoteUseCase.call(ParamsUpdateAllMessagesRemoteUseCase(messageItems: messageItems));
      function.fold(
              (failure) {
            if (failure is ServerFailure) {
              _updateAllRemote.sink.addError(Constants.serverFailureMessage);
            } else if (failure is ConnectionFailure) {
              _updateAllRemote.sink.addError(Constants.connectionFailureMessage);
            }
          },
              (data) {
            _updateAllRemote.sink.add(data);
          }
      );
    } catch(e) {
      _updateAllRemote.sink.addError(e.toString());
    }
  }

}
