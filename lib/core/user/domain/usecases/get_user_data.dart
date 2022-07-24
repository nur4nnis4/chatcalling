import 'package:chatcalling/core/error/failures.dart';
import 'package:chatcalling/core/user/domain/entities/user.dart';
import 'package:chatcalling/core/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserData {
  final UserRepository repository;

  GetUserData(this.repository);

  Future<Either<Failure, User>> call({required String userId}) async {
    return await repository.getUserData(userId);
  }
}
