import 'package:chatcalling/core/common_features/user/domain/entities/personal_information.dart';
import 'package:chatcalling/core/common_features/user/domain/entities/user.dart';
import 'package:chatcalling/core/common_features/user/domain/repositories/auth_repository.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class SignUpWithEmail {
  final AuthRepository repository;

  SignUpWithEmail(this.repository);

  Future<Either<Failure, String>> call(
      {required User user,
      required PersonalInformation personalInformation,
      required String password}) async {
    return repository.signUpWithEmail(user, personalInformation, password);
  }
}
