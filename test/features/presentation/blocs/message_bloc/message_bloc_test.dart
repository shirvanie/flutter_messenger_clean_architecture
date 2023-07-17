



import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/data/models/message_model.dart';
import 'package:messenger/features/domain/usecases/message_usecases/exist_message_local_usecase.dart';
import 'package:messenger/features/domain/usecases/message_usecases/get_all_messages_local_usecase.dart';
import 'package:messenger/features/domain/usecases/message_usecases/get_all_messages_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/message_usecases/get_all_notread_messages_local_usecase.dart';
import 'package:messenger/features/domain/usecases/message_usecases/get_message_local_usecase.dart';
import 'package:messenger/features/domain/usecases/message_usecases/get_message_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/message_usecases/get_missed_messages_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/message_usecases/remove_message_local_usecase.dart';
import 'package:messenger/features/domain/usecases/message_usecases/remove_message_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/message_usecases/save_message_local_usecase.dart';
import 'package:messenger/features/domain/usecases/message_usecases/save_message_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/message_usecases/update_all_messages_remote_usecase.dart';
import 'package:messenger/features/presentation/blocs/message_bloc/message_bloc.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MessageBloc messageBloc;
  late MockExistMessageLocalUseCase mockExistMessageLocalUseCase;
  late MockGetAllMessagesLocalUseCase mockGetAllMessagesLocalUseCase;
  late MockGetAllMessagesRemoteUseCase mockGetAllMessagesRemoteUseCase;
  late MockGetAllNotReadMessagesLocalUseCase mockGetAllNotReadMessagesLocalUseCase;
  late MockGetAllUnsendMessagesLocalUseCase mockGetAllUnsendMessagesLocalUseCase;
  late MockGetMessageLocalUseCase mockGetMessageLocalUseCase;
  late MockGetMessageRemoteUseCase mockGetMessageRemoteUseCase;
  late MockGetMissedMessagesRemoteUseCase mockGetMissedMessagesRemoteUseCase;
  late MockRemoveMessageLocalUseCase mockRemoveMessageLocalUseCase;
  late MockRemoveMessageRemoteUseCase mockRemoveMessageRemoteUseCase;
  late MockSaveMessageLocalUseCase mockSaveMessageLocalUseCase;
  late MockSaveMessageRemoteUseCase mockSaveMessageRemoteUseCase;
  late MockUpdateAllMessagesRemoteUseCase mockUpdateAllMessagesRemoteUseCase;

  setUp(() {
    mockExistMessageLocalUseCase = MockExistMessageLocalUseCase();
    mockGetAllMessagesLocalUseCase = MockGetAllMessagesLocalUseCase();
    mockGetAllMessagesRemoteUseCase = MockGetAllMessagesRemoteUseCase();
    mockGetAllNotReadMessagesLocalUseCase = MockGetAllNotReadMessagesLocalUseCase();
    mockGetAllUnsendMessagesLocalUseCase = MockGetAllUnsendMessagesLocalUseCase();
    mockGetMessageLocalUseCase = MockGetMessageLocalUseCase();
    mockGetMessageRemoteUseCase = MockGetMessageRemoteUseCase();
    mockGetMissedMessagesRemoteUseCase = MockGetMissedMessagesRemoteUseCase();
    mockRemoveMessageLocalUseCase = MockRemoveMessageLocalUseCase();
    mockRemoveMessageRemoteUseCase = MockRemoveMessageRemoteUseCase();
    mockSaveMessageLocalUseCase = MockSaveMessageLocalUseCase();
    mockSaveMessageRemoteUseCase = MockSaveMessageRemoteUseCase();
    mockUpdateAllMessagesRemoteUseCase = MockUpdateAllMessagesRemoteUseCase();

    messageBloc = MessageBloc(
      existMessageLocalUseCase: mockExistMessageLocalUseCase,
      getAllMessagesLocalUseCase: mockGetAllMessagesLocalUseCase,
      getAllMessagesRemoteUseCase: mockGetAllMessagesRemoteUseCase,
      getAllNotReadMessagesLocalUseCase: mockGetAllNotReadMessagesLocalUseCase,
      getAllUnsendMessagesLocalUseCase: mockGetAllUnsendMessagesLocalUseCase,
      getMessageLocalUseCase: mockGetMessageLocalUseCase,
      getMessageRemoteUseCase: mockGetMessageRemoteUseCase,
      getMissedMessagesRemoteUseCase: mockGetMissedMessagesRemoteUseCase,
      removeMessageLocalUseCase: mockRemoveMessageLocalUseCase,
      removeMessageRemoteUseCase: mockRemoveMessageRemoteUseCase,
      saveMessageLocalUseCase: mockSaveMessageLocalUseCase,
      saveMessageRemoteUseCase: mockSaveMessageRemoteUseCase,
      updateAllMessagesRemoteUseCase: mockUpdateAllMessagesRemoteUseCase,
    );
  });

  final testJson = fixtureReader("message_model.json");
  final testMessageModel = MessageModel.fromJson(json.decode(testJson));
  String messageId = testMessageModel.messageId.toString();
  String senderPhoneNumber = testMessageModel.senderPhoneNumber.toString();
  String targetPhoneNumber = testMessageModel.targetPhoneNumber.toString();


  test("initial state should be InitMessageState", () {
    // assert
    expect(messageBloc.state, const InitMessageState());
  });

  group("existMessageLocalEvent", () {
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ExistMessageLocalState] when data is gotten successfully',
      build: () {
        when(mockExistMessageLocalUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return messageBloc;
      },
      act: (bloc) => bloc.add(ExistMessageLocalEvent(messageId)),
      expect: () => [
        const LoadingMessageState(),
        const ExistMessageLocalState(hasExistMessage: true),
      ],
      verify: (bloc) {
        verify(mockExistMessageLocalUseCase.call(ParamsExistMessageLocalUseCase(messageId: messageId)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockExistMessageLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return messageBloc;
      },
      act: (bloc) => bloc.add(ExistMessageLocalEvent(messageId)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockExistMessageLocalUseCase.call(ParamsExistMessageLocalUseCase(messageId: messageId)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(Exception)] when something went wrong',
      build: () {
        when(mockExistMessageLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return messageBloc;
      },
      act: (bloc) => bloc.add(ExistMessageLocalEvent(messageId)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockExistMessageLocalUseCase.call(ParamsExistMessageLocalUseCase(messageId: messageId)));
      },
    );
  });

  group("getAllMessagesLocalEvent", () {
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, GetAllMessagesLocalState] when data is gotten successfully',
      build: () {
        when(mockGetAllMessagesLocalUseCase.call(any))
            .thenAnswer((_) async => Right([testMessageModel]));
        return messageBloc;
      },
      act: (bloc) => bloc.add(GetAllMessagesLocalEvent(senderPhoneNumber, targetPhoneNumber)),
      expect: () => [
        const LoadingMessageState(),
        GetAllMessagesLocalState(messageItems: [testMessageModel]),
      ],
      verify: (bloc) {
        verify(mockGetAllMessagesLocalUseCase.call(ParamsGetAllMessagesLocalUseCase(senderPhoneNumber: senderPhoneNumber, targetPhoneNumber: targetPhoneNumber)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockGetAllMessagesLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return messageBloc;
      },
      act: (bloc) => bloc.add(GetAllMessagesLocalEvent(senderPhoneNumber, targetPhoneNumber)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetAllMessagesLocalUseCase.call(ParamsGetAllMessagesLocalUseCase(senderPhoneNumber: senderPhoneNumber, targetPhoneNumber: targetPhoneNumber)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(Exception)] when something went wrong',
      build: () {
        when(mockGetAllMessagesLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return messageBloc;
      },
      act: (bloc) => bloc.add(GetAllMessagesLocalEvent(senderPhoneNumber, targetPhoneNumber)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetAllMessagesLocalUseCase.call(ParamsGetAllMessagesLocalUseCase(senderPhoneNumber: senderPhoneNumber, targetPhoneNumber: targetPhoneNumber)));
      },
    );
  });

  group("getAllNotReadMessagesLocalEvent", () {
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, GetAllNotReadMessagesLocalState] when data is gotten successfully',
      build: () {
        when(mockGetAllNotReadMessagesLocalUseCase.call(any))
            .thenAnswer((_) async => Right([testMessageModel]));
        return messageBloc;
      },
      act: (bloc) => bloc.add(GetAllNotReadMessagesLocalEvent(senderPhoneNumber, targetPhoneNumber)),
      expect: () => [
        const LoadingMessageState(),
        GetAllNotReadMessagesLocalState(messageItems: [testMessageModel]),
      ],
      verify: (bloc) {
        verify(mockGetAllNotReadMessagesLocalUseCase.call(ParamsGetAllNotReadMessagesLocalUseCase(senderPhoneNumber: senderPhoneNumber, targetPhoneNumber: targetPhoneNumber)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockGetAllNotReadMessagesLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return messageBloc;
      },
      act: (bloc) => bloc.add(GetAllNotReadMessagesLocalEvent(senderPhoneNumber, targetPhoneNumber)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetAllNotReadMessagesLocalUseCase.call(ParamsGetAllNotReadMessagesLocalUseCase(senderPhoneNumber: senderPhoneNumber, targetPhoneNumber: targetPhoneNumber)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(Exception)] when something went wrong',
      build: () {
        when(mockGetAllNotReadMessagesLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return messageBloc;
      },
      act: (bloc) => bloc.add(GetAllNotReadMessagesLocalEvent(senderPhoneNumber, targetPhoneNumber)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetAllNotReadMessagesLocalUseCase.call(ParamsGetAllNotReadMessagesLocalUseCase(senderPhoneNumber: senderPhoneNumber, targetPhoneNumber: targetPhoneNumber)));
      },
    );
  });

  group("getAllUnsendMessagesLocalEvent", () {
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, GetAllUnsendMessagesLocalState] when data is gotten successfully',
      build: () {
        when(mockGetAllUnsendMessagesLocalUseCase.call(any))
            .thenAnswer((_) async => Right([testMessageModel]));
        return messageBloc;
      },
      act: (bloc) => bloc.add(const GetAllUnsendMessagesLocalEvent()),
      expect: () => [
        const LoadingMessageState(),
        GetAllUnsendMessagesLocalState(messageItems: [testMessageModel]),
      ],
      verify: (bloc) {
        verify(mockGetAllUnsendMessagesLocalUseCase.call(NoParams()));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockGetAllUnsendMessagesLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return messageBloc;
      },
      act: (bloc) => bloc.add(const GetAllUnsendMessagesLocalEvent()),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetAllUnsendMessagesLocalUseCase.call(NoParams()));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(Exception)] when something went wrong',
      build: () {
        when(mockGetAllUnsendMessagesLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return messageBloc;
      },
      act: (bloc) => bloc.add(const GetAllUnsendMessagesLocalEvent()),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetAllUnsendMessagesLocalUseCase.call(NoParams()));
      },
    );
  });

  group("getMessageLocalEvent", () {
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, GetMessageLocalEvent] when data is gotten successfully',
      build: () {
        when(mockGetMessageLocalUseCase.call(any))
            .thenAnswer((_) async => Right(testMessageModel));
        return messageBloc;
      },
      act: (bloc) => bloc.add(GetMessageLocalEvent(messageId)),
      expect: () => [
        const LoadingMessageState(),
        GetMessageLocalState(messageItem: testMessageModel),
      ],
      verify: (bloc) {
        verify(mockGetMessageLocalUseCase.call(ParamsGetMessageLocalUseCase(messageId: messageId)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockGetMessageLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return messageBloc;
      },
      act: (bloc) => bloc.add(GetMessageLocalEvent(messageId)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetMessageLocalUseCase.call(ParamsGetMessageLocalUseCase(messageId: messageId)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(Exception)] when something went wrong',
      build: () {
        when(mockGetMessageLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return messageBloc;
      },
      act: (bloc) => bloc.add(GetMessageLocalEvent(messageId)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetMessageLocalUseCase.call(ParamsGetMessageLocalUseCase(messageId: messageId)));
      },
    );
  });

  group("removeMessageLocalEvent", () {
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, RemoveMessageLocalEvent] when data is gotten successfully',
      build: () {
        when(mockRemoveMessageLocalUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return messageBloc;
      },
      act: (bloc) => bloc.add(RemoveMessageLocalEvent(messageId)),
      expect: () => [
        const LoadingMessageState(),
        const RemoveMessageLocalState(hasRemoved: true),
      ],
      verify: (bloc) {
        verify(mockRemoveMessageLocalUseCase.call(ParamsRemoveMessageLocalUseCase(messageId: messageId)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockRemoveMessageLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return messageBloc;
      },
      act: (bloc) => bloc.add(RemoveMessageLocalEvent(messageId)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockRemoveMessageLocalUseCase.call(ParamsRemoveMessageLocalUseCase(messageId: messageId)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(Exception)] when something went wrong',
      build: () {
        when(mockRemoveMessageLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return messageBloc;
      },
      act: (bloc) => bloc.add(RemoveMessageLocalEvent(messageId)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockRemoveMessageLocalUseCase.call(ParamsRemoveMessageLocalUseCase(messageId: messageId)));
      },
    );
  });

  group("saveMessageLocalEvent", () {
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, SaveMessageLocalEvent] when data is gotten successfully',
      build: () {
        when(mockSaveMessageLocalUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return messageBloc;
      },
      act: (bloc) => bloc.add(SaveMessageLocalEvent(testMessageModel)),
      expect: () => [
        const LoadingMessageState(),
        const SaveMessageLocalState(hasSaved: true),
      ],
      verify: (bloc) {
        verify(mockSaveMessageLocalUseCase.call(ParamsSaveMessageLocalUseCase(messageItem: testMessageModel)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockSaveMessageLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return messageBloc;
      },
      act: (bloc) => bloc.add(SaveMessageLocalEvent(testMessageModel)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockSaveMessageLocalUseCase.call(ParamsSaveMessageLocalUseCase(messageItem: testMessageModel)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(Exception)] when something went wrong',
      build: () {
        when(mockSaveMessageLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return messageBloc;
      },
      act: (bloc) => bloc.add(SaveMessageLocalEvent(testMessageModel)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockSaveMessageLocalUseCase.call(ParamsSaveMessageLocalUseCase(messageItem: testMessageModel)));
      },
    );
  });

  group("getAllMessagesRemoteEvent", () {
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, GetAllMessagesRemoteState] when data is gotten successfully',
      build: () {
        when(mockGetAllMessagesRemoteUseCase.call(any))
            .thenAnswer((_) async => Right([testMessageModel]));
        return messageBloc;
      },
      act: (bloc) => bloc.add(GetAllMessagesRemoteEvent(senderPhoneNumber, targetPhoneNumber)),
      expect: () => [
        const LoadingMessageState(),
        GetAllMessagesRemoteState(messageItems: [testMessageModel]),
      ],
      verify: (bloc) {
        verify(mockGetAllMessagesRemoteUseCase.call(ParamsGetAllMessagesRemoteUseCase(senderPhoneNumber: senderPhoneNumber, targetPhoneNumber: targetPhoneNumber)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockGetAllMessagesRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return messageBloc;
      },
      act: (bloc) => bloc.add(GetAllMessagesRemoteEvent(senderPhoneNumber, targetPhoneNumber)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetAllMessagesRemoteUseCase.call(ParamsGetAllMessagesRemoteUseCase(senderPhoneNumber: senderPhoneNumber, targetPhoneNumber: targetPhoneNumber)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockGetAllMessagesRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return messageBloc;
      },
      act: (bloc) => bloc.add(GetAllMessagesRemoteEvent(senderPhoneNumber, targetPhoneNumber)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetAllMessagesRemoteUseCase.call(ParamsGetAllMessagesRemoteUseCase(senderPhoneNumber: senderPhoneNumber, targetPhoneNumber: targetPhoneNumber)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(Exception)] when something went wrong',
      build: () {
        when(mockGetAllMessagesRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return messageBloc;
      },
      act: (bloc) => bloc.add(GetAllMessagesRemoteEvent(senderPhoneNumber, targetPhoneNumber)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetAllMessagesRemoteUseCase.call(ParamsGetAllMessagesRemoteUseCase(senderPhoneNumber: senderPhoneNumber, targetPhoneNumber: targetPhoneNumber)));
      },
    );
  });

  group("getMessageRemoteEvent", () {
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, GetMessageRemoteEvent] when data is gotten successfully',
      build: () {
        when(mockGetMessageRemoteUseCase.call(any))
            .thenAnswer((_) async => Right(testMessageModel));
        return messageBloc;
      },
      act: (bloc) => bloc.add(GetMessageRemoteEvent(messageId)),
      expect: () => [
        const LoadingMessageState(),
        GetMessageRemoteState(messageItem: testMessageModel),
      ],
      verify: (bloc) {
        verify(mockGetMessageRemoteUseCase.call(ParamsGetMessageRemoteUseCase(messageId: messageId)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockGetMessageRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return messageBloc;
      },
      act: (bloc) => bloc.add(GetMessageRemoteEvent(messageId)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetMessageRemoteUseCase.call(ParamsGetMessageRemoteUseCase(messageId: messageId)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockGetMessageRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return messageBloc;
      },
      act: (bloc) => bloc.add(GetMessageRemoteEvent(messageId)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetMessageRemoteUseCase.call(ParamsGetMessageRemoteUseCase(messageId: messageId)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(Exception)] when something went wrong',
      build: () {
        when(mockGetMessageRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return messageBloc;
      },
      act: (bloc) => bloc.add(GetMessageRemoteEvent(messageId)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetMessageRemoteUseCase.call(ParamsGetMessageRemoteUseCase(messageId: messageId)));
      },
    );
  });

  group("getMissedMessagesRemoteEvent", () {
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, GetMissedMessagesRemoteState] when data is gotten successfully',
      build: () {
        when(mockGetMissedMessagesRemoteUseCase.call(any))
            .thenAnswer((_) async => Right([testMessageModel]));
        return messageBloc;
      },
      act: (bloc) => bloc.add(GetMissedMessagesRemoteEvent(targetPhoneNumber)),
      expect: () => [
        const LoadingMessageState(),
        GetMissedMessagesRemoteState(messageItems: [testMessageModel]),
      ],
      verify: (bloc) {
        verify(mockGetMissedMessagesRemoteUseCase.call(ParamsGetMissedMessagesRemoteUseCase(targetPhoneNumber: targetPhoneNumber)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockGetMissedMessagesRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return messageBloc;
      },
      act: (bloc) => bloc.add(GetMissedMessagesRemoteEvent(targetPhoneNumber)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetMissedMessagesRemoteUseCase.call(ParamsGetMissedMessagesRemoteUseCase(targetPhoneNumber: targetPhoneNumber)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockGetMissedMessagesRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return messageBloc;
      },
      act: (bloc) => bloc.add(GetMissedMessagesRemoteEvent(targetPhoneNumber)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetMissedMessagesRemoteUseCase.call(ParamsGetMissedMessagesRemoteUseCase(targetPhoneNumber: targetPhoneNumber)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(Exception)] when something went wrong',
      build: () {
        when(mockGetMissedMessagesRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return messageBloc;
      },
      act: (bloc) => bloc.add(GetMissedMessagesRemoteEvent(targetPhoneNumber)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetMissedMessagesRemoteUseCase.call(ParamsGetMissedMessagesRemoteUseCase(targetPhoneNumber: targetPhoneNumber)));
      },
    );
  });

  group("removeMessageRemoteEvent", () {
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, RemoveMessageRemoteEvent] when data is gotten successfully',
      build: () {
        when(mockRemoveMessageRemoteUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return messageBloc;
      },
      act: (bloc) => bloc.add(RemoveMessageRemoteEvent(messageId)),
      expect: () => [
        const LoadingMessageState(),
        const RemoveMessageRemoteState(hasRemoved: true),
      ],
      verify: (bloc) {
        verify(mockRemoveMessageRemoteUseCase.call(ParamsRemoveMessageRemoteUseCase(messageId: messageId)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockRemoveMessageRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return messageBloc;
      },
      act: (bloc) => bloc.add(RemoveMessageRemoteEvent(messageId)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockRemoveMessageRemoteUseCase.call(ParamsRemoveMessageRemoteUseCase(messageId: messageId)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockRemoveMessageRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return messageBloc;
      },
      act: (bloc) => bloc.add(RemoveMessageRemoteEvent(messageId)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockRemoveMessageRemoteUseCase.call(ParamsRemoveMessageRemoteUseCase(messageId: messageId)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(Exception)] when something went wrong',
      build: () {
        when(mockRemoveMessageRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return messageBloc;
      },
      act: (bloc) => bloc.add(RemoveMessageRemoteEvent(messageId)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockRemoveMessageRemoteUseCase.call(ParamsRemoveMessageRemoteUseCase(messageId: messageId)));
      },
    );
  });

  group("saveMessageRemoteEvent", () {
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, SaveMessageRemoteEvent] when data is gotten successfully',
      build: () {
        when(mockSaveMessageRemoteUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return messageBloc;
      },
      act: (bloc) => bloc.add(SaveMessageRemoteEvent(testMessageModel)),
      expect: () => [
        const LoadingMessageState(),
        const SaveMessageRemoteState(hasSaved: true),
      ],
      verify: (bloc) {
        verify(mockSaveMessageRemoteUseCase.call(ParamsSaveMessageRemoteUseCase(messageItem: testMessageModel)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockSaveMessageRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return messageBloc;
      },
      act: (bloc) => bloc.add(SaveMessageRemoteEvent(testMessageModel)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockSaveMessageRemoteUseCase.call(ParamsSaveMessageRemoteUseCase(messageItem: testMessageModel)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockSaveMessageRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return messageBloc;
      },
      act: (bloc) => bloc.add(SaveMessageRemoteEvent(testMessageModel)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockSaveMessageRemoteUseCase.call(ParamsSaveMessageRemoteUseCase(messageItem: testMessageModel)));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(Exception)] when something went wrong',
      build: () {
        when(mockSaveMessageRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return messageBloc;
      },
      act: (bloc) => bloc.add(SaveMessageRemoteEvent(testMessageModel)),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockSaveMessageRemoteUseCase.call(ParamsSaveMessageRemoteUseCase(messageItem: testMessageModel)));
      },
    );
  });

  group("updateAllMessageRemoteEvent", () {
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, UpdateAllMessagesRemoteEvent] when data is gotten successfully',
      build: () {
        when(mockUpdateAllMessagesRemoteUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return messageBloc;
      },
      act: (bloc) => bloc.add(UpdateAllMessagesRemoteEvent([testMessageModel])),
      expect: () => [
        const LoadingMessageState(),
        const UpdateAllMessagesRemoteState(hasUpdate: true),
      ],
      verify: (bloc) {
        verify(mockUpdateAllMessagesRemoteUseCase.call(ParamsUpdateAllMessagesRemoteUseCase(messageItems: [testMessageModel])));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockUpdateAllMessagesRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return messageBloc;
      },
      act: (bloc) => bloc.add(UpdateAllMessagesRemoteEvent([testMessageModel])),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockUpdateAllMessagesRemoteUseCase.call(ParamsUpdateAllMessagesRemoteUseCase(messageItems: [testMessageModel])));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockUpdateAllMessagesRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return messageBloc;
      },
      act: (bloc) => bloc.add(UpdateAllMessagesRemoteEvent([testMessageModel])),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockUpdateAllMessagesRemoteUseCase.call(ParamsUpdateAllMessagesRemoteUseCase(messageItems: [testMessageModel])));
      },
    );
    blocTest<MessageBloc, MessageState>(
      'Should emit [LoadingMessageState, ErrorMessageState(Exception)] when something went wrong',
      build: () {
        when(mockUpdateAllMessagesRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return messageBloc;
      },
      act: (bloc) => bloc.add(UpdateAllMessagesRemoteEvent([testMessageModel])),
      expect: () => [
        const LoadingMessageState(),
        const ErrorMessageState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockUpdateAllMessagesRemoteUseCase.call(ParamsUpdateAllMessagesRemoteUseCase(messageItems: [testMessageModel])));
      },
    );
  });

}