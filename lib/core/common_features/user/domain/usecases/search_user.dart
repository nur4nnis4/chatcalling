import 'package:chatcalling/core/common_features/user/domain/entities/user.dart';
import 'package:chatcalling/core/common_features/user/domain/repositories/user_repository.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class SearchUser {
  final UserRepository repository;

  SearchUser(this.repository);

  Stream<Either<Failure, List<User>>> call({required String query}) async* {
    yield* repository.searchUser(query);
  }
}
