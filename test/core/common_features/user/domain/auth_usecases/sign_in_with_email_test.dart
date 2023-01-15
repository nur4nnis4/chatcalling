import 'package:chatcalling/core/common_features/user/domain/usecases/auth_usecases/sign_in_with_email.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockAuthRepository repository;
  late SignInWithEmail usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = SignInWithEmail(repository);
  });

  test('Should send sign in with email request to repository', () async {
    // Arrange
    when(repository.signInWithEmail(any, any))
        .thenAnswer((_) async => Right('success'));
    // Act
    final result = await usecase(email: 'email', password: 'password');
    // Assert
    verify(repository.signInWithEmail('email', 'password'));
    expect(result, Right('success'));
  });
}
