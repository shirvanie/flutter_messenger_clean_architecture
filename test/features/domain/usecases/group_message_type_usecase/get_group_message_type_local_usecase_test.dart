


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_message_type_model.dart';
import 'package:messenger/features/domain/usecases/group_message_type_usecases/get_group_message_type_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupMessageTypeRepository mockGroupMessageTypeRepository;
  late GetGroupMessageTypeLocalUseCase getGroupMessageTypeLocalUseCase;

  final testJson = fixtureReader("group_message_type_model.json");
  final testGroupMessageTypeModel = GroupMessageTypeModel.fromJson(json.decode(testJson));
  String messageId = testGroupMessageTypeModel.messageId.toString();

  setUp(() {
    mockGroupMessageTypeRepository = MockGroupMessageTypeRepository();
    getGroupMessageTypeLocalUseCase = GetGroupMessageTypeLocalUseCase(mockGroupMessageTypeRepository);
  });


  test("should return a GroupMessageType model when call getGroupMessageTypeLocal from the repository", () async{
    //arrange
    when(mockGroupMessageTypeRepository.getGroupMessageTypeLocal(any))
        .thenAnswer((_) async => Right(testGroupMessageTypeModel));
    //actual
    final result = await getGroupMessageTypeLocalUseCase(ParamsGetGroupMessageTypeLocalUseCase(messageId: messageId));
    verify(mockGroupMessageTypeRepository.getGroupMessageTypeLocal(messageId));
    expect(result, Right(testGroupMessageTypeModel));
  });
}

