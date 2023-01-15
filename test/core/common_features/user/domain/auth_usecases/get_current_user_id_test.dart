import 'package:chatcalling/core/common_features/user/domain/usecases/auth_usecases/get_current_user_id.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockAuthRepository repository;
  late GetCurrentUserId usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = GetCurrentUserId(repository);
  });

  test('Should get current user id from repository', () async {
    // Arrange
    when(repository.getCurrentUserId()).thenAnswer((_) async => 'userId');
    // Act
    final actual = await usecase();
    // Assert
    verify(repository.getCurrentUserId());
    expect(actual, 'userId');
  });
}
