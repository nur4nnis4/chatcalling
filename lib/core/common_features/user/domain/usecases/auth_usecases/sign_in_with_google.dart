import 'package:chatcalling/core/common_features/user/domain/repositories/auth_repository.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class SignInWithGoogle {
  final AuthRepository repository;

  SignInWithGoogle(this.repository);

  Future<Either<Failure, String>> call() async {
    return repository.signInWithGoogle();
  }
}
