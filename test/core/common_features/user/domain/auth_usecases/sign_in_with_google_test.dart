import 'package:chatcalling/core/common_features/user/domain/usecases/auth_usecases/sign_in_with_google.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockAuthRepository repository;
  late SignInWithGoogle usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = SignInWithGoogle(repository);
  });

  test('Should send sign in with google request to repository', () async {
    // Arrange
    when(repository.signInWithGoogle())
        .thenAnswer((_) async => Right('success'));
    // Act
    final result = await usecase();
    // Assert
    verify(repository.signInWithGoogle());
    expect(result, Right('success'));
  });
}
