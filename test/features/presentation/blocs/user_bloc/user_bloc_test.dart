
import "dart:convert";

import "package:bloc_test/bloc_test.dart";
import "package:dartz/dartz.dart";
import "package:flutter_test/flutter_test.dart";
import "package:messenger/features/data/models/sms_model.dart";
import "package:mockito/mockito.dart";
import "package:messenger/core/constants/constants.dart";
import "package:messenger/core/errors/failures.dart";
import "package:messenger/core/usecase/usecase.dart";
import "package:messenger/features/data/models/user_model.dart";
import "package:messenger/features/domain/usecases/user_usecases/exist_user_local_usecase.dart";
import "package:messenger/features/domain/usecases/user_usecases/get_user_local_usecase.dart";
import "package:messenger/features/domain/usecases/user_usecases/get_user_remote_usecase.dart";
import "package:messenger/features/domain/usecases/user_usecases/remove_user_local_usecase.dart";
import "package:messenger/features/domain/usecases/user_usecases/save_user_local_usecase.dart";
import "package:messenger/features/domain/usecases/user_usecases/save_user_remote_usecase.dart";
import "package:messenger/features/domain/usecases/user_usecases/send_sms_verifycode_remote_usecase.dart";
import "package:messenger/features/domain/usecases/user_usecases/set_user_lastseen_datetime_remote_usecase.dart";
import "package:messenger/features/presentation/blocs/user_bloc/user_bloc.dart";

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';


