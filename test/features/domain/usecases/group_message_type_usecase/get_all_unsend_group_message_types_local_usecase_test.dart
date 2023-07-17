
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:messenger/features/data/models/group_message_type_model.dart';
import 'package:messenger/features/domain/usecases/group_message_type_usecases/get_all_unsend_group_message_types_local_usecase.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGroupMessageTypeRepository mockGroupMessageTypeRepository;
  late GetAllUnsendGroupMessageTypesLocalUseCase getAllUnsendGroupMessageTypesLocalUseCase;

  final testJson = fixtureReader("group_message_type_model.json");
  final testGroupMessageTypeModel = GroupMessageTypeModel.fromJson(json.decode(testJson));
  final receiverPhoneNumber = testGroupMessageTypeModel.receiverPhoneNumber.toString();

  setUp(() {
    mockGroupMessageTypeRepository = MockGroupMessageTypeRepository();
    getAllUnsendGroupMessageTypesLocalUseCase = GetAllUnsendGroupMessageTypesLocalUseCase(mockGroupMessageTypeRepository);
  });


  test("should return all unsend GroupMessageTypes when call getAllUnsendGroupMessageTypesLocal from the repository", () async{
    //arrange
    when(mockGroupMessageTypeRepository.getAllUnsendGroupMessageTypesLocal(receiverPhoneNumber))
        .thenAnswer((_) async => Right([testGroupMessageTypeModel]));
    //actual
    final result = await getAllUnsendGroupMessageTypesLocalUseCase(ParamsGetAllUnsendGroupMessageTypesLocalUseCase(receiverPhoneNumber: receiverPhoneNumber));
    verify(mockGroupMessageTypeRepository.getAllUnsendGroupMessageTypesLocal(receiverPhoneNumber));
    expect(result.getOrElse(() => []), [testGroupMessageTypeModel]);
  });
}