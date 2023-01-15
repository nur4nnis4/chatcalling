import 'package:chatcalling/core/common_features/user/presentation/utils/form_validator.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FormValidatorImpl formValidator;
  setUp(
    () => formValidator = FormValidatorImpl(),
  );

  group('Username Validator :', () {
    test('Should return true when username is valid', () async {
      // Act
      final result1 = formValidator.validate(username: 'valid_user1');
      final result2 = formValidator.validate(username: 'validUser5');
      final result3 = formValidator.validate(username: 'validuser1_');
      // Assert
      expect(result1, Right(true));
      expect(result2, Right(true));
      expect(result3, Right(true));
    });
    test('Should return Failure when username is empty', () async {
      // Act
      final result = formValidator.validate(username: '');
      // Assert
      expect(result, Left(InvalidInputFailure('Please input a username')));
    });
    test(
        'Should return Failure when username contains non-alphanumeric charcters other than underscore',
        () async {
      // Act
      final result = formValidator.validate(username: 'nonalph@numeric');
      // Assert
      expect(
          result,
          Left(InvalidInputFailure(
              'Invalid username, only alphanumeric and underscore allowed')));
    });
    test('Should return Failure when username starts with underscore',
        () async {
      // Act
      final result = formValidator.validate(username: '_user');
      // Assert
      expect(
          result,
          Left(InvalidInputFailure(
              'Username should not start with underscore')));
    });
    test('Should return Failure when username is more than 30 characters',
        () async {
      // Act
      final result =
          formValidator.validate(username: '1234567890123456789012345678901');
      // Assert
      expect(
          result,
          Left(InvalidInputFailure(
              'Username should not be more than 30 characters')));
    });
  });

  group('Display name validator', () {
    test('Should return true when display name is valid', () async {
      // Act
      final result1 = formValidator.validate(displayName: 'd1sPl4yn@me');
      final result2 = formValidator.validate(displayName: 'displayname');
      final result3 = formValidator.validate(displayName: 'Display Name');
      // Assert
      expect(result1, Right(true));
      expect(result2, Right(true));
      expect(result3, Right(true));
    });
    test('Should return Failure when display name is empty', () async {
      // Act
      final result = formValidator.validate(displayName: '');
      // Assert
      expect(result, Left(InvalidInputFailure('Please input a display name')));
    });
    test('Should return Failure when display name is more than 30 characters',
        () async {
      // Act
      final result = formValidator.validate(
          displayName: '1234567890123456789012345678901');
      // Assert
      expect(
          result,
          Left(InvalidInputFailure(
              'Display name should not be more than 30 characters')));
    });
  });

  group('Email validator', () {
    test('Should return true when email is valid', () async {
      // Act
      final result1 = formValidator.validate(email: 'validemail@gmail.com');
      final result2 = formValidator.validate(email: 'valid_email@random.com');
      final result3 = formValidator.validate(email: 'valid.email@yahoo.com');
      // Assert
      expect(result1, Right(true));
      expect(result2, Right(true));
      expect(result3, Right(true));
    });

    test('Should return Failure when email is invalid', () async {
      // Act
      final result1 = formValidator.validate(email: 'invalidemail@gmail');
      final result2 = formValidator.validate(email: 'invali.1ds@gmail');
      final result3 = formValidator.validate(email: 'invalid@email@gmail.com');
      final result4 = formValidator.validate(email: 'invalide#mail@gmail.com');
      // Assert
      expect(result1,
          Left(InvalidInputFailure('Please input a valid email address')));
      expect(result2,
          Left(InvalidInputFailure('Please input a valid email address')));
      expect(result3,
          Left(InvalidInputFailure('Please input a valid email address')));
      expect(result4,
          Left(InvalidInputFailure('Please input a valid email address')));
    });
  });

  group('Password validator', () {
    test('Should return true when password is valid', () async {
      // Act
      final result1 = formValidator.validate(password: 'd1sPl4yn@me');
      final result2 = formValidator.validate(password: 'displayname');
      final result3 = formValidator.validate(password: 'Display Name');
      // Assert
      expect(result1, Right(true));
      expect(result2, Right(true));
      expect(result3, Right(true));
    });
    test('Should return failure when password is less than 8 characters',
        () async {
      // Act
      final result1 = formValidator.validate(password: '1234567');
      // Assert
      expect(
          result1,
          Left(InvalidInputFailure(
              'Password should contain at least 8 characters')));
    });
  });
}
