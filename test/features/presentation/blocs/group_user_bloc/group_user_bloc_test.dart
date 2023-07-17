



import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/features/data/models/group_user_model.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/get_all_group_users_by_phone_number_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/get_all_group_users_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/get_all_group_users_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/get_group_user_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/remove_group_user_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/remove_group_user_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/save_group_user_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/save_group_user_remote_usecase.dart';
import 'package:messenger/features/presentation/blocs/group_user_bloc/group_user_bloc.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GroupUserBloc groupUserBloc;
  late MockGetAllGroupUsersByPhoneNumberRemoteUseCase mockGetAllGroupUsersByPhoneNumberRemoteUseCase;
  late MockGetAllGroupUsersLocalUseCase mockGetAllGroupUsersLocalUseCase;
  late MockGetAllGroupUsersRemoteUseCase mockGetAllGroupUsersRemoteUseCase;
  late MockGetGroupUserLocalUseCase mockGetGroupUserLocalUseCase;
  late MockRemoveGroupUserLocalUseCase mockRemoveGroupUserLocalUseCase;
  late MockRemoveGroupUserRemoteUseCase mockRemoveGroupUserRemoteUseCase;
  late MockSaveGroupUserLocalUseCase mockSaveGroupUserLocalUseCase;
  late MockSaveGroupUserRemoteUseCase mockSaveGroupUserRemoteUseCase;

  setUp(() {
    mockGetAllGroupUsersByPhoneNumberRemoteUseCase = MockGetAllGroupUsersByPhoneNumberRemoteUseCase();
    mockGetAllGroupUsersLocalUseCase = MockGetAllGroupUsersLocalUseCase();
    mockGetAllGroupUsersRemoteUseCase = MockGetAllGroupUsersRemoteUseCase();
    mockGetGroupUserLocalUseCase = MockGetGroupUserLocalUseCase();
    mockRemoveGroupUserLocalUseCase = MockRemoveGroupUserLocalUseCase();
    mockRemoveGroupUserRemoteUseCase = MockRemoveGroupUserRemoteUseCase();
    mockSaveGroupUserLocalUseCase = MockSaveGroupUserLocalUseCase();
    mockSaveGroupUserRemoteUseCase = MockSaveGroupUserRemoteUseCase();

    groupUserBloc = GroupUserBloc(
      getAllGroupUsersByPhoneNumberRemoteUseCase: mockGetAllGroupUsersByPhoneNumberRemoteUseCase,
      getAllGroupUsersLocalUseCase: mockGetAllGroupUsersLocalUseCase,
      getAllGroupUsersRemoteUseCase: mockGetAllGroupUsersRemoteUseCase,
      getGroupUserLocalUseCase: mockGetGroupUserLocalUseCase,
      removeGroupUserLocalUseCase: mockRemoveGroupUserLocalUseCase,
      removeGroupUserRemoteUseCase: mockRemoveGroupUserRemoteUseCase,
      saveGroupUserLocalUseCase: mockSaveGroupUserLocalUseCase,
      saveGroupUserRemoteUseCase: mockSaveGroupUserRemoteUseCase,
    );
  });

  final testJson = fixtureReader("group_user_model.json");
  final testGroupUserModel = GroupUserModel.fromJson(json.decode(testJson));
  String groupId = testGroupUserModel.groupId.toString();
  String userPhoneNumber = testGroupUserModel.userPhoneNumber.toString();


  test("initial state should be InitGroupUserState", () {
    // assert
    expect(groupUserBloc.state, const InitGroupUserState());
  });

  group("getAllGroupUsersLocalEvent", () {
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, GetAllGroupUsersLocalState] when data is gotten successfully',
      build: () {
        when(mockGetAllGroupUsersLocalUseCase.call(any))
            .thenAnswer((_) async => Right([testGroupUserModel]));
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(GetAllGroupUsersLocalEvent(groupId)),
      expect: () => [
        const LoadingGroupUserState(),
        GetAllGroupUsersLocalState(groupUserItems: [testGroupUserModel]),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupUsersLocalUseCase.call(ParamsGetAllGroupUsersLocalUseCase(groupId: groupId)));
      },
    );
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, ErrorGroupUserState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockGetAllGroupUsersLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(GetAllGroupUsersLocalEvent(groupId)),
      expect: () => [
        const LoadingGroupUserState(),
        const ErrorGroupUserState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupUsersLocalUseCase.call(ParamsGetAllGroupUsersLocalUseCase(groupId: groupId)));
      },
    );
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, ErrorGroupUserState(Exception)] when something went wrong',
      build: () {
        when(mockGetAllGroupUsersLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(GetAllGroupUsersLocalEvent(groupId)),
      expect: () => [
        const LoadingGroupUserState(),
        const ErrorGroupUserState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupUsersLocalUseCase.call(ParamsGetAllGroupUsersLocalUseCase(groupId: groupId)));
      },
    );
  });

  group("getGroupUsersLocalEvent", () {
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, GetGroupUsersLocalState] when data is gotten successfully',
      build: () {
        when(mockGetGroupUserLocalUseCase.call(any))
            .thenAnswer((_) async => Right(testGroupUserModel));
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(GetGroupUserLocalEvent(groupId, userPhoneNumber)),
      expect: () => [
        const LoadingGroupUserState(),
        GetGroupUserLocalState(groupUserItem: testGroupUserModel),
      ],
      verify: (bloc) {
        verify(mockGetGroupUserLocalUseCase.call(ParamsGetGroupUserLocalUseCase(groupId: groupId, userPhoneNumber: userPhoneNumber)));
      },
    );
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, ErrorGroupUserState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockGetGroupUserLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(GetGroupUserLocalEvent(groupId, userPhoneNumber)),
      expect: () => [
        const LoadingGroupUserState(),
        const ErrorGroupUserState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetGroupUserLocalUseCase.call(ParamsGetGroupUserLocalUseCase(groupId: groupId, userPhoneNumber: userPhoneNumber)));
      },
    );
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, ErrorGroupUserState(Exception)] when something went wrong',
      build: () {
        when(mockGetGroupUserLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(GetGroupUserLocalEvent(groupId, userPhoneNumber)),
      expect: () => [
        const LoadingGroupUserState(),
        const ErrorGroupUserState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetGroupUserLocalUseCase.call(ParamsGetGroupUserLocalUseCase(groupId: groupId, userPhoneNumber: userPhoneNumber)));
      },
    );
  });

  group("removeGroupUserLocalEvent", () {
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, RemoveGroupUsersLocalState] when data is gotten successfully',
      build: () {
        when(mockRemoveGroupUserLocalUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(RemoveGroupUserLocalEvent(groupId, userPhoneNumber)),
      expect: () => [
        const LoadingGroupUserState(),
        const RemoveGroupUserLocalState(hasRemoved: true),
      ],
      verify: (bloc) {
        verify(mockRemoveGroupUserLocalUseCase.call(ParamsRemoveGroupUserLocalUseCase(groupId: groupId, userPhoneNumber: userPhoneNumber)));
      },
    );
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, ErrorGroupUserState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockRemoveGroupUserLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(RemoveGroupUserLocalEvent(groupId, userPhoneNumber)),
      expect: () => [
        const LoadingGroupUserState(),
        const ErrorGroupUserState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockRemoveGroupUserLocalUseCase.call(ParamsRemoveGroupUserLocalUseCase(groupId: groupId, userPhoneNumber: userPhoneNumber)));
      },
    );
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, ErrorGroupUserState(Exception)] when something went wrong',
      build: () {
        when(mockRemoveGroupUserLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(RemoveGroupUserLocalEvent(groupId, userPhoneNumber)),
      expect: () => [
        const LoadingGroupUserState(),
        const ErrorGroupUserState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockRemoveGroupUserLocalUseCase.call(ParamsRemoveGroupUserLocalUseCase(groupId: groupId, userPhoneNumber: userPhoneNumber)));
      },
    );
  });

  group("saveGroupUserLocalEvent", () {
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, SaveGroupUsersLocalState] when data is gotten successfully',
      build: () {
        when(mockSaveGroupUserLocalUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(SaveGroupUserLocalEvent(testGroupUserModel)),
      expect: () => [
        const LoadingGroupUserState(),
        const SaveGroupUserLocalState(hasSaved: true),
      ],
      verify: (bloc) {
        verify(mockSaveGroupUserLocalUseCase.call(ParamsSaveGroupUserLocalUseCase(groupUserItem: testGroupUserModel)));
      },
    );
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, ErrorGroupUserState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockSaveGroupUserLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(SaveGroupUserLocalEvent(testGroupUserModel)),
      expect: () => [
        const LoadingGroupUserState(),
        const ErrorGroupUserState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockSaveGroupUserLocalUseCase.call(ParamsSaveGroupUserLocalUseCase(groupUserItem: testGroupUserModel)));
      },
    );
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, ErrorGroupUserState(Exception)] when something went wrong',
      build: () {
        when(mockSaveGroupUserLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(SaveGroupUserLocalEvent(testGroupUserModel)),
      expect: () => [
        const LoadingGroupUserState(),
        const ErrorGroupUserState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockSaveGroupUserLocalUseCase.call(ParamsSaveGroupUserLocalUseCase(groupUserItem: testGroupUserModel)));
      },
    );
  });

  group("getAllGroupUsersRemoteEvent", () {
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, GetAllGroupUsersRemoteState] when data is gotten successfully',
      build: () {
        when(mockGetAllGroupUsersRemoteUseCase.call(any))
            .thenAnswer((_) async => Right([testGroupUserModel]));
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(GetAllGroupUsersRemoteEvent(groupId)),
      expect: () => [
        const LoadingGroupUserState(),
        GetAllGroupUsersRemoteState(groupUserItems: [testGroupUserModel]),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupUsersRemoteUseCase.call(ParamsGetAllGroupUsersRemoteUseCase(groupId: groupId)));
      },
    );
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, ErrorGroupUserState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockGetAllGroupUsersRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(GetAllGroupUsersRemoteEvent(groupId)),
      expect: () => [
        const LoadingGroupUserState(),
        const ErrorGroupUserState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupUsersRemoteUseCase.call(ParamsGetAllGroupUsersRemoteUseCase(groupId: groupId)));
      },
    );
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, ErrorGroupUserState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockGetAllGroupUsersRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(GetAllGroupUsersRemoteEvent(groupId)),
      expect: () => [
        const LoadingGroupUserState(),
        const ErrorGroupUserState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupUsersRemoteUseCase.call(ParamsGetAllGroupUsersRemoteUseCase(groupId: groupId)));
      },
    );
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, ErrorGroupUserState(Exception)] when something went wrong',
      build: () {
        when(mockGetAllGroupUsersRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(GetAllGroupUsersRemoteEvent(groupId)),
      expect: () => [
        const LoadingGroupUserState(),
        const ErrorGroupUserState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupUsersRemoteUseCase.call(ParamsGetAllGroupUsersRemoteUseCase(groupId: groupId)));
      },
    );
  });

  group("getAllGroupUsersByPhoneNumberRemoteEvent", () {
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, GetAllGroupUsersByPhoneNumberRemoteState] when data is gotten successfully',
      build: () {
        when(mockGetAllGroupUsersByPhoneNumberRemoteUseCase.call(any))
            .thenAnswer((_) async => Right([testGroupUserModel]));
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(GetAllGroupUsersByPhoneNumberRemoteEvent(userPhoneNumber)),
      expect: () => [
        const LoadingGroupUserState(),
        GetAllGroupUsersByPhoneNumberRemoteState(groupUserItems: [testGroupUserModel]),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupUsersByPhoneNumberRemoteUseCase.call(ParamsGetAllGroupUsersByPhoneNumberRemoteUseCase(userPhoneNumber: userPhoneNumber)));
      },
    );
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, ErrorGroupUserState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockGetAllGroupUsersByPhoneNumberRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(GetAllGroupUsersByPhoneNumberRemoteEvent(userPhoneNumber)),
      expect: () => [
        const LoadingGroupUserState(),
        const ErrorGroupUserState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupUsersByPhoneNumberRemoteUseCase.call(ParamsGetAllGroupUsersByPhoneNumberRemoteUseCase(userPhoneNumber: userPhoneNumber)));
      },
    );
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, ErrorGroupUserState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockGetAllGroupUsersByPhoneNumberRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(GetAllGroupUsersByPhoneNumberRemoteEvent(userPhoneNumber)),
      expect: () => [
        const LoadingGroupUserState(),
        const ErrorGroupUserState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupUsersByPhoneNumberRemoteUseCase.call(ParamsGetAllGroupUsersByPhoneNumberRemoteUseCase(userPhoneNumber: userPhoneNumber)));
      },
    );
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, ErrorGroupUserState(Exception)] when something went wrong',
      build: () {
        when(mockGetAllGroupUsersByPhoneNumberRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(GetAllGroupUsersByPhoneNumberRemoteEvent(userPhoneNumber)),
      expect: () => [
        const LoadingGroupUserState(),
        const ErrorGroupUserState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetAllGroupUsersByPhoneNumberRemoteUseCase.call(ParamsGetAllGroupUsersByPhoneNumberRemoteUseCase(userPhoneNumber: userPhoneNumber)));
      },
    );
  });

  group("removeGroupUserRemoteEvent", () {
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, RemoveGroupUsersRemoteState] when data is gotten successfully',
      build: () {
        when(mockRemoveGroupUserRemoteUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(RemoveGroupUserRemoteEvent(groupId, userPhoneNumber)),
      expect: () => [
        const LoadingGroupUserState(),
        const RemoveGroupUserRemoteState(hasRemoved: true),
      ],
      verify: (bloc) {
        verify(mockRemoveGroupUserRemoteUseCase.call(ParamsRemoveGroupUserRemoteUseCase(groupId: groupId, userPhoneNumber: userPhoneNumber)));
      },
    );
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, ErrorGroupUserState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockRemoveGroupUserRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(RemoveGroupUserRemoteEvent(groupId, userPhoneNumber)),
      expect: () => [
        const LoadingGroupUserState(),
        const ErrorGroupUserState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockRemoveGroupUserRemoteUseCase.call(ParamsRemoveGroupUserRemoteUseCase(groupId: groupId, userPhoneNumber: userPhoneNumber)));
      },
    );
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, ErrorGroupUserState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockRemoveGroupUserRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(RemoveGroupUserRemoteEvent(groupId, userPhoneNumber)),
      expect: () => [
        const LoadingGroupUserState(),
        const ErrorGroupUserState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockRemoveGroupUserRemoteUseCase.call(ParamsRemoveGroupUserRemoteUseCase(groupId: groupId, userPhoneNumber: userPhoneNumber)));
      },
    );
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, ErrorGroupUserState(Exception)] when something went wrong',
      build: () {
        when(mockRemoveGroupUserRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(RemoveGroupUserRemoteEvent(groupId, userPhoneNumber)),
      expect: () => [
        const LoadingGroupUserState(),
        const ErrorGroupUserState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockRemoveGroupUserRemoteUseCase.call(ParamsRemoveGroupUserRemoteUseCase(groupId: groupId, userPhoneNumber: userPhoneNumber)));
      },
    );
  });

  group("saveGroupUserRemoteEvent", () {
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, SaveGroupUsersRemoteState] when data is gotten successfully',
      build: () {
        when(mockSaveGroupUserRemoteUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(SaveGroupUserRemoteEvent(testGroupUserModel)),
      expect: () => [
        const LoadingGroupUserState(),
        const SaveGroupUserRemoteState(hasSaved: true),
      ],
      verify: (bloc) {
        verify(mockSaveGroupUserRemoteUseCase.call(ParamsSaveGroupUserRemoteUseCase(groupUserItem: testGroupUserModel)));
      },
    );
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, ErrorGroupUserState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockSaveGroupUserRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(SaveGroupUserRemoteEvent(testGroupUserModel)),
      expect: () => [
        const LoadingGroupUserState(),
        const ErrorGroupUserState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockSaveGroupUserRemoteUseCase.call(ParamsSaveGroupUserRemoteUseCase(groupUserItem: testGroupUserModel)));
      },
    );
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, ErrorGroupUserState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockSaveGroupUserRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(SaveGroupUserRemoteEvent(testGroupUserModel)),
      expect: () => [
        const LoadingGroupUserState(),
        const ErrorGroupUserState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockSaveGroupUserRemoteUseCase.call(ParamsSaveGroupUserRemoteUseCase(groupUserItem: testGroupUserModel)));
      },
    );
    blocTest<GroupUserBloc, GroupUserState>(
      'Should emit [LoadingGroupUserState, ErrorGroupUserState(Exception)] when something went wrong',
      build: () {
        when(mockSaveGroupUserRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return groupUserBloc;
      },
      act: (bloc) => bloc.add(SaveGroupUserRemoteEvent(testGroupUserModel)),
      expect: () => [
        const LoadingGroupUserState(),
        const ErrorGroupUserState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockSaveGroupUserRemoteUseCase.call(ParamsSaveGroupUserRemoteUseCase(groupUserItem: testGroupUserModel)));
      },
    );
  });
}