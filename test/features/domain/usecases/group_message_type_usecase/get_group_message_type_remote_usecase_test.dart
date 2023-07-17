


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_message_type_model.dart';
import 'package:messenger/features/domain/usecases/group_message_type_usecases/get_group_message_type_remote_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupMessageTypeRepository mockGroupMessageTypeRepository;
  late GetGroupMessageTypeRemoteUseCase getGroupMessageTypeRemoteUseCase;

  final testJson = fixtureReader("group_message_type_model.json");
  final testGroupMessageTypeModel = GroupMessageTypeModel.fromJson(json.decode(testJson));
  String messageId = testGroupMessageTypeModel.messageId.toString();

  setUp(() {
    mockGroupMessageTypeRepository = MockGroupMessageTypeRepository();
    getGroupMessageTypeRemoteUseCase = GetGroupMessageTypeRemoteUseCase(mockGroupMessageTypeRepository);
  });


  test("should return a GroupMessageType model when call getGroupMessageTypeRemote from the repository", () async{
    //arrange
    when(mockGroupMessageTypeRepository.getGroupMessageTypeRemote(any))
        .thenAnswer((_) async => Right(testGroupMessageTypeModel));
    //actual
    final result = await getGroupMessageTypeRemoteUseCase(ParamsGetGroupMessageTypeRemoteUseCase(messageId: messageId));
    verify(mockGroupMessageTypeRepository.getGroupMessageTypeRemote(messageId));
    expect(result, Right(testGroupMessageTypeModel));
  });
}

