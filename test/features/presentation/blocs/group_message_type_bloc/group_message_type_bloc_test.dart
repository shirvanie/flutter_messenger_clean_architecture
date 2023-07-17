



import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/features/data/models/group_message_type_model.dart';
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
import 'package:messenger/features/presentation/blocs/group_message_type_bloc/group_message_type_bloc.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GroupMessageTypeBloc groupMessageTypeBloc;
  late MockExistGroupMessageTypeLocalUseCase mockExistGroupMessageTypeLocalUseCase;
  late MockGetAllGroupMessageTypesLocalUseCase mockGetAllGroupMessageTypesLocalUseCase;
  late MockGetAllGroupMessageTypesRemoteUseCase mockGetAllGroupMessageTypesRemoteUseCase;
  late MockGetAllNotReadGroupMessageTypesLocalUseCase mockGetAllNotReadGroupMessageTypesLocalUseCase;
  late MockGetAllUnsendGroupMessageTypesLocalUseCase mockGetAllUnsendGroupMessageTypesLocalUseCase;
  late MockGetGroupMessageTypeLocalUseCase mockGetGroupMessageTypeLocalUseCase;
  late MockGetGroupMessageTypeRemoteUseCase mockGetGroupMessageTypeRemoteUseCase;
  late MockRemoveGroupMessageTypeLocalUseCase mockRemoveGroupMessageTypeLocalUseCase;
  late MockRemoveGroupMessageTypeRemoteUseCase mockRemoveGroupMessageTypeRemoteUseCase;
  late MockSaveGroupMessageTypeLocalUseCase mockSaveGroupMessageTypeLocalUseCase;
  late MockSaveGroupMessageTypeRemoteUseCase mockSaveGroupMessageTypeRemoteUseCase;
  late MockUpdateAllGroupMessageTypesRemoteUseCase mockUpdateAllGroupMessageTypesRemoteUseCase;

  setUp(() {
    mockExistGroupMessageTypeLocalUseCase = MockExistGroupMessageTypeLocalUseCase();
    mockGetAllGroupMessageTypesLocalUseCase = MockGetAllGroupMessageTypesLocalUseCase();
    mockGetAllGroupMessageTypesRemoteUseCase = MockGetAllGroupMessageTypesRemoteUseCase();
    mockGetAllNotReadGroupMessageTypesLocalUseCase = MockGetAllNotReadGroupMessageTypesLocalUseCase();
    mockGetAllUnsendGroupMessageTypesLocalUseCase = MockGetAllUnsendGroupMessageTypesLocalUseCase();
    mockGetGroupMessageTypeLocalUseCase = MockGetGroupMessageTypeLocalUseCase();
    mockGetGroupMessageTypeRemoteUseCase = MockGetGroupMessageTypeRemoteUseCase();
    mockRemoveGroupMessageTypeLocalUseCase = MockRemoveGroupMessageTypeLocalUseCase();
    mockRemoveGroupMessageTypeRemoteUseCase = MockRemoveGroupMessageTypeRemoteUseCase();
    mockSaveGroupMessageTypeLocalUseCase = MockSaveGroupMessageTypeLocalUseCase();
    mockSaveGroupMessageTypeRemoteUseCase = MockSaveGroupMessageTypeRemoteUseCase();
    mockUpdateAllGroupMessageTypesRemoteUseCase = MockUpdateAllGroupMessageTypesRemoteUseCase();

    groupMessageTypeBloc = GroupMessageTypeBloc(
      existGroupMessageTypeLocalUseCase: mockExistGroupMessageTypeLocalUseCase,
      getAllGroupMessageTypesLocalUseCase: mockGetAllGroupMessageTypesLocalUseCase,
      getAllGroupMessageTypesRemoteUseCase: mockGetAllGroupMessageTypesRemoteUseCase,
      getAllNotReadGroupMessageTypesLocalUseCase: mockGetAllNotReadGroupMessageTypesLocalUseCase,
      getAllUnsendGroupMessageTypesLocalUseCase: mockGetAllUnsendGroupMessageTypesLocalUseCase,
      getGroupMessageTypeLocalUseCase: mockGetGroupMessageTypeLocalUseCase,
      getGroupMessageTypeRemoteUseCase: mockGetGroupMessageTypeRemoteUseCase,
      removeGroupMessageTypeLocalUseCase: mockRemoveGroupMessageTypeLocalUseCase,
      removeGroupMessageTypeRemoteUseCase: mockRemoveGroupMessageTypeRemoteUseCase,
      saveGroupMessageTypeLocalUseCase: mockSaveGroupMessageTypeLocalUseCase,
      saveGroupMessageTypeRemoteUseCase: mockSaveGroupMessageTypeRemoteUseCase,
      updateAllGroupMessageTypesRemoteUseCase: mockUpdateAllGroupMessageTypesRemoteUseCase,
    );
  });

  final testJson = fixtureReader("group_message_type_model.json");
  final testGroupMessageTypeModel = GroupMessageTypeModel.fromJson(json.decode(testJson));
  String groupId = testGroupMessageTypeModel.groupId.toString();
  String messageId = testGroupMessageTypeModel.messageId.toString();
  String receiverPhoneNumber = testGroupMessageTypeModel.receiverPhoneNumber.toString();


  test("initial state should be InitGroupMessageTypeState", () {
    // assert
    expect(groupMessageTypeBloc.state, const InitGroupMessageTypeState());
  });


  group("existGroupMessageTypeLocalEvent", () {
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ExistGroupMessageTypesLocalState] when data is gotten successfully',
      build: () {
        when(mockExistGroupMessageTypeLocalUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(ExistGroupMessageTypeLocalEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ExistGroupMessageTypeLocalState(hasExistGroupMessageType: true),
      ],
      verify: (bloc) {
        verify(mockExistGroupMessageTypeLocalUseCase.call(ParamsExistGroupMessageTypeLocalUseCase(messageId: messageId)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockExistGroupMessageTypeLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(ExistGroupMessageTypeLocalEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockExistGroupMessageTypeLocalUseCase.call(ParamsExistGroupMessageTypeLocalUseCase(messageId: messageId)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(Exception)] when something went wrong',
      build: () {
        when(mockExistGroupMessageTypeLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(ExistGroupMessageTypeLocalEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockExistGroupMessageTypeLocalUseCase.call(ParamsExistGroupMessageTypeLocalUseCase(messageId: messageId)));
      },
    );
  });

  group("getAllGroupMessageTypesLocalEvent", () {
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, GetAllGroupMessageTypesLocalState] when data is gotten successfully',
      build: () {
        when(mockGetAllGroupMessageTypesLocalUseCase.call(any))
            .thenAnswer((_) async => Right([testGroupMessageTypeModel]));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(GetAllGroupMessageTypesLocalEvent(groupId, messageId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        GetAllGroupMessageTypesLocalState(groupMessageTypeItems: [testGroupMessageTypeModel]),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupMessageTypesLocalUseCase.call(ParamsGetAllGroupMessageTypesLocalUseCase(groupId: groupId, messageId: messageId)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockGetAllGroupMessageTypesLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(GetAllGroupMessageTypesLocalEvent(groupId, messageId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupMessageTypesLocalUseCase.call(ParamsGetAllGroupMessageTypesLocalUseCase(groupId: groupId, messageId: messageId)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(Exception)] when something went wrong',
      build: () {
        when(mockGetAllGroupMessageTypesLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(GetAllGroupMessageTypesLocalEvent(groupId, messageId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupMessageTypesLocalUseCase.call(ParamsGetAllGroupMessageTypesLocalUseCase(groupId: groupId, messageId: messageId)));
      },
    );
  });

  group("getAllNotReadGroupMessageTypesLocalEvent", () {
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, GetNotReadGroupMessageTypesRemoteState] when data is gotten successfully',
      build: () {
        when(mockGetAllNotReadGroupMessageTypesLocalUseCase.call(any))
            .thenAnswer((_) async => Right([testGroupMessageTypeModel]));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(GetAllNotReadGroupMessageTypesLocalEvent(groupId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        GetAllNotReadGroupMessageTypesLocalState(groupMessageTypeItems: [testGroupMessageTypeModel]),
      ],
      verify: (bloc) {
        verify(mockGetAllNotReadGroupMessageTypesLocalUseCase.call(ParamsGetAllNotReadGroupMessageTypesLocalUseCase(groupId: groupId)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockGetAllNotReadGroupMessageTypesLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(GetAllNotReadGroupMessageTypesLocalEvent(groupId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetAllNotReadGroupMessageTypesLocalUseCase.call(ParamsGetAllNotReadGroupMessageTypesLocalUseCase(groupId: groupId)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(Exception)] when something went wrong',
      build: () {
        when(mockGetAllNotReadGroupMessageTypesLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(GetAllNotReadGroupMessageTypesLocalEvent(groupId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetAllNotReadGroupMessageTypesLocalUseCase.call(ParamsGetAllNotReadGroupMessageTypesLocalUseCase(groupId: groupId)));
      },
    );
  });

  group("getAllUnsendGroupMessageTypesLocalEvent", () {
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, GetAllUnsendGroupMessageTypesLocalState] when data is gotten successfully',
      build: () {
        when(mockGetAllUnsendGroupMessageTypesLocalUseCase.call(any))
            .thenAnswer((_) async => Right([testGroupMessageTypeModel]));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(GetAllUnsendGroupMessageTypesLocalEvent(receiverPhoneNumber)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        GetAllUnsendGroupMessageTypesLocalState(groupMessageTypeItems: [testGroupMessageTypeModel]),
      ],
      verify: (bloc) {
        verify(mockGetAllUnsendGroupMessageTypesLocalUseCase.call(ParamsGetAllUnsendGroupMessageTypesLocalUseCase(receiverPhoneNumber: receiverPhoneNumber)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockGetAllUnsendGroupMessageTypesLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(GetAllUnsendGroupMessageTypesLocalEvent(receiverPhoneNumber)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetAllUnsendGroupMessageTypesLocalUseCase.call(ParamsGetAllUnsendGroupMessageTypesLocalUseCase(receiverPhoneNumber: receiverPhoneNumber)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(Exception)] when something went wrong',
      build: () {
        when(mockGetAllUnsendGroupMessageTypesLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(GetAllUnsendGroupMessageTypesLocalEvent(receiverPhoneNumber)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetAllUnsendGroupMessageTypesLocalUseCase.call(ParamsGetAllUnsendGroupMessageTypesLocalUseCase(receiverPhoneNumber: receiverPhoneNumber)));
      },
    );
  });

  group("getGroupMessageTypeLocalEvent", () {
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, GetGroupMessageTypesLocalState] when data is gotten successfully',
      build: () {
        when(mockGetGroupMessageTypeLocalUseCase.call(any))
            .thenAnswer((_) async => Right(testGroupMessageTypeModel));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(GetGroupMessageTypeLocalEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        GetGroupMessageTypeLocalState(groupMessageTypeItem: testGroupMessageTypeModel),
      ],
      verify: (bloc) {
        verify(mockGetGroupMessageTypeLocalUseCase.call(ParamsGetGroupMessageTypeLocalUseCase(messageId: messageId)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockGetGroupMessageTypeLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(GetGroupMessageTypeLocalEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetGroupMessageTypeLocalUseCase.call(ParamsGetGroupMessageTypeLocalUseCase(messageId: messageId)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(Exception)] when something went wrong',
      build: () {
        when(mockGetGroupMessageTypeLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(GetGroupMessageTypeLocalEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetGroupMessageTypeLocalUseCase.call(ParamsGetGroupMessageTypeLocalUseCase(messageId: messageId)));
      },
    );
  });

  group("removeGroupMessageTypeLocalEvent", () {
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, RemoveGroupMessageTypesLocalState] when data is gotten successfully',
      build: () {
        when(mockRemoveGroupMessageTypeLocalUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(RemoveGroupMessageTypeLocalEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const RemoveGroupMessageTypeLocalState(hasRemoved: true),
      ],
      verify: (bloc) {
        verify(mockRemoveGroupMessageTypeLocalUseCase.call(ParamsRemoveGroupMessageTypeLocalUseCase(messageId: messageId)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockRemoveGroupMessageTypeLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(RemoveGroupMessageTypeLocalEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockRemoveGroupMessageTypeLocalUseCase.call(ParamsRemoveGroupMessageTypeLocalUseCase(messageId: messageId)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(Exception)] when something went wrong',
      build: () {
        when(mockRemoveGroupMessageTypeLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(RemoveGroupMessageTypeLocalEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockRemoveGroupMessageTypeLocalUseCase.call(ParamsRemoveGroupMessageTypeLocalUseCase(messageId: messageId)));
      },
    );
  });

  group("saveGroupMessageTypeLocalEvent", () {
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, SaveGroupMessageTypesLocalState] when data is gotten successfully',
      build: () {
        when(mockSaveGroupMessageTypeLocalUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(SaveGroupMessageTypeLocalEvent(testGroupMessageTypeModel)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const SaveGroupMessageTypeLocalState(hasSaved: true),
      ],
      verify: (bloc) {
        verify(mockSaveGroupMessageTypeLocalUseCase.call(ParamsSaveGroupMessageTypeLocalUseCase(groupMessageTypeItem: testGroupMessageTypeModel)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockSaveGroupMessageTypeLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(SaveGroupMessageTypeLocalEvent(testGroupMessageTypeModel)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockSaveGroupMessageTypeLocalUseCase.call(ParamsSaveGroupMessageTypeLocalUseCase(groupMessageTypeItem: testGroupMessageTypeModel)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(Exception)] when something went wrong',
      build: () {
        when(mockSaveGroupMessageTypeLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(SaveGroupMessageTypeLocalEvent(testGroupMessageTypeModel)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockSaveGroupMessageTypeLocalUseCase.call(ParamsSaveGroupMessageTypeLocalUseCase(groupMessageTypeItem: testGroupMessageTypeModel)));
      },
    );
  });

  group("getAllGroupMessageTypesRemoteEvent", () {
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, GetAllGroupMessageTypesRemoteState] when data is gotten successfully',
      build: () {
        when(mockGetAllGroupMessageTypesRemoteUseCase.call(any))
            .thenAnswer((_) async => Right([testGroupMessageTypeModel]));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(GetAllGroupMessageTypesRemoteEvent(groupId, messageId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        GetAllGroupMessageTypesRemoteState(groupMessageTypeItems: [testGroupMessageTypeModel]),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupMessageTypesRemoteUseCase.call(ParamsGetAllGroupMessageTypesRemoteUseCase(groupId: groupId, messageId: messageId)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockGetAllGroupMessageTypesRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(GetAllGroupMessageTypesRemoteEvent(groupId, messageId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupMessageTypesRemoteUseCase.call(ParamsGetAllGroupMessageTypesRemoteUseCase(groupId: groupId, messageId: messageId)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockGetAllGroupMessageTypesRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(GetAllGroupMessageTypesRemoteEvent(groupId, messageId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupMessageTypesRemoteUseCase.call(ParamsGetAllGroupMessageTypesRemoteUseCase(groupId: groupId, messageId: messageId)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeGroupMessageTypeState, ErrorGroupMessageTypeState(Exception)] when something went wrong',
      build: () {
        when(mockGetAllGroupMessageTypesRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(GetAllGroupMessageTypesRemoteEvent(groupId, messageId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupMessageTypesRemoteUseCase.call(ParamsGetAllGroupMessageTypesRemoteUseCase(groupId: groupId, messageId: messageId)));
      },
    );
  });

  group("getGroupMessageTypeGroupMessageTypeRemoteEvent", () {
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, GetGroupMessageTypesRemoteState] when data is gotten successfully',
      build: () {
        when(mockGetGroupMessageTypeRemoteUseCase.call(any))
            .thenAnswer((_) async => Right(testGroupMessageTypeModel));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(GetGroupMessageTypeRemoteEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        GetGroupMessageTypeRemoteState(groupMessageTypeItem: testGroupMessageTypeModel),
      ],
      verify: (bloc) {
        verify(mockGetGroupMessageTypeRemoteUseCase.call(ParamsGetGroupMessageTypeRemoteUseCase(messageId: messageId)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockGetGroupMessageTypeRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(GetGroupMessageTypeRemoteEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetGroupMessageTypeRemoteUseCase.call(ParamsGetGroupMessageTypeRemoteUseCase(messageId: messageId)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockGetGroupMessageTypeRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(GetGroupMessageTypeRemoteEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetGroupMessageTypeRemoteUseCase.call(ParamsGetGroupMessageTypeRemoteUseCase(messageId: messageId)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(Exception)] when something went wrong',
      build: () {
        when(mockGetGroupMessageTypeRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(GetGroupMessageTypeRemoteEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetGroupMessageTypeRemoteUseCase.call(ParamsGetGroupMessageTypeRemoteUseCase(messageId: messageId)));
      },
    );
  });

  group("removeGroupMessageTypeRemoteEvent", () {
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, RemoveGroupMessageTypesRemoteState] when data is gotten successfully',
      build: () {
        when(mockRemoveGroupMessageTypeRemoteUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(RemoveGroupMessageTypeRemoteEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const RemoveGroupMessageTypeRemoteState(hasRemoved: true),
      ],
      verify: (bloc) {
        verify(mockRemoveGroupMessageTypeRemoteUseCase.call(ParamsRemoveGroupMessageTypeRemoteUseCase(messageId: messageId)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockRemoveGroupMessageTypeRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(RemoveGroupMessageTypeRemoteEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockRemoveGroupMessageTypeRemoteUseCase.call(ParamsRemoveGroupMessageTypeRemoteUseCase(messageId: messageId)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockRemoveGroupMessageTypeRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(RemoveGroupMessageTypeRemoteEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockRemoveGroupMessageTypeRemoteUseCase.call(ParamsRemoveGroupMessageTypeRemoteUseCase(messageId: messageId)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(Exception)] when something went wrong',
      build: () {
        when(mockRemoveGroupMessageTypeRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(RemoveGroupMessageTypeRemoteEvent(messageId)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockRemoveGroupMessageTypeRemoteUseCase.call(ParamsRemoveGroupMessageTypeRemoteUseCase(messageId: messageId)));
      },
    );
  });

  group("saveGroupMessageTypeRemoteEvent", () {
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, SaveGroupMessageTypesRemoteState] when data is gotten successfully',
      build: () {
        when(mockSaveGroupMessageTypeRemoteUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(SaveGroupMessageTypeRemoteEvent(testGroupMessageTypeModel)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const SaveGroupMessageTypeRemoteState(hasSaved: true),
      ],
      verify: (bloc) {
        verify(mockSaveGroupMessageTypeRemoteUseCase.call(ParamsSaveGroupMessageTypeRemoteUseCase(groupMessageTypeItem: testGroupMessageTypeModel)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockSaveGroupMessageTypeRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(SaveGroupMessageTypeRemoteEvent(testGroupMessageTypeModel)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockSaveGroupMessageTypeRemoteUseCase.call(ParamsSaveGroupMessageTypeRemoteUseCase(groupMessageTypeItem: testGroupMessageTypeModel)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockSaveGroupMessageTypeRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(SaveGroupMessageTypeRemoteEvent(testGroupMessageTypeModel)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockSaveGroupMessageTypeRemoteUseCase.call(ParamsSaveGroupMessageTypeRemoteUseCase(groupMessageTypeItem: testGroupMessageTypeModel)));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(Exception)] when something went wrong',
      build: () {
        when(mockSaveGroupMessageTypeRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(SaveGroupMessageTypeRemoteEvent(testGroupMessageTypeModel)),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockSaveGroupMessageTypeRemoteUseCase.call(ParamsSaveGroupMessageTypeRemoteUseCase(groupMessageTypeItem: testGroupMessageTypeModel)));
      },
    );
  });

  group("updateAllGroupMessageTypesRemoteEvent", () {
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, UpdateAllGroupMessageTypesRemoteState] when data is gotten successfully',
      build: () {
        when(mockUpdateAllGroupMessageTypesRemoteUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(UpdateAllGroupMessageTypesRemoteEvent([testGroupMessageTypeModel])),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const UpdateAllGroupMessageTypesRemoteState(hasUpdate: true),
      ],
      verify: (bloc) {
        verify(mockUpdateAllGroupMessageTypesRemoteUseCase.call(ParamsUpdateAllGroupMessageTypesRemoteUseCase(groupMessageTypeItems: [testGroupMessageTypeModel])));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockUpdateAllGroupMessageTypesRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(UpdateAllGroupMessageTypesRemoteEvent([testGroupMessageTypeModel])),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockUpdateAllGroupMessageTypesRemoteUseCase.call(ParamsUpdateAllGroupMessageTypesRemoteUseCase(groupMessageTypeItems: [testGroupMessageTypeModel])));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockUpdateAllGroupMessageTypesRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(UpdateAllGroupMessageTypesRemoteEvent([testGroupMessageTypeModel])),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockUpdateAllGroupMessageTypesRemoteUseCase.call(ParamsUpdateAllGroupMessageTypesRemoteUseCase(groupMessageTypeItems: [testGroupMessageTypeModel])));
      },
    );
    blocTest<GroupMessageTypeBloc, GroupMessageTypeState>(
      'Should emit [LoadingGroupMessageTypeState, ErrorGroupMessageTypeState(Exception)] when something went wrong',
      build: () {
        when(mockUpdateAllGroupMessageTypesRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupMessageTypeBloc;
      },
      act: (bloc) => bloc.add(UpdateAllGroupMessageTypesRemoteEvent([testGroupMessageTypeModel])),
      expect: () => [
        const LoadingGroupMessageTypeState(),
        const ErrorGroupMessageTypeState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockUpdateAllGroupMessageTypesRemoteUseCase.call(ParamsUpdateAllGroupMessageTypesRemoteUseCase(groupMessageTypeItems: [testGroupMessageTypeModel])));
      },
    );
  });


}