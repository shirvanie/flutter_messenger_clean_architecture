import 'package:flutter_test/flutter_test.dart';
import 'package:messenger/core/errors/failures.dart';

void main() {
  final testProps = [];

  group('Failures', () {
    test(
      'make sure the props value is [errorMessage]',
          () async {
        // assert
        expect(ServerFailure().properties, testProps);
      },
    );
  });

  group('ServerFailure', () {
    test(
      'make sure the props value is [errorMessage]',
          () async {
        // assert
        expect(ServerFailure().properties, testProps);
      },
    );
  });

}