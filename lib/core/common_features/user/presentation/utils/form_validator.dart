import 'package:chatcalling/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class FormValidator {
  Either<Failure, bool> validate(
      {String? username,
      String? displayName,
      String? email,
      String? password,
      String? phoneNumber});
}

class FormValidatorImpl implements FormValidator {
  @override
  Either<Failure, bool> validate(
      {String? username,
      String? displayName,
      String? email,
      String? password,
      String? phoneNumber}) {
    try {
      // Validate Username
      if (username != null) {
        if (username.isEmpty) throw FormatException('Please input a username');
        if (username.contains(RegExp(r'[^\w_]')))
          throw FormatException(
              'Invalid username, only alphanumeric and underscore allowed');
        if (username.startsWith('_'))
          throw FormatException('Username should not start with underscore');
        if (username.length > 30)
          throw FormatException(
              'Username should not be more than 30 characters');
      }

      // Validate displayName
      if (displayName != null) {
        if (displayName.isEmpty)
          throw FormatException('Please input a display name');
        if (displayName.length > 30)
          throw FormatException(
              'Display name should not be more than 30 characters');
      }

      // Validate email

      if (email != null) {
        if (email.isEmpty) throw FormatException('Please input an email.');
        if (!email.contains(RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')))
          throw FormatException('Please input a valid email address');
      }

      //Validate password

      if (password != null) {
        if (password.length < 8)
          throw FormatException(
              'Password should contain at least 8 characters');
      }

      //Validate phoneNumber

      if (phoneNumber != null) {
        if (phoneNumber.contains(RegExp(r'\D')))
          throw FormatException('Please input a valid phone number');
      }

      return Right(true);
    } on FormatException catch (e) {
      return Left(InvalidInputFailure(e.message));
    }
  }
}

class InvalidInputFailure extends Failure {
  InvalidInputFailure(String message) : super(message);
}
