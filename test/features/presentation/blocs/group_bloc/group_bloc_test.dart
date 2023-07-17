



import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/usecase/usecase.dart';
import 'package:messenger/features/data/models/group_model.dart';
import 'package:messenger/features/domain/usecases/group_usecases/get_group_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_usecases/get_group_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_usecases/remove_group_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_usecases/save_group_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_usecases/save_group_remote_usecase.dart';
import 'package:messenger/features/presentation/blocs/group_bloc/group_bloc.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GroupBloc groupBloc;
  late MockGetAllGroupsLocalUseCase mockGetAllGroupsLocalUseCase;
  late MockGetAllGroupsRemoteUseCase mockGetAllGroupsRemoteUseCase;
  late MockGetGroupLocalUseCase mockGetGroupLocalUseCase;
  late MockGetGroupRemoteUseCase mockGetGroupRemoteUseCase;
  late MockRemoveGroupLocalUseCase mockRemoveGroupLocalUseCase;
  late MockSaveGroupLocalUseCase mockSaveGroupLocalUseCase;
  late MockSaveGroupRemoteUseCase mockSaveGroupRemoteUseCase;

  setUp(() {
    mockGetAllGroupsLocalUseCase = MockGetAllGroupsLocalUseCase();
    mockGetAllGroupsRemoteUseCase = MockGetAllGroupsRemoteUseCase();
    mockGetGroupLocalUseCase = MockGetGroupLocalUseCase();
    mockGetGroupRemoteUseCase = MockGetGroupRemoteUseCase();
    mockRemoveGroupLocalUseCase = MockRemoveGroupLocalUseCase();
    mockSaveGroupLocalUseCase = MockSaveGroupLocalUseCase();
    mockSaveGroupRemoteUseCase = MockSaveGroupRemoteUseCase();

    groupBloc = GroupBloc(
      getAllGroupsLocalUseCase: mockGetAllGroupsLocalUseCase,
      getAllGroupsRemoteUseCase: mockGetAllGroupsRemoteUseCase,
      getGroupLocalUseCase: mockGetGroupLocalUseCase,
      getGroupRemoteUseCase: mockGetGroupRemoteUseCase,
      removeGroupLocalUseCase: mockRemoveGroupLocalUseCase,
      saveGroupLocalUseCase: mockSaveGroupLocalUseCase,
      saveGroupRemoteUseCase: mockSaveGroupRemoteUseCase,
    );
  });

  final testJson = fixtureReader("group_model.json");
  final testGroupModel = GroupModel.fromJson(json.decode(testJson));
  String groupId = testGroupModel.groupId.toString();


  test("initial state should be InitGroupState", () {
    // assert
    expect(groupBloc.state, const InitGroupState());
  });

  group("getAllGroupsLocalEvent", () {
    blocTest<GroupBloc, GroupState>(
      'Should emit [LoadingGroupState, GetAllGroupsLocalState] when data is gotten successfully',
      build: () {
        when(mockGetAllGroupsLocalUseCase.call(any))
            .thenAnswer((_) async => Right([testGroupModel]));
        return groupBloc;
      },
      act: (bloc) => bloc.add(const GetAllGroupsLocalEvent()),
      expect: () => [
        const LoadingGroupState(),
        GetAllGroupsLocalState(groupItems: [testGroupModel]),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupsLocalUseCase.call(NoParams()));
      },
    );
    blocTest<GroupBloc, GroupState>(
      'Should emit [LoadingGroupState, ErrorGroupState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockGetAllGroupsLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return groupBloc;
      },
      act: (bloc) => bloc.add(const GetAllGroupsLocalEvent()),
      expect: () => [
        const LoadingGroupState(),
        const ErrorGroupState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupsLocalUseCase.call(NoParams()));
      },
    );
    blocTest<GroupBloc, GroupState>(
      'Should emit [LoadingGroupState, ErrorGroupState(Exception)] when something went wrong',
      build: () {
        when(mockGetAllGroupsLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupBloc;
      },
      act: (bloc) => bloc.add(const GetAllGroupsLocalEvent()),
      expect: () => [
        const LoadingGroupState(),
        const ErrorGroupState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupsLocalUseCase.call(NoParams()));
      },
    );
  });

  group("getGroupLocalEvent", () {
    blocTest<GroupBloc, GroupState>(
      'Should emit [LoadingGroupState, GetGroupLocalState] when data is gotten successfully',
      build: () {
        when(mockGetGroupLocalUseCase.call(any))
            .thenAnswer((_) async => Right(testGroupModel));
        return groupBloc;
      },
      act: (bloc) => bloc.add(GetGroupLocalEvent(groupId)),
      expect: () => [
        const LoadingGroupState(),
        GetGroupLocalState(groupItem: testGroupModel),
      ],
      verify: (bloc) {
        verify(mockGetGroupLocalUseCase.call(ParamsGetGroupLocalUseCase(groupId: groupId)));
      },
    );
    blocTest<GroupBloc, GroupState>(
      'Should emit [LoadingGroupState, ErrorGroupState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockGetGroupLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return groupBloc;
      },
      act: (bloc) => bloc.add(GetGroupLocalEvent(groupId)),
      expect: () => [
        const LoadingGroupState(),
        const ErrorGroupState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetGroupLocalUseCase.call(ParamsGetGroupLocalUseCase(groupId: groupId)));
      },
    );
    blocTest<GroupBloc, GroupState>(
      'Should emit [LoadingGroupState, ErrorGroupState(Exception)] when something went wrong',
      build: () {
        when(mockGetGroupLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupBloc;
      },
      act: (bloc) => bloc.add(GetGroupLocalEvent(groupId)),
      expect: () => [
        const LoadingGroupState(),
        const ErrorGroupState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetGroupLocalUseCase.call(ParamsGetGroupLocalUseCase(groupId: groupId)));
      },
    );
  });

  group("removeGroupLocalEvent", () {
    blocTest<GroupBloc, GroupState>(
      'Should emit [LoadingGroupState, RemoveGroupLocalState] when data is gotten successfully',
      build: () {
        when(mockRemoveGroupLocalUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return groupBloc;
      },
      act: (bloc) => bloc.add(RemoveGroupLocalEvent(groupId)),
      expect: () => [
        const LoadingGroupState(),
        const RemoveGroupLocalState(hasRemoved: true),
      ],
      verify: (bloc) {
        verify(mockRemoveGroupLocalUseCase.call(ParamsRemoveGroupLocalUseCase(groupId: groupId)));
      },
    );
    blocTest<GroupBloc, GroupState>(
      'Should emit [LoadingGroupState, ErrorGroupState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockRemoveGroupLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return groupBloc;
      },
      act: (bloc) => bloc.add(RemoveGroupLocalEvent(groupId)),
      expect: () => [
        const LoadingGroupState(),
        const ErrorGroupState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockRemoveGroupLocalUseCase.call(ParamsRemoveGroupLocalUseCase(groupId: groupId)));
      },
    );
    blocTest<GroupBloc, GroupState>(
      'Should emit [LoadingGroupState, ErrorGroupState(Exception)] when something went wrong',
      build: () {
        when(mockRemoveGroupLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupBloc;
      },
      act: (bloc) => bloc.add(RemoveGroupLocalEvent(groupId)),
      expect: () => [
        const LoadingGroupState(),
        const ErrorGroupState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockRemoveGroupLocalUseCase.call(ParamsRemoveGroupLocalUseCase(groupId: groupId)));
      },
    );
  });

  group("saveGroupLocalEvent", () {
    blocTest<GroupBloc, GroupState>(
      'Should emit [LoadingGroupState, SaveGroupLocalState] when data is gotten successfully',
      build: () {
        when(mockSaveGroupLocalUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return groupBloc;
      },
      act: (bloc) => bloc.add(SaveGroupLocalEvent(testGroupModel)),
      expect: () => [
        const LoadingGroupState(),
        const SaveGroupLocalState(hasSaved: true),
      ],
      verify: (bloc) {
        verify(mockSaveGroupLocalUseCase.call(ParamsSaveGroupLocalUseCase(groupItem: testGroupModel)));
      },
    );
    blocTest<GroupBloc, GroupState>(
      'Should emit [LoadingGroupState, ErrorGroupState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockSaveGroupLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return groupBloc;
      },
      act: (bloc) => bloc.add(SaveGroupLocalEvent(testGroupModel)),
      expect: () => [
        const LoadingGroupState(),
        const ErrorGroupState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockSaveGroupLocalUseCase.call(ParamsSaveGroupLocalUseCase(groupItem: testGroupModel)));
      },
    );
    blocTest<GroupBloc, GroupState>(
      'Should emit [LoadingGroupState, ErrorGroupState(Exception)] when something went wrong',
      build: () {
        when(mockSaveGroupLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupBloc;
      },
      act: (bloc) => bloc.add(SaveGroupLocalEvent(testGroupModel)),
      expect: () => [
        const LoadingGroupState(),
        const ErrorGroupState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockSaveGroupLocalUseCase.call(ParamsSaveGroupLocalUseCase(groupItem: testGroupModel)));
      },
    );
  });

  group("getAllGroupsRemoteEvent", () {
    blocTest<GroupBloc, GroupState>(
      'Should emit [LoadingGroupState, GetAllGroupsRemoteState] when data is gotten successfully',
      build: () {
        when(mockGetAllGroupsRemoteUseCase.call(any))
            .thenAnswer((_) async => Right([testGroupModel]));
        return groupBloc;
      },
      act: (bloc) => bloc.add(const GetAllGroupsRemoteEvent()),
      expect: () => [
        const LoadingGroupState(),
        GetAllGroupsRemoteState(groupItems: [testGroupModel]),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupsRemoteUseCase.call(NoParams()));
      },
    );
    blocTest<GroupBloc, GroupState>(
      'Should emit [LoadingGroupState, ErrorGroupState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockGetAllGroupsRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return groupBloc;
      },
      act: (bloc) => bloc.add(const GetAllGroupsRemoteEvent()),
      expect: () => [
        const LoadingGroupState(),
        const ErrorGroupState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupsRemoteUseCase.call(NoParams()));
      },
    );
    blocTest<GroupBloc, GroupState>(
      'Should emit [LoadingGroupState, ErrorGroupState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockGetAllGroupsRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return groupBloc;
      },
      act: (bloc) => bloc.add(const GetAllGroupsRemoteEvent()),
      expect: () => [
        const LoadingGroupState(),
        const ErrorGroupState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupsRemoteUseCase.call(NoParams()));
      },
    );
    blocTest<GroupBloc, GroupState>(
      'Should emit [LoadingGroupState, ErrorGroupState(Exception)] when something went wrong',
      build: () {
        when(mockGetAllGroupsRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupBloc;
      },
      act: (bloc) => bloc.add(const GetAllGroupsRemoteEvent()),
      expect: () => [
        const LoadingGroupState(),
        const ErrorGroupState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupsRemoteUseCase.call(NoParams()));
      },
    );
  });

  group("getGroupRemoteEvent", () {
    blocTest<GroupBloc, GroupState>(
      'Should emit [LoadingGroupState, GetGroupRemoteState] when data is gotten successfully',
      build: () {
        when(mockGetGroupRemoteUseCase.call(any))
            .thenAnswer((_) async => Right(testGroupModel));
        return groupBloc;
      },
      act: (bloc) => bloc.add(GetGroupRemoteEvent(groupId)),
      expect: () => [
        const LoadingGroupState(),
        GetGroupRemoteState(groupItem: testGroupModel),
      ],
      verify: (bloc) {
        verify(mockGetGroupRemoteUseCase.call(ParamsGetGroupRemoteUseCase(groupId: groupId)));
      },
    );
    blocTest<GroupBloc, GroupState>(
      'Should emit [LoadingGroupState, ErrorGroupState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockGetGroupRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return groupBloc;
      },
      act: (bloc) => bloc.add(GetGroupRemoteEvent(groupId)),
      expect: () => [
        const LoadingGroupState(),
        const ErrorGroupState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetGroupRemoteUseCase.call(ParamsGetGroupRemoteUseCase(groupId: groupId)));
      },
    );
    blocTest<GroupBloc, GroupState>(
      'Should emit [LoadingGroupState, ErrorGroupState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockGetGroupRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return groupBloc;
      },
      act: (bloc) => bloc.add(GetGroupRemoteEvent(groupId)),
      expect: () => [
        const LoadingGroupState(),
        const ErrorGroupState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetGroupRemoteUseCase.call(ParamsGetGroupRemoteUseCase(groupId: groupId)));
      },
    );
    blocTest<GroupBloc, GroupState>(
      'Should emit [LoadingGroupState, ErrorGroupState(Exception)] when something went wrong',
      build: () {
        when(mockGetGroupRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupBloc;
      },
      act: (bloc) => bloc.add(GetGroupRemoteEvent(groupId)),
      expect: () => [
        const LoadingGroupState(),
        const ErrorGroupState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetGroupRemoteUseCase.call(ParamsGetGroupRemoteUseCase(groupId: groupId)));
      },
    );
  });

  group("saveGroupRemoteEvent", () {
    blocTest<GroupBloc, GroupState>(
      'Should emit [LoadingGroupState, SaveGroupRemoteState] when data is gotten successfully',
      build: () {
        when(mockSaveGroupRemoteUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return groupBloc;
      },
      act: (bloc) => bloc.add(SaveGroupRemoteEvent(testGroupModel)),
      expect: () => [
        const LoadingGroupState(),
        const SaveGroupRemoteState(hasSaved: true),
      ],
      verify: (bloc) {
        verify(mockSaveGroupRemoteUseCase.call(ParamsSaveGroupRemoteUseCase(groupItem: testGroupModel)));
      },
    );
    blocTest<GroupBloc, GroupState>(
      'Should emit [LoadingGroupState, ErrorGroupState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockSaveGroupRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return groupBloc;
      },
      act: (bloc) => bloc.add(SaveGroupRemoteEvent(testGroupModel)),
      expect: () => [
        const LoadingGroupState(),
        const ErrorGroupState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockSaveGroupRemoteUseCase.call(ParamsSaveGroupRemoteUseCase(groupItem: testGroupModel)));
      },
    );
    blocTest<GroupBloc, GroupState>(
      'Should emit [LoadingGroupState, ErrorGroupState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockSaveGroupRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return groupBloc;
      },
      act: (bloc) => bloc.add(SaveGroupRemoteEvent(testGroupModel)),
      expect: () => [
        const LoadingGroupState(),
        const ErrorGroupState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockSaveGroupRemoteUseCase.call(ParamsSaveGroupRemoteUseCase(groupItem: testGroupModel)));
      },
    );
    blocTest<GroupBloc, GroupState>(
      'Should emit [LoadingGroupState, ErrorGroupState(Exception)] when something went wrong',
      build: () {
        when(mockSaveGroupRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupBloc;
      },
      act: (bloc) => bloc.add(SaveGroupRemoteEvent(testGroupModel)),
      expect: () => [
        const LoadingGroupState(),
        const ErrorGroupState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockSaveGroupRemoteUseCase.call(ParamsSaveGroupRemoteUseCase(groupItem: testGroupModel)));
      },
    );
  });
}