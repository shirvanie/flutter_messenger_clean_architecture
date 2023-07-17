

import 'package:dio/dio.dart' hide Headers;
import 'package:messenger/features/data/models/sms_model.dart';
import 'package:retrofit/http.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/features/data/models/user_model.dart';

part 'user_remote_datasource.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class UserRemoteDataSource {
  factory UserRemoteDataSource(Dio dio,
      {String baseUrl}) = _UserRemoteDataSource;

  @GET(Constants.getAllUsersApiUrl)
  @Headers({"Content-Type": "application/json"})
  Future<List<UserModel>> getAllUsersRemote();

  @POST(Constants.getUserApiUrl)
  @Headers({"Content-Type": "application/json"})
  Future<UserModel> getUserRemote(@Field() String userPhoneNumber);

  @POST(Constants.saveUserApiUrl)
  @Headers({"Content-Type": "application/json"})
  Future<bool> saveUserRemote(@Body() UserModel userItem);

  @POST(Constants.setUserLastSeenDateTimeApiUrl)
  @Headers({"Content-Type": "application/json"})
  Future<bool> setUserLastSeenDateTimeRemote(@Field() String userPhoneNumber,
      @Field() String lastSeenDateTime);

  @POST(Constants.sendSMSVerifyCodeApiUrl)
  @Headers({
    "Content-Type": "application/json",
    "ACCEPT": "application/json",
  })
  Future<bool> sendSMSVerifyCodeRemote(@Body() SMSModel smsItem);
}