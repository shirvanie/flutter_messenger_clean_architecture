


class Constants{

  /// Fonts
  static const String appFontHelvetica = "Helvetica";
  static const String appFontHelveticaBold = "HelveticaBold";
  static const String appFontLucidaGrande = "LucidaGrande";
  static const String appFontLucidaGrandeBold = "LucidaGrandeBold";

  /// Api
  static const String baseUrl = "https://yourdomain.ir";
  /// Users API
  static const String getAllUsersApiUrl = "$baseUrl/api/GetAllUsers";
  static const String getUserApiUrl = "$baseUrl/api/GetUser";
  static const String setUserLastSeenDateTimeApiUrl = "$baseUrl/api/UserLastSeenDateTime";
  static const String saveUserApiUrl = "$baseUrl/api/Users/SaveUser";
  static const String sendSMSVerifyCodeApiUrl = "https://sms.com/send/verify";
  /// Messages API
  static const String getAllMessagesApiUrl = "$baseUrl/api/GetAllMessages";
  static const String removeMessageApiUrl = "$baseUrl/api/RemoveMessage";
  static const String getMessageApiUrl = "$baseUrl/api/GetMessage";
  static const String getMissedMessagesApiUrl = "$baseUrl/api/GetMissedMessages";
  static const String saveMessageApiUrl = "$baseUrl/api/SaveMessage";
  static const String updateAllMessagesApiUrl = "$baseUrl/api/UpdateAllMessage";
  /// Groups API
  static const String getAllGroupsApiUrl = "$baseUrl/api/GetAllGroups";
  static const String getGroupApiUrl = "$baseUrl/api/GetGroup";
  static const String saveGroupApiUrl = "$baseUrl/api/SaveGroup";
  /// GroupUsers API
  static const String getAllGroupUsersApiUrl = "$baseUrl/api/GetAllGroupUsers";
  static const String getAllGroupUsersByPhoneNumberApiUrl = "$baseUrl/api/GetAllGroupUsersByPhoneNumber";
  static const String saveGroupUserApiUrl = "$baseUrl/api/SaveGroupUser";
  static const String removeGroupUserApiUrl = "$baseUrl/api/RemoveGroupUser";
  /// GroupMessages API
  static const String getAllGroupMessagesApiUrl = "$baseUrl/api/GetAllGroupMessages";
  static const String removeGroupMessageApiUrl = "$baseUrl/api/RemoveGroupMessage";
  static const String getGroupMessageApiUrl = "$baseUrl/api/GetGroupMessage";
  static const String getMissedGroupMessagesApiUrl = "$baseUrl/api/GetMissedGroupMessages";
  static const String saveGroupMessageApiUrl = "$baseUrl/api/SaveGroupMessage";
  static const String updateAllGroupMessagesApiUrl = "$baseUrl/api/UpdateAllGroupMessage";
  /// GroupMessageTypes API
  static const String getAllGroupMessageTypesApiUrl = "$baseUrl/api/GetAllGroupMessageTypes";
  static const String removeGroupMessageTypeApiUrl = "$baseUrl/api/RemoveGroupMessageType";
  static const String getGroupMessageTypeApiUrl = "$baseUrl/api/GetGroupMessageType";
  static const String saveGroupMessageTypeApiUrl = "$baseUrl/api/SaveGroupMessageType";
  static const String updateAllGroupMessageTypesApiUrl = "$baseUrl/api/UpdateAllGroupMessageType";
  /// Failures message
  static const String databaseFailureMessage = 'Database Failure';
  static const String serverFailureMessage = 'Server Failure';
  static const String connectionFailureMessage = 'Connection Failure';
}

class MessageTypeModel {
  static const String sending = "sending";
  static const String send = "send";
  static const String sent = "sent";
  static const String received = "received";
}

class MessageCategoryModel {
  static const String text = "text";
  static const String image = "image";
  static const String video = "video";
}
