


import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:messenger/features/presentation/blocs/group_bloc/group_bloc.dart';
import 'package:messenger/features/presentation/blocs/group_message_bloc/group_message_bloc.dart';
import 'package:messenger/features/presentation/blocs/group_message_type_bloc/group_message_type_bloc.dart';
import 'package:messenger/features/presentation/blocs/group_user_bloc/group_user_bloc.dart';
import 'package:messenger/features/presentation/blocs/message_bloc/message_bloc.dart';
import 'package:messenger/features/presentation/providers/directionality_provider.dart';
import 'package:messenger/features/presentation/rx_dart/message_rx_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:messenger/core/networks/network_info.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/utils/date_converter.dart';
import 'package:messenger/features/data/datasources/db/database_helper.dart';
import 'package:messenger/features/data/datasources/local/group_local_datasource.dart';
import 'package:messenger/features/data/datasources/local/group_message_local_datasource.dart';
import 'package:messenger/features/data/datasources/local/group_message_type_local_datasource.dart';
import 'package:messenger/features/data/datasources/local/group_user_local_datasource.dart';
import 'package:messenger/features/data/datasources/local/message_local_datasource.dart';
import 'package:messenger/features/data/datasources/local/user_local_datasource.dart';
import 'package:messenger/features/data/datasources/remote/group_message_remote_datasource.dart';
import 'package:messenger/features/data/datasources/remote/group_message_type_remote_datasource.dart';
import 'package:messenger/features/data/datasources/remote/group_remote_datasource.dart';
import 'package:messenger/features/data/datasources/remote/group_user_remote_datasource.dart';
import 'package:messenger/features/data/datasources/remote/message_remote_datasource.dart';
import 'package:messenger/features/data/datasources/remote/user_remote_datasource.dart';
import 'package:messenger/features/data/repositories/group_message_repository_impl.dart';
import 'package:messenger/features/data/repositories/group_message_type_repository_impl.dart';
import 'package:messenger/features/data/repositories/group_repository_impl.dart';
import 'package:messenger/features/data/repositories/group_user_repository_impl.dart';
import 'package:messenger/features/data/repositories/message_repository_impl.dart';
import 'package:messenger/features/data/repositories/user_repository_impl.dart';
import 'package:messenger/features/domain/repositories/group_message_repository.dart';
import 'package:messenger/features/domain/repositories/group_message_type_repository.dart';
import 'package:messenger/features/domain/repositories/group_repository.dart';
import 'package:messenger/features/domain/repositories/group_user_repository.dart';
import 'package:messenger/features/domain/repositories/message_repository.dart';
import 'package:messenger/features/domain/repositories/user_repository.dart';
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
import 'package:messenger/features/domain/usecases/group_message_usecases/exist_group_message_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/get_all_group_messages_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/get_all_group_messages_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/get_all_unsend_group_messages_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/get_group_message_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/get_group_message_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/remove_group_message_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/remove_group_message_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/save_group_message_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/save_group_message_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/update_all_group_messages_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_usecases/get_all_groups_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_usecases/get_all_groups_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_usecases/get_group_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_usecases/get_group_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_usecases/remove_group_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_usecases/save_group_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_usecases/save_group_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/get_all_group_users_by_phone_number_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/get_all_group_users_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/get_all_group_users_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/get_group_user_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/remove_group_user_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/remove_group_user_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/save_group_user_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_user_usecases/save_group_user_remote_usecase.dart';
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
import 'package:messenger/features/domain/usecases/user_usecases/exist_user_local_usecase.dart';
import 'package:messenger/features/domain/usecases/user_usecases/get_all_users_local_usecase.dart';
import 'package:messenger/features/domain/usecases/user_usecases/get_all_users_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/user_usecases/get_user_local_usecase.dart';
import 'package:messenger/features/domain/usecases/user_usecases/get_user_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/user_usecases/remove_user_local_usecase.dart';
import 'package:messenger/features/domain/usecases/user_usecases/save_user_local_usecase.dart';
import 'package:messenger/features/domain/usecases/user_usecases/save_user_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/user_usecases/send_sms_verifycode_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/user_usecases/set_user_lastseen_datetime_remote_usecase.dart';
import 'package:messenger/features/presentation/blocs/shared_cubit/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import 'package:messenger/features/presentation/blocs/shared_cubit/directionality_cubit/directionality_cubit.dart';
import 'package:messenger/features/presentation/blocs/shared_cubit/message_list_cubit/message_list_cubit.dart';
import 'package:messenger/features/presentation/blocs/shared_cubit/message_text_field_cubit/message_text_field_cubit.dart';
import 'package:messenger/features/presentation/blocs/shared_cubit/theme_cubit/theme_cubit.dart';
import 'package:messenger/features/presentation/blocs/user_bloc/user_bloc.dart';


