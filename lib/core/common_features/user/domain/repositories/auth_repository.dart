import 'package:chatcalling/core/common_features/user/domain/entities/personal_information.dart';
import 'package:chatcalling/core/common_features/user/domain/entities/user.dart';

import '../../../../error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> signUpWithEmail(
      User user, PersonalInformation personalInformation, String password);
  Future<Either<Failure, String>> signInWithEmail(
    String email,
    String password,
  );
  Future<Either<Failure, String>> signInWithGoogle();
  Future<Either<Failure, String>> signOut();
  Future<String> getCurrentUserId();
  Stream<bool> isSignedIn();
}
