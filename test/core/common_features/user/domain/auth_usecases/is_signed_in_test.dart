import 'package:chatcalling/core/common_features/user/domain/usecases/auth_usecases/is_signed_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockAuthRepository repository;
  late IsSignedIn usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = IsSignedIn(repository);
  });

  test('Should get currest user log in status from the repository', () async {
    // Arrange
    when(repository.isSignedIn()).thenAnswer((_) async* {
      yield true;
    });
    // Act
    final actual = await usecase().first;
    // Assert
    verify(repository.isSignedIn());
    expect(actual, true);
  });
}
