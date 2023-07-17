
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_message_type_model.dart';
import 'package:messenger/features/domain/usecases/group_message_type_usecases/get_all_group_message_types_remote_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupMessageTypeRepository mockGroupMessageTypeRepository;
  late GetAllGroupMessageTypesRemoteUseCase getAllGroupMessageTypesRemoteUseCase;

  final testJson = fixtureReader("group_message_type_model.json");
  final testGroupMessageTypeModel = GroupMessageTypeModel.fromJson(json.decode(testJson));
  String groupId = testGroupMessageTypeModel.groupId.toString();
  String messageId = testGroupMessageTypeModel.messageId.toString();

  setUp(() {
    mockGroupMessageTypeRepository = MockGroupMessageTypeRepository();
    getAllGroupMessageTypesRemoteUseCase = GetAllGroupMessageTypesRemoteUseCase(mockGroupMessageTypeRepository);
  });


  test("should return all GroupMessageTypes when call getAllGroupMessageTypesRemote from the repository", () async{
    //arrange
    when(mockGroupMessageTypeRepository.getAllGroupMessageTypesRemote(groupId, messageId))
        .thenAnswer((_) async => Right([testGroupMessageTypeModel]));
    //actual
    final result = await getAllGroupMessageTypesRemoteUseCase(ParamsGetAllGroupMessageTypesRemoteUseCase(groupId: groupId, messageId: messageId));
    verify(mockGroupMessageTypeRepository.getAllGroupMessageTypesRemote(groupId, messageId));
    expect(result.getOrElse(() => []), [testGroupMessageTypeModel]);
  });
}