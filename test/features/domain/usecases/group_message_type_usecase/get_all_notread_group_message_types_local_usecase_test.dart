
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_message_type_model.dart';
import 'package:messenger/features/domain/usecases/group_message_type_usecases/get_all_notread_group_message_types_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupMessageTypeRepository mockGroupMessageTypeRepository;
  late GetAllNotReadGroupMessageTypesLocalUseCase getAllNotReadGroupMessageTypesLocalUseCase;

  final testJson = fixtureReader("group_message_type_model.json");
  final testGroupMessageTypeModel = GroupMessageTypeModel.fromJson(json.decode(testJson));
  String groupId = testGroupMessageTypeModel.groupId.toString();

  setUp(() {
    mockGroupMessageTypeRepository = MockGroupMessageTypeRepository();
    getAllNotReadGroupMessageTypesLocalUseCase = GetAllNotReadGroupMessageTypesLocalUseCase(mockGroupMessageTypeRepository);
  });


  test("should return all not-read GroupMessageTypes when call getAllNotReadGroupMessageTypesLocal from the repository", () async{
    //arrange
    when(mockGroupMessageTypeRepository.getAllNotReadGroupMessageTypesLocal(groupId))
        .thenAnswer((_) async => Right([testGroupMessageTypeModel]));
    //actual
    final result = await getAllNotReadGroupMessageTypesLocalUseCase(ParamsGetAllNotReadGroupMessageTypesLocalUseCase(groupId: groupId));
    verify(mockGroupMessageTypeRepository.getAllNotReadGroupMessageTypesLocal(groupId));
    expect(result.getOrElse(() => []), [testGroupMessageTypeModel]);
  });
}