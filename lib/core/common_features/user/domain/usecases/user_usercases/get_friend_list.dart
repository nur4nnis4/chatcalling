import 'package:chatcalling/core/common_features/user/domain/entities/user.dart';
import 'package:chatcalling/core/common_features/user/domain/repositories/user_repository.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class GetFriendList {
  final UserRepository repository;

  GetFriendList(this.repository);

  Stream<Either<Failure, List<User>>> call({required String userId}) async* {
    yield* repository.getFriendList(userId);
  }
}
