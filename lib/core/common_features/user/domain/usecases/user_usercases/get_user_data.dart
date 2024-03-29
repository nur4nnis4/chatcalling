import '../../../../../error/failures.dart';
import '../../entities/user.dart';
import '../../repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserData {
  final UserRepository repository;

  GetUserData(this.repository);

  Stream<Either<Failure, User>> call({required String userId}) async* {
    yield* repository.getUserData(userId);
  }
}
