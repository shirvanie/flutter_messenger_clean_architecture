
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:messenger/core/networks/network_info.dart';
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
import 'package:messenger/features/domain/usecases/group_message_usecases/get_missed_group_messages_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/remove_group_message_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/remove_group_message_remote_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/save_group_message_local_usecase.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/save_group_message_remote_usecase.dart';
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

@GenerateMocks([
  /// data/datasources
  Dio,
  DatabaseHelper,
  SharedPreferences,
  /// data/datasources
  UserLocalDataSource,
  UserRemoteDataSource,
  MessageLocalDataSource,
  MessageRemoteDataSource,
  GroupLocalDataSource,
  GroupRemoteDataSource,
  GroupUserLocalDataSource,
  GroupUserRemoteDataSource,
  GroupMessageLocalDataSource,
  GroupMessageRemoteDataSource,
  GroupMessageTypeLocalDataSource,
  GroupMessageTypeRemoteDataSource,
  // SharedLocalDataSource,
  NetworkInfo,
  /// domain/repositories
  UserRepository,
  MessageRepository,
  GroupRepository,
  GroupUserRepository,
  GroupMessageRepository,
  GroupMessageTypeRepository,
  // SharedRepository,
  /// presentation/bloc/user_bloc
  ExistUserLocalUseCase,
  GetAllUsersLocalUseCase,
  GetAllUsersRemoteUseCase,
  GetUserLocalUseCase,
  GetUserRemoteUseCase,
  RemoveUserLocalUseCase,
  SaveUserLocalUseCase,
  SaveUserRemoteUseCase,
  SendSMSVerifyCodeRemoteUseCase,
  SetUserLastSeenDateTimeRemoteUseCase,
  /// presentation/bloc/message_bloc
  ExistMessageLocalUseCase,
  GetAllMessagesLocalUseCase,
  GetAllMessagesRemoteUseCase,
  GetAllNotReadMessagesLocalUseCase,
  GetAllUnsendMessagesLocalUseCase,
  GetMessageLocalUseCase,
  GetMessageRemoteUseCase,
  GetMissedMessagesRemoteUseCase,
  RemoveMessageLocalUseCase,
  RemoveMessageRemoteUseCase,
  SaveMessageLocalUseCase,
  SaveMessageRemoteUseCase,
  UpdateAllMessagesRemoteUseCase,
  /// presentation/bloc/group_bloc
  GetAllGroupsLocalUseCase,
  GetAllGroupsRemoteUseCase,
  GetGroupLocalUseCase,
  GetGroupRemoteUseCase,
  RemoveGroupLocalUseCase,
  SaveGroupLocalUseCase,
  SaveGroupRemoteUseCase,
  /// presentation/bloc/group_user_bloc
  GetAllGroupUsersByPhoneNumberRemoteUseCase,
  GetAllGroupUsersLocalUseCase,
  GetAllGroupUsersRemoteUseCase,
  GetGroupUserLocalUseCase,
  RemoveGroupUserLocalUseCase,
  RemoveGroupUserRemoteUseCase,
  SaveGroupUserLocalUseCase,
  SaveGroupUserRemoteUseCase,
  /// presentation/bloc/group_message_bloc
  ExistGroupMessageLocalUseCase,
  GetAllGroupMessagesLocalUseCase,
  GetAllGroupMessagesRemoteUseCase,
  GetAllUnsendGroupMessagesLocalUseCase,
  GetGroupMessageLocalUseCase,
  GetGroupMessageRemoteUseCase,
  GetMissedGroupMessagesRemoteUseCase,
  RemoveGroupMessageLocalUseCase,
  RemoveGroupMessageRemoteUseCase,
  SaveGroupMessageLocalUseCase,
  SaveGroupMessageRemoteUseCase,
  UpdateAllGroupMessagesRemoteUseCase,
  /// presentation/bloc/group_message_type_bloc
  ExistGroupMessageTypeLocalUseCase,
  GetAllGroupMessageTypesLocalUseCase,
  GetAllGroupMessageTypesRemoteUseCase,
  GetAllNotReadGroupMessageTypesLocalUseCase,
  GetAllUnsendGroupMessageTypesLocalUseCase,
  GetGroupMessageTypeLocalUseCase,
  GetGroupMessageTypeRemoteUseCase,
  RemoveGroupMessageTypeLocalUseCase,
  RemoveGroupMessageTypeRemoteUseCase,
  SaveGroupMessageTypeLocalUseCase,
  SaveGroupMessageTypeRemoteUseCase,
  UpdateAllGroupMessageTypesRemoteUseCase,
  // /// presentation/bloc/shared_cubit/directionality_cubit
  // GetDirectionalitySharedUseCase,
  // SaveDirectionalitySharedUseCase,
  // /// presentation/bloc/shared_cubit/theme_cubit
  // GetThemeSharedUseCase,
  // SaveThemeSharedUseCase
  ///
], customMocks: [
  // MockSpec<Cat>(as: #MockCat)
],)
void main() {}