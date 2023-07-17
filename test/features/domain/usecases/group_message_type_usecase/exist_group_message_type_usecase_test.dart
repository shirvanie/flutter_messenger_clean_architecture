


import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_message_type_model.dart';
import 'package:messenger/features/domain/usecases/group_message_type_usecases/exist_group_message_type_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupMessageTypeRepository mockGroupMessageTypeRepository;
  late ExistGroupMessageTypeLocalUseCase existGroupMessageTypeLocalUseCase;

  final testJson = fixtureReader("group_message_type_model.json");
  final testGroupMessageTypeModel = GroupMessageTypeModel.fromJson(json.decode(testJson));
  String messageId = testGroupMessageTypeModel.messageId.toString();

  setUp(() {
    mockGroupMessageTypeRepository = MockGroupMessageTypeRepository();
    existGroupMessageTypeLocalUseCase = ExistGroupMessageTypeLocalUseCase(mockGroupMessageTypeRepository);
  });


  test("should return true when call existGroupMessageTypeLocal from the repository", () async{
    //arrange
    when(mockGroupMessageTypeRepository.existGroupMessageTypeLocal(any))
        .thenAnswer((_) async => const Right(true));
    //actual
    final result = await existGroupMessageTypeLocalUseCase(ParamsExistGroupMessageTypeLocalUseCase(messageId: messageId));
    verify(mockGroupMessageTypeRepository.existGroupMessageTypeLocal(messageId));
    expect(result, const Right(true));
  });
}

