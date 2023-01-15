import 'package:chatcalling/core/common_features/user/domain/repositories/auth_repository.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class SignInWithEmail {
  final AuthRepository repository;

  SignInWithEmail(this.repository);

  Future<Either<Failure, String>> call(
      {required String email, required String password}) async {
    return repository.signInWithEmail(email, password);
  }
}
