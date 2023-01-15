import 'package:chatcalling/core/common_features/user/domain/usecases/auth_usecases/sign_up_with_email.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/fixtures/personal_information_dummy.dart';
import '../../../../../helpers/fixtures/user_dummy.dart';
import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockAuthRepository repository;
  late SignUpWithEmail usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = SignUpWithEmail(repository);
  });

  test('Should send sign up with email request to repository', () async {
    // Arrange
    when(repository.signUpWithEmail(any, any, any))
        .thenAnswer((_) async => Right('success'));
    // Act
    final result = await usecase(
        user: tUser,
        personalInformation: tPersonalInformation,
        password: 'password');
    // Assert
    verify(repository.signUpWithEmail(tUser, tPersonalInformation, 'password'));
    expect(result, Right('success'));
  });
}
