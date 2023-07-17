



import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/features/data/models/group_message_model.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/exist_group_message_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/get_all_group_messages_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/get_all_group_messages_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/get_all_unsend_group_messages_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/get_group_message_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/get_group_message_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/get_missed_group_messages_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/remove_group_message_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/remove_group_message_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/save_group_message_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/save_group_message_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/update_all_group_messages_remote_usecase.dart';
import 'package:messenger/features/presentation/blocs/group_message_bloc/group_message_bloc.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GroupMessageBloc groupMessageBloc;
  late MockExistGroupMessageLocalUseCase mockExistGroupMessageLocalUseCase;
  late MockGetAllGroupMessagesLocalUseCase mockGetAllGroupMessagesLocalUseCase;
  late MockGetAllGroupMessagesRemoteUseCase mockGetAllGroupMessagesRemoteUseCase;
  late MockGetAllUnsendGroupMessagesLocalUseCase mockGetAllUnsendGroupMessagesLocalUseCase;
  late MockGetGroupMessageLocalUseCase mockGetGroupMessageLocalUseCase;
  late MockGetGroupMessageRemoteUseCase mockGetGroupMessageRemoteUseCase;
  late MockGetMissedGroupMessagesRemoteUseCase mockGetMissedGroupMessagesRemoteUseCase;
  late MockRemoveGroupMessageLocalUseCase mockRemoveGroupMessageLocalUseCase;
  late MockRemoveGroupMessageRemoteUseCase mockRemoveGroupMessageRemoteUseCase;
  late MockSaveGroupMessageLocalUseCase mockSaveGroupMessageLocalUseCase;
  late MockSaveGroupMessageRemoteUseCase mockSaveGroupMessageRemoteUseCase;
  late MockUpdateAllGroupMessagesRemoteUseCase mockUpdateAllGroupMessagesRemoteUseCase;

  setUp(() {
    mockExistGroupMessageLocalUseCase = MockExistGroupMessageLocalUseCase();
    mockGetAllGroupMessagesLocalUseCase = MockGetAllGroupMessagesLocalUseCase();
    mockGetAllGroupMessagesRemoteUseCase = MockGetAllGroupMessagesRemoteUseCase();
    mockGetAllUnsendGroupMessagesLocalUseCase = MockGetAllUnsendGroupMessagesLocalUseCase();
    mockGetGroupMessageLocalUseCase = MockGetGroupMessageLocalUseCase();
    mockGetGroupMessageRemoteUseCase = MockGetGroupMessageRemoteUseCase();
    mockGetMissedGroupMessagesRemoteUseCase = MockGetMissedGroupMessagesRemoteUseCase();
    mockRemoveGroupMessageLocalUseCase = MockRemoveGroupMessageLocalUseCase();
    mockRemoveGroupMessageRemoteUseCase = MockRemoveGroupMessageRemoteUseCase();
    mockSaveGroupMessageLocalUseCase = MockSaveGroupMessageLocalUseCase();
    mockSaveGroupMessageRemoteUseCase = MockSaveGroupMessageRemoteUseCase();
    mockUpdateAllGroupMessagesRemoteUseCase = MockUpdateAllGroupMessagesRemoteUseCase();

    groupMessageBloc = GroupMessageBloc(
      existGroupMessageLocalUseCase: mockExistGroupMessageLocalUseCase,
      getAllGroupMessagesLocalUseCase: mockGetAllGroupMessagesLocalUseCase,
      getAllGroupMessagesRemoteUseCase: mockGetAllGroupMessagesRemoteUseCase,
      getAllUnsendGroupMessagesLocalUseCase: mockGetAllUnsendGroupMessagesLocalUseCase,
      getGroupMessageLocalUseCase: mockGetGroupMessageLocalUseCase,
      getGroupMessageRemoteUseCase: mockGetGroupMessageRemoteUseCase,
      getMissedGroupMessagesRemoteUseCase: mockGetMissedGroupMessagesRemoteUseCase,
      removeGroupMessageLocalUseCase: mockRemoveGroupMessageLocalUseCase,
      removeGroupMessageRemoteUseCase: mockRemoveGroupMessageRemoteUseCase,
      saveGroupMessageLocalUseCase: mockSaveGroupMessageLocalUseCase,
      saveGroupMessageRemoteUseCase: mockSaveGroupMessageRemoteUseCase,
      updateAllGroupMessagesRemoteUseCase: mockUpdateAllGroupMessagesRemoteUseCase,
    );
  });

  final testJson = fixtureReader("group_message_model.json");
  final testGroupMessageModel = GroupMessageModel.fromJson(json.decode(testJson));
  String groupId = testGroupMessageModel.groupId.toString();
  String messageId = testGroupMessageModel.messageId.toString();
  String senderPhoneNumber = testGroupMessageModel.senderPhoneNumber.toString();
  String receiverPhoneNumber = testGroupMessageModel.senderPhoneNumber.toString();


  test("initial state should be InitGroupMessageState", () {
    // assert
    expect(groupMessageBloc.state, const InitGroupMessageState());
  });

  group("existGroupMessageLocalEvent", () {
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ExistGroupMessagesLocalState] when data is gotten successfully',
      build: () {
        when(mockExistGroupMessageLocalUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(ExistGroupMessageLocalEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ExistGroupMessageLocalState(hasExistGroupMessage: true),
      ],
      verify: (bloc) {
        verify(mockExistGroupMessageLocalUseCase.call(ParamsExistGroupMessageLocalUseCase(messageId: messageId)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockExistGroupMessageLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(ExistGroupMessageLocalEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockExistGroupMessageLocalUseCase.call(ParamsExistGroupMessageLocalUseCase(messageId: messageId)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(Exception)] when something went wrong',
      build: () {
        when(mockExistGroupMessageLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(ExistGroupMessageLocalEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockExistGroupMessageLocalUseCase.call(ParamsExistGroupMessageLocalUseCase(messageId: messageId)));
      },
    );
  });

  group("getAllGroupMessagesLocalEvent", () {
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, GetAllGroupMessagesLocalState] when data is gotten successfully',
      build: () {
        when(mockGetAllGroupMessagesLocalUseCase.call(any))
            .thenAnswer((_) async => Right([testGroupMessageModel]));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(GetAllGroupMessagesLocalEvent(groupId)),
      expect: () => [
        const LoadingGroupMessageState(),
        GetAllGroupMessagesLocalState(groupMessageItems: [testGroupMessageModel]),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupMessagesLocalUseCase.call(ParamsGetAllGroupMessagesLocalUseCase(groupId: groupId)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockGetAllGroupMessagesLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(GetAllGroupMessagesLocalEvent(groupId)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupMessagesLocalUseCase.call(ParamsGetAllGroupMessagesLocalUseCase(groupId: groupId)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(Exception)] when something went wrong',
      build: () {
        when(mockGetAllGroupMessagesLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(GetAllGroupMessagesLocalEvent(groupId)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupMessagesLocalUseCase.call(ParamsGetAllGroupMessagesLocalUseCase(groupId: groupId)));
      },
    );
  });

  group("getAllUnsendGroupMessagesLocalEvent", () {
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, GetAllUnsendGroupMessagesLocalState] when data is gotten successfully',
      build: () {
        when(mockGetAllUnsendGroupMessagesLocalUseCase.call(any))
            .thenAnswer((_) async => Right([testGroupMessageModel]));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(GetAllUnsendGroupMessagesLocalEvent(senderPhoneNumber)),
      expect: () => [
        const LoadingGroupMessageState(),
        GetAllUnsendGroupMessagesLocalState(groupMessageItems: [testGroupMessageModel]),
      ],
      verify: (bloc) {
        verify(mockGetAllUnsendGroupMessagesLocalUseCase.call(ParamsGetAllUnsendGroupMessagesLocalUseCase(senderPhoneNumber: senderPhoneNumber)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockGetAllUnsendGroupMessagesLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(GetAllUnsendGroupMessagesLocalEvent(senderPhoneNumber)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetAllUnsendGroupMessagesLocalUseCase.call(ParamsGetAllUnsendGroupMessagesLocalUseCase(senderPhoneNumber: senderPhoneNumber)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(Exception)] when something went wrong',
      build: () {
        when(mockGetAllUnsendGroupMessagesLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(GetAllUnsendGroupMessagesLocalEvent(senderPhoneNumber)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetAllUnsendGroupMessagesLocalUseCase.call(ParamsGetAllUnsendGroupMessagesLocalUseCase(senderPhoneNumber: senderPhoneNumber)));
      },
    );
  });

  group("getGroupMessageLocalEvent", () {
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, GetGroupMessagesLocalState] when data is gotten successfully',
      build: () {
        when(mockGetGroupMessageLocalUseCase.call(any))
            .thenAnswer((_) async => Right(testGroupMessageModel));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(GetGroupMessageLocalEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageState(),
        GetGroupMessageLocalState(groupMessageItem: testGroupMessageModel),
      ],
      verify: (bloc) {
        verify(mockGetGroupMessageLocalUseCase.call(ParamsGetGroupMessageLocalUseCase(messageId: messageId)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockGetGroupMessageLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(GetGroupMessageLocalEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetGroupMessageLocalUseCase.call(ParamsGetGroupMessageLocalUseCase(messageId: messageId)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(Exception)] when something went wrong',
      build: () {
        when(mockGetGroupMessageLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(GetGroupMessageLocalEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetGroupMessageLocalUseCase.call(ParamsGetGroupMessageLocalUseCase(messageId: messageId)));
      },
    );
  });

  group("removeGroupMessageLocalEvent", () {
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, RemoveGroupMessagesLocalState] when data is gotten successfully',
      build: () {
        when(mockRemoveGroupMessageLocalUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(RemoveGroupMessageLocalEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageState(),
        const RemoveGroupMessageLocalState(hasRemoved: true),
      ],
      verify: (bloc) {
        verify(mockRemoveGroupMessageLocalUseCase.call(ParamsRemoveGroupMessageLocalUseCase(messageId: messageId)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockRemoveGroupMessageLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(RemoveGroupMessageLocalEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockRemoveGroupMessageLocalUseCase.call(ParamsRemoveGroupMessageLocalUseCase(messageId: messageId)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(Exception)] when something went wrong',
      build: () {
        when(mockRemoveGroupMessageLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(RemoveGroupMessageLocalEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockRemoveGroupMessageLocalUseCase.call(ParamsRemoveGroupMessageLocalUseCase(messageId: messageId)));
      },
    );
  });

  group("saveGroupMessageLocalEvent", () {
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, SaveGroupMessagesLocalState] when data is gotten successfully',
      build: () {
        when(mockSaveGroupMessageLocalUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(SaveGroupMessageLocalEvent(testGroupMessageModel)),
      expect: () => [
        const LoadingGroupMessageState(),
        const SaveGroupMessageLocalState(hasSaved: true),
      ],
      verify: (bloc) {
        verify(mockSaveGroupMessageLocalUseCase.call(ParamsSaveGroupMessageLocalUseCase(groupMessageItem: testGroupMessageModel)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockSaveGroupMessageLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(SaveGroupMessageLocalEvent(testGroupMessageModel)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockSaveGroupMessageLocalUseCase.call(ParamsSaveGroupMessageLocalUseCase(groupMessageItem: testGroupMessageModel)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(Exception)] when something went wrong',
      build: () {
        when(mockSaveGroupMessageLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(SaveGroupMessageLocalEvent(testGroupMessageModel)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockSaveGroupMessageLocalUseCase.call(ParamsSaveGroupMessageLocalUseCase(groupMessageItem: testGroupMessageModel)));
      },
    );
  });

  group("getAllGroupMessagesRemoteEvent", () {
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, GetAllGroupMessagesRemoteState] when data is gotten successfully',
      build: () {
        when(mockGetAllGroupMessagesRemoteUseCase.call(any))
            .thenAnswer((_) async => Right([testGroupMessageModel]));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(GetAllGroupMessagesRemoteEvent(groupId)),
      expect: () => [
        const LoadingGroupMessageState(),
        GetAllGroupMessagesRemoteState(groupMessageItems: [testGroupMessageModel]),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupMessagesRemoteUseCase.call(ParamsGetAllGroupMessagesRemoteUseCase(groupId: groupId)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockGetAllGroupMessagesRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(GetAllGroupMessagesRemoteEvent(groupId)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupMessagesRemoteUseCase.call(ParamsGetAllGroupMessagesRemoteUseCase(groupId: groupId)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockGetAllGroupMessagesRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(GetAllGroupMessagesRemoteEvent(groupId)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupMessagesRemoteUseCase.call(ParamsGetAllGroupMessagesRemoteUseCase(groupId: groupId)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(Exception)] when something went wrong',
      build: () {
        when(mockGetAllGroupMessagesRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(GetAllGroupMessagesRemoteEvent(groupId)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupMessagesRemoteUseCase.call(ParamsGetAllGroupMessagesRemoteUseCase(groupId: groupId)));
      },
    );
  });

  group("getGroupMessageRemoteEvent", () {
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, GetGroupMessagesRemoteState] when data is gotten successfully',
      build: () {
        when(mockGetGroupMessageRemoteUseCase.call(any))
            .thenAnswer((_) async => Right(testGroupMessageModel));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(GetGroupMessageRemoteEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageState(),
        GetGroupMessageRemoteState(groupMessageItem: testGroupMessageModel),
      ],
      verify: (bloc) {
        verify(mockGetGroupMessageRemoteUseCase.call(ParamsGetGroupMessageRemoteUseCase(messageId: messageId)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockGetGroupMessageRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(GetGroupMessageRemoteEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetGroupMessageRemoteUseCase.call(ParamsGetGroupMessageRemoteUseCase(messageId: messageId)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockGetGroupMessageRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(GetGroupMessageRemoteEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetGroupMessageRemoteUseCase.call(ParamsGetGroupMessageRemoteUseCase(messageId: messageId)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(Exception)] when something went wrong',
      build: () {
        when(mockGetGroupMessageRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(GetGroupMessageRemoteEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetGroupMessageRemoteUseCase.call(ParamsGetGroupMessageRemoteUseCase(messageId: messageId)));
      },
    );
  });

  group("getMissedGroupMessagesRemoteEvent", () {
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, GetMissedGroupMessagesRemoteState] when data is gotten successfully',
      build: () {
        when(mockGetMissedGroupMessagesRemoteUseCase.call(any))
            .thenAnswer((_) async => Right([testGroupMessageModel]));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(GetMissedGroupMessagesRemoteEvent(groupId, receiverPhoneNumber)),
      expect: () => [
        const LoadingGroupMessageState(),
        GetMissedGroupMessagesRemoteState(groupMessageItems: [testGroupMessageModel]),
      ],
      verify: (bloc) {
        verify(mockGetMissedGroupMessagesRemoteUseCase.call(ParamsGetMissedGroupMessagesRemoteUseCase(groupId: groupId, receiverPhoneNumber: receiverPhoneNumber)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockGetMissedGroupMessagesRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(GetMissedGroupMessagesRemoteEvent(groupId, receiverPhoneNumber)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetMissedGroupMessagesRemoteUseCase.call(ParamsGetMissedGroupMessagesRemoteUseCase(groupId: groupId, receiverPhoneNumber: receiverPhoneNumber)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockGetMissedGroupMessagesRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(GetMissedGroupMessagesRemoteEvent(groupId, receiverPhoneNumber)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetMissedGroupMessagesRemoteUseCase.call(ParamsGetMissedGroupMessagesRemoteUseCase(groupId: groupId, receiverPhoneNumber: receiverPhoneNumber)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(Exception)] when something went wrong',
      build: () {
        when(mockGetMissedGroupMessagesRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(GetMissedGroupMessagesRemoteEvent(groupId, receiverPhoneNumber)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetMissedGroupMessagesRemoteUseCase.call(ParamsGetMissedGroupMessagesRemoteUseCase(groupId: groupId, receiverPhoneNumber: receiverPhoneNumber)));
      },
    );
  });

  group("removeGroupMessageRemoteEvent", () {
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, RemoveGroupMessagesRemoteState] when data is gotten successfully',
      build: () {
        when(mockRemoveGroupMessageRemoteUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(RemoveGroupMessageRemoteEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageState(),
        const RemoveGroupMessageRemoteState(hasRemoved: true),
      ],
      verify: (bloc) {
        verify(mockRemoveGroupMessageRemoteUseCase.call(ParamsRemoveGroupMessageRemoteUseCase(messageId: messageId)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockRemoveGroupMessageRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(RemoveGroupMessageRemoteEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockRemoveGroupMessageRemoteUseCase.call(ParamsRemoveGroupMessageRemoteUseCase(messageId: messageId)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockRemoveGroupMessageRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(RemoveGroupMessageRemoteEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockRemoveGroupMessageRemoteUseCase.call(ParamsRemoveGroupMessageRemoteUseCase(messageId: messageId)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(Exception)] when something went wrong',
      build: () {
        when(mockRemoveGroupMessageRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(RemoveGroupMessageRemoteEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockRemoveGroupMessageRemoteUseCase.call(ParamsRemoveGroupMessageRemoteUseCase(messageId: messageId)));
      },
    );
  });

  group("saveGroupMessageRemoteEvent", () {
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, SaveGroupMessagesRemoteState] when data is gotten successfully',
      build: () {
        when(mockSaveGroupMessageRemoteUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(SaveGroupMessageRemoteEvent(testGroupMessageModel)),
      expect: () => [
        const LoadingGroupMessageState(),
        const SaveGroupMessageRemoteState(hasSaved: true),
      ],
      verify: (bloc) {
        verify(mockSaveGroupMessageRemoteUseCase.call(ParamsSaveGroupMessageRemoteUseCase(groupMessageItem: testGroupMessageModel)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockSaveGroupMessageRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(SaveGroupMessageRemoteEvent(testGroupMessageModel)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockSaveGroupMessageRemoteUseCase.call(ParamsSaveGroupMessageRemoteUseCase(groupMessageItem: testGroupMessageModel)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockSaveGroupMessageRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(SaveGroupMessageRemoteEvent(testGroupMessageModel)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockSaveGroupMessageRemoteUseCase.call(ParamsSaveGroupMessageRemoteUseCase(groupMessageItem: testGroupMessageModel)));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(Exception)] when something went wrong',
      build: () {
        when(mockSaveGroupMessageRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(SaveGroupMessageRemoteEvent(testGroupMessageModel)),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockSaveGroupMessageRemoteUseCase.call(ParamsSaveGroupMessageRemoteUseCase(groupMessageItem: testGroupMessageModel)));
      },
    );
  });

  group("updateAllGroupMessagesRemoteEvent", () {
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, UpdateAllGroupMessagesRemoteState] when data is gotten successfully',
      build: () {
        when(mockUpdateAllGroupMessagesRemoteUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(UpdateAllGroupMessagesRemoteEvent([testGroupMessageModel])),
      expect: () => [
        const LoadingGroupMessageState(),
        const UpdateAllGroupMessagesRemoteState(hasUpdate: true),
      ],
      verify: (bloc) {
        verify(mockUpdateAllGroupMessagesRemoteUseCase.call(ParamsUpdateAllGroupMessagesRemoteUseCase(groupMessageItems: [testGroupMessageModel])));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockUpdateAllGroupMessagesRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(UpdateAllGroupMessagesRemoteEvent([testGroupMessageModel])),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockUpdateAllGroupMessagesRemoteUseCase.call(ParamsUpdateAllGroupMessagesRemoteUseCase(groupMessageItems: [testGroupMessageModel])));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockUpdateAllGroupMessagesRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(UpdateAllGroupMessagesRemoteEvent([testGroupMessageModel])),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockUpdateAllGroupMessagesRemoteUseCase.call(ParamsUpdateAllGroupMessagesRemoteUseCase(groupMessageItems: [testGroupMessageModel])));
      },
    );
    blocTest<GroupMessageBloc, GroupMessageState>(
      'Should emit [LoadingGroupMessageState, ErrorGroupMessageState(Exception)] when something went wrong',
      build: () {
        when(mockUpdateAllGroupMessagesRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupMessageBloc;
      },
      act: (bloc) => bloc.add(UpdateAllGroupMessagesRemoteEvent([testGroupMessageModel])),
      expect: () => [
        const LoadingGroupMessageState(),
        const ErrorGroupMessageState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockUpdateAllGroupMessagesRemoteUseCase.call(ParamsUpdateAllGroupMessagesRemoteUseCase(groupMessageItems: [testGroupMessageModel])));
      },
    );
  });

}