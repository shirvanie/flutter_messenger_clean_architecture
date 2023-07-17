
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_message_model.dart';
import 'package:messenger/features/domain/usecases/group_message_usecases/get_missed_group_messages_remote_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupMessageRepository mockGroupMessageRepository;
  late GetMissedGroupMessagesRemoteUseCase getMissedGroupMessagesRemoteUseCase;

  final testJson = fixtureReader("group_message_model.json");
  final testGroupMessageModel = GroupMessageModel.fromJson(json.decode(testJson));
  final groupId = testGroupMessageModel.groupId.toString();
  final receiverPhoneNumber = testGroupMessageModel.senderPhoneNumber.toString();

  setUp(() {
    mockGroupMessageRepository = MockGroupMessageRepository();
    getMissedGroupMessagesRemoteUseCase = GetMissedGroupMessagesRemoteUseCase(mockGroupMessageRepository);
  });


  test("should return missed GroupMessages when call getMissedGroupMessagesRemote from the repository", () async{
    //arrange
    when(mockGroupMessageRepository.getMissedGroupMessagesRemote(groupId, receiverPhoneNumber))
        .thenAnswer((_) async => Right([testGroupMessageModel]));
    //actual
    final result = await getMissedGroupMessagesRemoteUseCase(ParamsGetMissedGroupMessagesRemoteUseCase(groupId: groupId, receiverPhoneNumber: receiverPhoneNumber));
    verify(mockGroupMessageRepository.getMissedGroupMessagesRemote(groupId, receiverPhoneNumber));
    expect(result.getOrElse(() => []), [testGroupMessageModel]);
  });
}