final locator = GetIt.instance;

Future<void> initLocator() async {

  /// Provider
  /// /// Directionality Provider
  locator.registerFactory(
    () => DirectionalityProvider(),
  );

  /// Cubit
  /// /// Theme Cubit
  locator.registerFactory(
    () => ThemeCubit(),
  );
  /// /// Directionality Cubit
  locator.registerFactory(
    () => DirectionalityCubit(),
  );
  /// /// BottomNavigationBar Cubit
  locator.registerFactory(
    () => BottomNavigationBarCubit(),
  );
  /// /// MessageTextField Cubit
  locator.registerFactory(
    () => MessageTextFieldCubit(),
  );
  /// /// MessageList Cubit
  locator.registerFactory(
        () => MessageListCubit(),
  );


  /// Bloc
  /// /// User Bloc
  locator.registerFactory(
    () => UserBloc(
      existUserLocalUseCase: locator(),
      getAllUsersLocalUseCase: locator(),
      getAllUsersRemoteUseCase: locator(),
      getUserLocalUseCase: locator(),
      getUserRemoteUseCase: locator(),
      removeUserLocalUseCase: locator(),
      saveUserLocalUseCase: locator(),
      saveUserRemoteUseCase: locator(),
      sendSMSVerifyCodeRemoteUseCase: locator(),
      setUserLastSeenDateTimeRemoteUseCase: locator(),
    ),
  );
  /// /// Message Bloc
  locator.registerFactory(
    () => MessageBloc(
      existMessageLocalUseCase: locator(),
      getAllMessagesLocalUseCase: locator(),
      getAllMessagesRemoteUseCase: locator(),
      getAllNotReadMessagesLocalUseCase: locator(),
      getAllUnsendMessagesLocalUseCase: locator(),
      getMessageLocalUseCase: locator(),
      getMessageRemoteUseCase: locator(),
      getMissedMessagesRemoteUseCase: locator(),
      removeMessageLocalUseCase: locator(),
      removeMessageRemoteUseCase: locator(),
      saveMessageLocalUseCase: locator(),
      saveMessageRemoteUseCase: locator(),
      updateAllMessagesRemoteUseCase: locator(),
    ),
  );
  /// /// Group Bloc
  locator.registerFactory(
    () => GroupBloc(
      getAllGroupsLocalUseCase: locator(),
      getAllGroupsRemoteUseCase: locator(),
      getGroupLocalUseCase: locator(),
      getGroupRemoteUseCase: locator(),
      removeGroupLocalUseCase: locator(),
      saveGroupLocalUseCase: locator(),
      saveGroupRemoteUseCase: locator(),
    ),
  );
  /// /// GroupUser Bloc
  locator.registerFactory(
    () => GroupUserBloc(
      getAllGroupUsersLocalUseCase: locator(),
      getAllGroupUsersRemoteUseCase: locator(),
      getAllGroupUsersByPhoneNumberRemoteUseCase: locator(),
      getGroupUserLocalUseCase: locator(),
      removeGroupUserLocalUseCase: locator(),
      removeGroupUserRemoteUseCase: locator(),
      saveGroupUserLocalUseCase: locator(),
      saveGroupUserRemoteUseCase: locator(),
    ),
  );
  /// /// GroupMessage Bloc
  locator.registerFactory(
    () => GroupMessageBloc(
      existGroupMessageLocalUseCase: locator(),
      getAllGroupMessagesLocalUseCase: locator(),
      getAllGroupMessagesRemoteUseCase: locator(),
      getAllUnsendGroupMessagesLocalUseCase: locator(),
      getGroupMessageLocalUseCase: locator(),
      getGroupMessageRemoteUseCase: locator(),
      getMissedGroupMessagesRemoteUseCase: locator(),
      removeGroupMessageLocalUseCase: locator(),
      removeGroupMessageRemoteUseCase: locator(),
      saveGroupMessageLocalUseCase: locator(),
      saveGroupMessageRemoteUseCase: locator(),
      updateAllGroupMessagesRemoteUseCase: locator(),
    ),
  );
  /// /// GroupMessageType Bloc
  locator.registerFactory(
    () => GroupMessageTypeBloc(
      existGroupMessageTypeLocalUseCase: locator(),
      getAllGroupMessageTypesLocalUseCase: locator(),
      getAllGroupMessageTypesRemoteUseCase: locator(),
      getAllNotReadGroupMessageTypesLocalUseCase: locator(),
      getAllUnsendGroupMessageTypesLocalUseCase: locator(),
      getGroupMessageTypeLocalUseCase: locator(),
      getGroupMessageTypeRemoteUseCase: locator(),
      removeGroupMessageTypeLocalUseCase: locator(),
      removeGroupMessageTypeRemoteUseCase: locator(),
      saveGroupMessageTypeLocalUseCase: locator(),
      saveGroupMessageTypeRemoteUseCase: locator(),
      updateAllGroupMessageTypesRemoteUseCase: locator(),
    ),
  );
  /// MessageRxDart
  locator.registerFactory(
        () => MessageRxDart(
      existMessageLocalUseCase: locator(),
      getAllMessagesLocalUseCase: locator(),
      getAllMessagesRemoteUseCase: locator(),
      getAllNotReadMessagesLocalUseCase: locator(),
      getAllUnsendMessagesLocalUseCase: locator(),
      getMessageLocalUseCase: locator(),
      getMessageRemoteUseCase: locator(),
      getMissedMessagesRemoteUseCase: locator(),
      removeMessageLocalUseCase: locator(),
      removeMessageRemoteUseCase: locator(),
      saveMessageLocalUseCase: locator(),
      saveMessageRemoteUseCase: locator(),
      updateAllMessagesRemoteUseCase: locator(),
    ),
  );

  /// UseCase
  /// /// User UseCase
  locator.registerLazySingleton<ExistUserLocalUseCase>(() => ExistUserLocalUseCase(locator()));
  locator.registerLazySingleton<GetAllUsersLocalUseCase>(() => GetAllUsersLocalUseCase(locator()));
  locator.registerLazySingleton<GetAllUsersRemoteUseCase>(() => GetAllUsersRemoteUseCase(locator()));
  locator.registerLazySingleton<GetUserLocalUseCase>(() => GetUserLocalUseCase(locator()));
  locator.registerLazySingleton<GetUserRemoteUseCase>(() => GetUserRemoteUseCase(locator()));
  locator.registerLazySingleton<RemoveUserLocalUseCase>(() => RemoveUserLocalUseCase(locator()));
  locator.registerLazySingleton<SaveUserLocalUseCase>(() => SaveUserLocalUseCase(locator()));
  locator.registerLazySingleton<SaveUserRemoteUseCase>(() => SaveUserRemoteUseCase(locator()));
  locator.registerLazySingleton<SendSMSVerifyCodeRemoteUseCase>(() => SendSMSVerifyCodeRemoteUseCase(locator()));
  locator.registerLazySingleton<SetUserLastSeenDateTimeRemoteUseCase>(() => SetUserLastSeenDateTimeRemoteUseCase(locator()));
  /// /// Message UseCase
  locator.registerLazySingleton<ExistMessageLocalUseCase>(() => ExistMessageLocalUseCase(locator()));
  locator.registerLazySingleton<GetAllMessagesLocalUseCase>(() => GetAllMessagesLocalUseCase(locator()));
  locator.registerLazySingleton<GetAllMessagesRemoteUseCase>(() => GetAllMessagesRemoteUseCase(locator()));
  locator.registerLazySingleton<GetAllNotReadMessagesLocalUseCase>(() => GetAllNotReadMessagesLocalUseCase(locator()));
  locator.registerLazySingleton<GetAllUnsendMessagesLocalUseCase>(() => GetAllUnsendMessagesLocalUseCase(locator()));
  locator.registerLazySingleton<GetMessageLocalUseCase>(() => GetMessageLocalUseCase(locator()));
  locator.registerLazySingleton<GetMessageRemoteUseCase>(() => GetMessageRemoteUseCase(locator()));
  locator.registerLazySingleton<RemoveMessageLocalUseCase>(() => RemoveMessageLocalUseCase(locator()));
  locator.registerLazySingleton<RemoveMessageRemoteUseCase>(() => RemoveMessageRemoteUseCase(locator()));
  locator.registerLazySingleton<SaveMessageLocalUseCase>(() => SaveMessageLocalUseCase(locator()));
  locator.registerLazySingleton<SaveMessageRemoteUseCase>(() => SaveMessageRemoteUseCase(locator()));
  locator.registerLazySingleton<UpdateAllMessagesRemoteUseCase>(() => UpdateAllMessagesRemoteUseCase(locator()));
  /// /// Group UseCase
  locator.registerLazySingleton<GetAllGroupsLocalUseCase>(() => GetAllGroupsLocalUseCase(locator()));
  locator.registerLazySingleton<GetAllGroupsRemoteUseCase>(() => GetAllGroupsRemoteUseCase(locator()));
  locator.registerLazySingleton<GetGroupLocalUseCase>(() => GetGroupLocalUseCase(locator()));
  locator.registerLazySingleton<GetGroupRemoteUseCase>(() => GetGroupRemoteUseCase(locator()));
  locator.registerLazySingleton<RemoveGroupLocalUseCase>(() => RemoveGroupLocalUseCase(locator()));
  locator.registerLazySingleton<SaveGroupLocalUseCase>(() => SaveGroupLocalUseCase(locator()));
  locator.registerLazySingleton<SaveGroupRemoteUseCase>(() => SaveGroupRemoteUseCase(locator()));
  /// /// GroupUser UseCase
  locator.registerLazySingleton<GetAllGroupUsersLocalUseCase>(() => GetAllGroupUsersLocalUseCase(locator()));
  locator.registerLazySingleton<GetAllGroupUsersRemoteUseCase>(() => GetAllGroupUsersRemoteUseCase(locator()));
  locator.registerLazySingleton<GetAllGroupUsersByPhoneNumberRemoteUseCase>(() => GetAllGroupUsersByPhoneNumberRemoteUseCase(locator()));
  locator.registerLazySingleton<GetGroupUserLocalUseCase>(() => GetGroupUserLocalUseCase(locator()));
  locator.registerLazySingleton<RemoveGroupUserLocalUseCase>(() => RemoveGroupUserLocalUseCase(locator()));
  locator.registerLazySingleton<RemoveGroupUserRemoteUseCase>(() => RemoveGroupUserRemoteUseCase(locator()));
  locator.registerLazySingleton<SaveGroupUserLocalUseCase>(() => SaveGroupUserLocalUseCase(locator()));
  locator.registerLazySingleton<SaveGroupUserRemoteUseCase>(() => SaveGroupUserRemoteUseCase(locator()));
  /// /// GroupMessage UseCase
  locator.registerLazySingleton<ExistGroupMessageLocalUseCase>(() => ExistGroupMessageLocalUseCase(locator()));
  locator.registerLazySingleton<GetAllGroupMessagesLocalUseCase>(() => GetAllGroupMessagesLocalUseCase(locator()));
  locator.registerLazySingleton<GetAllGroupMessagesRemoteUseCase>(() => GetAllGroupMessagesRemoteUseCase(locator()));
  locator.registerLazySingleton<GetAllUnsendGroupMessagesLocalUseCase>(() => GetAllUnsendGroupMessagesLocalUseCase(locator()));
  locator.registerLazySingleton<GetGroupMessageLocalUseCase>(() => GetGroupMessageLocalUseCase(locator()));
  locator.registerLazySingleton<GetGroupMessageRemoteUseCase>(() => GetGroupMessageRemoteUseCase(locator()));
  locator.registerLazySingleton<GetMissedMessagesRemoteUseCase>(() => GetMissedMessagesRemoteUseCase(locator()));
  locator.registerLazySingleton<RemoveGroupMessageLocalUseCase>(() => RemoveGroupMessageLocalUseCase(locator()));
  locator.registerLazySingleton<RemoveGroupMessageRemoteUseCase>(() => RemoveGroupMessageRemoteUseCase(locator()));
  locator.registerLazySingleton<SaveGroupMessageLocalUseCase>(() => SaveGroupMessageLocalUseCase(locator()));
  locator.registerLazySingleton<SaveGroupMessageRemoteUseCase>(() => SaveGroupMessageRemoteUseCase(locator()));
  locator.registerLazySingleton<UpdateAllGroupMessagesRemoteUseCase>(() => UpdateAllGroupMessagesRemoteUseCase(locator()));
  /// /// GroupMessageType UseCase
  locator.registerLazySingleton<ExistGroupMessageTypeLocalUseCase>(() => ExistGroupMessageTypeLocalUseCase(locator()));
  locator.registerLazySingleton<GetAllGroupMessageTypesLocalUseCase>(() => GetAllGroupMessageTypesLocalUseCase(locator()));
  locator.registerLazySingleton<GetAllGroupMessageTypesRemoteUseCase>(() => GetAllGroupMessageTypesRemoteUseCase(locator()));
  locator.registerLazySingleton<GetAllNotReadGroupMessageTypesLocalUseCase>(() => GetAllNotReadGroupMessageTypesLocalUseCase(locator()));
  locator.registerLazySingleton<GetAllUnsendGroupMessageTypesLocalUseCase>(() => GetAllUnsendGroupMessageTypesLocalUseCase(locator()));
  locator.registerLazySingleton<GetGroupMessageTypeLocalUseCase>(() => GetGroupMessageTypeLocalUseCase(locator()));
  locator.registerLazySingleton<GetGroupMessageTypeRemoteUseCase>(() => GetGroupMessageTypeRemoteUseCase(locator()));
  locator.registerLazySingleton<RemoveGroupMessageTypeLocalUseCase>(() => RemoveGroupMessageTypeLocalUseCase(locator()));
  locator.registerLazySingleton<RemoveGroupMessageTypeRemoteUseCase>(() => RemoveGroupMessageTypeRemoteUseCase(locator()));
  locator.registerLazySingleton<SaveGroupMessageTypeLocalUseCase>(() => SaveGroupMessageTypeLocalUseCase(locator()));
  locator.registerLazySingleton<SaveGroupMessageTypeRemoteUseCase>(() => SaveGroupMessageTypeRemoteUseCase(locator()));
  locator.registerLazySingleton<UpdateAllGroupMessageTypesRemoteUseCase>(() => UpdateAllGroupMessageTypesRemoteUseCase(locator()));

  /// Repositories
  /// /// User Repository
  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      userLocalDataSource: locator(),
      userRemoteDataSource: locator(),
      networkInfo: locator(),
    ),
  );
  /// /// Message Repository
  locator.registerLazySingleton<MessageRepository>(() => MessageRepositoryImpl(
      messageLocalDataSource: locator(),
      messageRemoteDataSource: locator(),
      networkInfo: locator(),
    ),
  );
  /// /// Group Repository
  locator.registerLazySingleton<GroupRepository>(() => GroupRepositoryImpl(
      groupLocalDataSource: locator(),
      groupRemoteDataSource: locator(),
      networkInfo: locator(),
    ),
  );
  /// /// GroupUser Repository
  locator.registerLazySingleton<GroupUserRepository>(() => GroupUserRepositoryImpl(
      groupUserLocalDataSource: locator(),
      groupUserRemoteDataSource: locator(),
      networkInfo: locator(),
    ),
  );
  /// /// GroupMessage Repository
  locator.registerLazySingleton<GroupMessageRepository>(() => GroupMessageRepositoryImpl(
      groupMessageLocalDataSource: locator(),
      groupMessageRemoteDataSource: locator(),
      networkInfo: locator(),
    ),
  );
  /// /// GroupMessageType Repository
  locator.registerLazySingleton<GroupMessageTypeRepository>(() => GroupMessageTypeRepositoryImpl(
      groupMessageTypeLocalDataSource: locator(),
      groupMessageTypeRemoteDataSource: locator(),
      networkInfo: locator(),
    ),
  );


  /// DataSources
  /// /// User DataSource
  locator.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSource(locator()));
  locator.registerLazySingleton<UserLocalDataSource>(() => UserLocalDataSourceImpl(locator()));
  /// /// Message DataSource
  locator.registerLazySingleton<MessageRemoteDataSource>(() => MessageRemoteDataSourceImpl(dio: locator()));
  locator.registerLazySingleton<MessageLocalDataSource>(() => MessageLocalDataSourceImpl(locator()));
  /// /// Group DataSource
  locator.registerLazySingleton<GroupRemoteDataSource>(() => GroupRemoteDataSourceImpl(dio: locator()));
  locator.registerLazySingleton<GroupLocalDataSource>(() => GroupLocalDataSourceImpl(locator()));
  /// /// GroupUser DataSource
  locator.registerLazySingleton<GroupUserRemoteDataSource>(() => GroupUserRemoteDataSourceImpl(dio: locator()));
  locator.registerLazySingleton<GroupUserLocalDataSource>(() => GroupUserLocalDataSourceImpl(locator()));
  /// /// GroupMessage DataSource
  locator.registerLazySingleton<GroupMessageRemoteDataSource>(() => GroupMessageRemoteDataSourceImpl(dio: locator()));
  locator.registerLazySingleton<GroupMessageLocalDataSource>(() => GroupMessageLocalDataSourceImpl(locator()));
  /// /// GroupMessageType DataSource
  locator.registerLazySingleton<GroupMessageTypeRemoteDataSource>(() => GroupMessageTypeRemoteDataSourceImpl(dio: locator()));
  locator.registerLazySingleton<GroupMessageTypeLocalDataSource>(() => GroupMessageTypeLocalDataSourceImpl(locator()));

  /// Database
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());


  ///! Core
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));
  locator.registerLazySingleton(() => Constants());
  locator.registerLazySingleton(() => DateConverter());

  ///! External
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker.createInstance());

  /// Rest Client
  locator.registerLazySingleton<Dio>(() => Dio());

}