void main() {
  late UserBloc userBloc;
  late MockExistUserLocalUseCase mockExistUserLocalUseCase;
  late MockGetAllUsersLocalUseCase mockGetAllUsersLocalUseCase;
  late MockGetAllUsersRemoteUseCase mockGetAllUsersRemoteUseCase;
  late MockGetUserLocalUseCase mockGetUserLocalUseCase;
  late MockGetUserRemoteUseCase mockGetUserRemoteUseCase;
  late MockRemoveUserLocalUseCase mockRemoveUserLocalUseCase;
  late MockSaveUserLocalUseCase mockSaveUserLocalUseCase;
  late MockSaveUserRemoteUseCase mockSaveUserRemoteUseCase;
  late MockSendSMSVerifyCodeRemoteUseCase mockSendSMSVerifyCodeRemoteUseCase;
  late MockSetUserLastSeenDateTimeRemoteUseCase mockSetUserLastSeenDateTimeRemoteUseCase;


  setUp(() {
    mockExistUserLocalUseCase = MockExistUserLocalUseCase();
    mockGetAllUsersLocalUseCase = MockGetAllUsersLocalUseCase();
    mockGetAllUsersRemoteUseCase = MockGetAllUsersRemoteUseCase();
    mockGetUserLocalUseCase = MockGetUserLocalUseCase();
    mockGetUserRemoteUseCase = MockGetUserRemoteUseCase();
    mockRemoveUserLocalUseCase = MockRemoveUserLocalUseCase();
    mockSaveUserLocalUseCase = MockSaveUserLocalUseCase();
    mockSaveUserRemoteUseCase = MockSaveUserRemoteUseCase();
    mockSendSMSVerifyCodeRemoteUseCase = MockSendSMSVerifyCodeRemoteUseCase();
    mockSetUserLastSeenDateTimeRemoteUseCase = MockSetUserLastSeenDateTimeRemoteUseCase();

    userBloc = UserBloc(
      existUserLocalUseCase: mockExistUserLocalUseCase,
      getAllUsersLocalUseCase: mockGetAllUsersLocalUseCase,
      getAllUsersRemoteUseCase: mockGetAllUsersRemoteUseCase,
      getUserLocalUseCase: mockGetUserLocalUseCase,
      getUserRemoteUseCase: mockGetUserRemoteUseCase,
      removeUserLocalUseCase: mockRemoveUserLocalUseCase,
      saveUserLocalUseCase: mockSaveUserLocalUseCase,
      saveUserRemoteUseCase: mockSaveUserRemoteUseCase,
      sendSMSVerifyCodeRemoteUseCase: mockSendSMSVerifyCodeRemoteUseCase,
      setUserLastSeenDateTimeRemoteUseCase: mockSetUserLastSeenDateTimeRemoteUseCase,
    );
  });

  final testJson = fixtureReader("user_model.json");
  final testUserModel = UserModel.fromJson(json.decode(testJson));
  String userPhoneNumber = testUserModel.userPhoneNumber.toString();
  String lastSeenDateTime = testUserModel.lastSeenDateTime.toString();



  test("initial state should be InitUserState", () {
    // assert
    expect(userBloc.state, const InitUserState());
  });


  group("existUserLocalEvent", () {
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ExistUserLocalState] when data is gotten successfully',
      build: () {
        when(mockExistUserLocalUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return userBloc;
      },
      act: (bloc) => bloc.add(ExistUserLocalEvent(userPhoneNumber)),
      expect: () => [
        const LoadingUserState(),
        const ExistUserLocalState(hasExistUser: true),
      ],
      verify: (bloc) {
        verify(mockExistUserLocalUseCase.call(ParamsExistUserLocalUseCase(userPhoneNumber: userPhoneNumber)));
      },
    );
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ErrorUserState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockExistUserLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(ExistUserLocalEvent(userPhoneNumber)),
      expect: () => [
        const LoadingUserState(),
        const ErrorUserState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockExistUserLocalUseCase.call(ParamsExistUserLocalUseCase(userPhoneNumber: userPhoneNumber)));
      },
    );
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ErrorUserState(Exception)] when something went wrong',
      build: () {
        when(mockExistUserLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return userBloc;
      },
      act: (bloc) => bloc.add(ExistUserLocalEvent(userPhoneNumber)),
      expect: () => [
        const LoadingUserState(),
        const ErrorUserState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockExistUserLocalUseCase.call(ParamsExistUserLocalUseCase(userPhoneNumber: userPhoneNumber)));
      },
    );
  });

  group("getAllUsersLocalEvent", () {
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, GetAllUsersLocalEvent] when data is gotten successfully',
      build: () {
        when(mockGetAllUsersLocalUseCase.call(any))
            .thenAnswer((_) async => Right([testUserModel]));
        return userBloc;
      },
      act: (bloc) => bloc.add(const GetAllUsersLocalEvent()),
      expect: () => [
        const LoadingUserState(),
        GetAllUserLocalState(userItems: [testUserModel]),
      ],
      verify: (bloc) {
        verify(mockGetAllUsersLocalUseCase.call(NoParams()));
      },
    );
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ErrorUserState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockGetAllUsersLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(const GetAllUsersLocalEvent()),
      expect: () => [
        const LoadingUserState(),
        const ErrorUserState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetAllUsersLocalUseCase.call(NoParams()));
      },
    );
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ErrorUserState(Exception)] when something went wrong',
      build: () {
        when(mockGetAllUsersLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return userBloc;
      },
      act: (bloc) => bloc.add(const GetAllUsersLocalEvent()),
      expect: () => [
        const LoadingUserState(),
        const ErrorUserState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetAllUsersLocalUseCase.call(NoParams()));
      },
    );
  });

  group("getUserLocalEvent", () {
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, GetUserLocalEvent] when data is gotten successfully',
      build: () {
        when(mockGetUserLocalUseCase.call(any))
            .thenAnswer((_) async => Right(testUserModel));
        return userBloc;
      },
      act: (bloc) => bloc.add(GetUserLocalEvent(userPhoneNumber)),
      expect: () => [
        const LoadingUserState(),
        GetUserLocalState(userItem: testUserModel),
      ],
      verify: (bloc) {
        verify(mockGetUserLocalUseCase.call(ParamsGetUserLocalUseCase(userPhoneNumber: userPhoneNumber)));
      },
    );
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ErrorUserState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockGetUserLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(GetUserLocalEvent(userPhoneNumber)),
      expect: () => [
        const LoadingUserState(),
        const ErrorUserState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetUserLocalUseCase.call(ParamsGetUserLocalUseCase(userPhoneNumber: userPhoneNumber)));
      },
    );
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ErrorUserState(Exception)] when something went wrong',
      build: () {
        when(mockGetUserLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return userBloc;
      },
      act: (bloc) => bloc.add(GetUserLocalEvent(userPhoneNumber)),
      expect: () => [
        const LoadingUserState(),
        const ErrorUserState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetUserLocalUseCase.call(ParamsGetUserLocalUseCase(userPhoneNumber: userPhoneNumber)));
      },
    );
  });

  group("removeUserLocalEvent", () {
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, RemoveUserLocalEvent] when data is gotten successfully',
      build: () {
        when(mockRemoveUserLocalUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return userBloc;
      },
      act: (bloc) => bloc.add(RemoveUserLocalEvent(userPhoneNumber)),
      expect: () => [
        const LoadingUserState(),
        const RemoveUserLocalState(hasRemoved: true),
      ],
      verify: (bloc) {
        verify(mockRemoveUserLocalUseCase.call(ParamsRemoveUserLocalUseCase(userPhoneNumber: userPhoneNumber)));
      },
    );
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ErrorUserState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockRemoveUserLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(RemoveUserLocalEvent(userPhoneNumber)),
      expect: () => [
        const LoadingUserState(),
        const ErrorUserState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockRemoveUserLocalUseCase.call(ParamsRemoveUserLocalUseCase(userPhoneNumber: userPhoneNumber)));
      },
    );
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ErrorUserState(Exception)] when something went wrong',
      build: () {
        when(mockRemoveUserLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return userBloc;
      },
      act: (bloc) => bloc.add(RemoveUserLocalEvent(userPhoneNumber)),
      expect: () => [
        const LoadingUserState(),
        const ErrorUserState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockRemoveUserLocalUseCase.call(ParamsRemoveUserLocalUseCase(userPhoneNumber: userPhoneNumber)));
      },
    );
  });

  group("saveUserLocalEvent", () {
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, SaveUserLocalEvent] when data is gotten successfully',
      build: () {
        when(mockSaveUserLocalUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return userBloc;
      },
      act: (bloc) => bloc.add(SaveUserLocalEvent(testUserModel)),
      expect: () => [
        const LoadingUserState(),
        const SaveUserLocalState(hasSaved: true),
      ],
      verify: (bloc) {
        verify(mockSaveUserLocalUseCase.call(ParamsSaveUserLocalUseCase(userItem: testUserModel)));
      },
    );
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ErrorUserState(DatabaseFailure)] when data is unsuccessful',
      build: () {
        when(mockSaveUserLocalUseCase.call(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(SaveUserLocalEvent(testUserModel)),
      expect: () => [
        const LoadingUserState(),
        const ErrorUserState(message: Constants.databaseFailureMessage),
      ],
      verify: (bloc) {
        verify(mockSaveUserLocalUseCase.call(ParamsSaveUserLocalUseCase(userItem: testUserModel)));
      },
    );
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ErrorUserState(Exception)] when something went wrong',
      build: () {
        when(mockSaveUserLocalUseCase.call(any))
            .thenThrow("Something went wrong");
        return userBloc;
      },
      act: (bloc) => bloc.add(SaveUserLocalEvent(testUserModel)),
      expect: () => [
        const LoadingUserState(),
        const ErrorUserState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockSaveUserLocalUseCase.call(ParamsSaveUserLocalUseCase(userItem: testUserModel)));
      },
    );
  });

  group("getAllUsersRemoteEvent", () {
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, GetAllUsersRemoteEvent] when data is gotten successfully',
      build: () {
        when(mockGetAllUsersRemoteUseCase.call(any))
            .thenAnswer((_) async => Right([testUserModel]));
        return userBloc;
      },
      act: (bloc) => bloc.add(const GetAllUsersRemoteEvent()),
      expect: () => [
        const LoadingUserState(),
        GetAllUserRemoteState(userItems: [testUserModel]),
      ],
      verify: (bloc) {
        verify(mockGetAllUsersRemoteUseCase.call(NoParams()));
      },
    );
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ErrorUserState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockGetAllUsersRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(const GetAllUsersRemoteEvent()),
      expect: () => [
        const LoadingUserState(),
        const ErrorUserState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetAllUsersRemoteUseCase.call(NoParams()));
      },
    );
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ErrorUserState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockGetAllUsersRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(const GetAllUsersRemoteEvent()),
      expect: () => [
        const LoadingUserState(),
        const ErrorUserState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetAllUsersRemoteUseCase.call(NoParams()));
      },
    );
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ErrorUserState(Exception)] when something went wrong',
      build: () {
        when(mockGetAllUsersRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return userBloc;
      },
      act: (bloc) => bloc.add(const GetAllUsersRemoteEvent()),
      expect: () => [
        const LoadingUserState(),
        const ErrorUserState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetAllUsersRemoteUseCase.call(NoParams()));
      },
    );
  });

  group("getUserRemoteEvent", () {
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, GetUserRemoteEvent] when data is gotten successfully',
      build: () {
        when(mockGetUserRemoteUseCase.call(any))
            .thenAnswer((_) async => Right(testUserModel));
        return userBloc;
      },
      act: (bloc) => bloc.add(GetUserRemoteEvent(userPhoneNumber)),
      expect: () => [
        const LoadingUserState(),
        GetUserRemoteState(userItem: testUserModel),
      ],
      verify: (bloc) {
        verify(mockGetUserRemoteUseCase.call(ParamsGetUserRemoteUseCase(userPhoneNumber: userPhoneNumber)));
      },
    );
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ErrorUserState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockGetUserRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(GetUserRemoteEvent(userPhoneNumber)),
      expect: () => [
        const LoadingUserState(),
        const ErrorUserState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetUserRemoteUseCase.call(ParamsGetUserRemoteUseCase(userPhoneNumber: userPhoneNumber)));
      },
    );
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ErrorUserState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockGetUserRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(GetUserRemoteEvent(userPhoneNumber)),
      expect: () => [
        const LoadingUserState(),
        const ErrorUserState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockGetUserRemoteUseCase.call(ParamsGetUserRemoteUseCase(userPhoneNumber: userPhoneNumber)));
      },
    );
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ErrorUserState(Exception)] when something went wrong',
      build: () {
        when(mockGetUserRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return userBloc;
      },
      act: (bloc) => bloc.add(GetUserRemoteEvent(userPhoneNumber)),
      expect: () => [
        const LoadingUserState(),
        const ErrorUserState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockGetUserRemoteUseCase.call(ParamsGetUserRemoteUseCase(userPhoneNumber: userPhoneNumber)));
      },
    );
  });

  group("saveUserRemoteEvent", () {
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, SaveUserRemoteEvent] when data is gotten successfully',
      build: () {
        when(mockSaveUserRemoteUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return userBloc;
      },
      act: (bloc) => bloc.add(SaveUserRemoteEvent(testUserModel)),
      expect: () => [
        const LoadingUserState(),
        const SaveUserRemoteState(hasSaved: true),
      ],
      verify: (bloc) {
        verify(mockSaveUserRemoteUseCase.call(ParamsSaveUserRemoteUseCase(userItem: testUserModel)));
      },
    );
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ErrorUserState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockSaveUserRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(SaveUserRemoteEvent(testUserModel)),
      expect: () => [
        const LoadingUserState(),
        const ErrorUserState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockSaveUserRemoteUseCase.call(ParamsSaveUserRemoteUseCase(userItem: testUserModel)));
      },
    );
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ErrorUserState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockSaveUserRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(SaveUserRemoteEvent(testUserModel)),
      expect: () => [
        const LoadingUserState(),
        const ErrorUserState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockSaveUserRemoteUseCase.call(ParamsSaveUserRemoteUseCase(userItem: testUserModel)));
      },
    );
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ErrorUserState(Exception)] when something went wrong',
      build: () {
        when(mockSaveUserRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return userBloc;
      },
      act: (bloc) => bloc.add(SaveUserRemoteEvent(testUserModel)),
      expect: () => [
        const LoadingUserState(),
        const ErrorUserState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockSaveUserRemoteUseCase.call(ParamsSaveUserRemoteUseCase(userItem: testUserModel)));
      },
    );
  });

  group("setUserLastSeenDateTimeRemoteEvent", () {
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, SetUserLastSeenDateTimeRemoteEvent] when data is gotten successfully',
      build: () {
        when(mockSetUserLastSeenDateTimeRemoteUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return userBloc;
      },
      act: (bloc) => bloc.add(SetUserLastSeenDateTimeRemoteEvent(userPhoneNumber, lastSeenDateTime)),
      expect: () => [
        const LoadingUserState(),
        const SetUserLastSeenDateTimeRemoteState(hasSet: true),
      ],
      verify: (bloc) {
        verify(mockSetUserLastSeenDateTimeRemoteUseCase.call(ParamsSetUserLastSeenDateTimeRemoteUseCase(userPhoneNumber: userPhoneNumber, lastSeenDateTime: lastSeenDateTime)));
      },
    );
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ErrorUserState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockSetUserLastSeenDateTimeRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(SetUserLastSeenDateTimeRemoteEvent(userPhoneNumber, lastSeenDateTime)),
      expect: () => [
        const LoadingUserState(),
        const ErrorUserState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockSetUserLastSeenDateTimeRemoteUseCase.call(ParamsSetUserLastSeenDateTimeRemoteUseCase(userPhoneNumber: userPhoneNumber, lastSeenDateTime: lastSeenDateTime)));
      },
    );
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ErrorUserState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockSetUserLastSeenDateTimeRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(SetUserLastSeenDateTimeRemoteEvent(userPhoneNumber, lastSeenDateTime)),
      expect: () => [
        const LoadingUserState(),
        const ErrorUserState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockSetUserLastSeenDateTimeRemoteUseCase.call(ParamsSetUserLastSeenDateTimeRemoteUseCase(userPhoneNumber: userPhoneNumber, lastSeenDateTime: lastSeenDateTime)));
      },
    );
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ErrorUserState(Exception)] when something went wrong',
      build: () {
        when(mockSetUserLastSeenDateTimeRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return userBloc;
      },
      act: (bloc) => bloc.add(SetUserLastSeenDateTimeRemoteEvent(userPhoneNumber, lastSeenDateTime)),
      expect: () => [
        const LoadingUserState(),
        const ErrorUserState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockSetUserLastSeenDateTimeRemoteUseCase.call(ParamsSetUserLastSeenDateTimeRemoteUseCase(userPhoneNumber: userPhoneNumber, lastSeenDateTime: lastSeenDateTime)));
      },
    );
  });

  group("sendSMSVerifyCodeRemoteEvent", () {
    final testSMSModel = SMSModel(userPhoneNumber: testUserModel.userPhoneNumber!,
        verifyCode: testUserModel.verifyCode!);

    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, SendSMSVerifyCodeRemoteEvent] when data is gotten successfully',
      build: () {
        when(mockSendSMSVerifyCodeRemoteUseCase.call(any))
            .thenAnswer((_) async => const Right(true));
        return userBloc;
      },
      act: (bloc) => bloc.add(SendSMSVerifyCodeRemoteEvent(testSMSModel)),
      expect: () => [
        const LoadingUserState(),
        const SendSMSVerifyCodeRemoteState(hasSent: true),
      ],
      verify: (bloc) {
        verify(mockSendSMSVerifyCodeRemoteUseCase.call(ParamsSendSMSVerifyCodeRemoteUseCase(smsItem: testSMSModel)));
      },
    );
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ErrorUserState(ServerFailure)] when data is unsuccessful',
      build: () {
        when(mockSendSMSVerifyCodeRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(SendSMSVerifyCodeRemoteEvent(testSMSModel)),
      expect: () => [
        const LoadingUserState(),
        const ErrorUserState(message: Constants.serverFailureMessage),
      ],
      verify: (bloc) {
        verify(mockSendSMSVerifyCodeRemoteUseCase.call(ParamsSendSMSVerifyCodeRemoteUseCase(smsItem: testSMSModel)));
      },
    );
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ErrorUserState(ConnectionFailure)] when data is unsuccessful',
      build: () {
        when(mockSendSMSVerifyCodeRemoteUseCase.call(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(SendSMSVerifyCodeRemoteEvent(testSMSModel)),
      expect: () => [
        const LoadingUserState(),
        const ErrorUserState(message: Constants.connectionFailureMessage),
      ],
      verify: (bloc) {
        verify(mockSendSMSVerifyCodeRemoteUseCase.call(ParamsSendSMSVerifyCodeRemoteUseCase(smsItem: testSMSModel)));
      },
    );
    blocTest<UserBloc, UserState>(
      'Should emit [LoadingUserState, ErrorUserState(Exception)] when something went wrong',
      build: () {
        when(mockSendSMSVerifyCodeRemoteUseCase.call(any))
            .thenThrow("Something went wrong");
        return userBloc;
      },
      act: (bloc) => bloc.add(SendSMSVerifyCodeRemoteEvent(testSMSModel)),
      expect: () => [
        const LoadingUserState(),
        const ErrorUserState(message: "Something went wrong"),
      ],
      verify: (bloc) {
        verify(mockSendSMSVerifyCodeRemoteUseCase.call(ParamsSendSMSVerifyCodeRemoteUseCase(smsItem: testSMSModel)));
      },
    );
  });

}

