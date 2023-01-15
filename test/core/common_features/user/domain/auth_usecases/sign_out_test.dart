import 'package:chatcalling/core/common_features/user/domain/usecases/auth_usecases/sign_out.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockAuthRepository repository;
  late SignOut usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = SignOut(repository);
  });

  test('Should send sign out request to repository', () async {
    // Arrange
    when(repository.signOut()).thenAnswer((_) async => Right('success'));
    // Act
    final result = await usecase();
    // Assert
    verify(repository.signOut());
    expect(result, Right('success'));
  });
}
