import '../../../../../error/failures.dart';
import '../../repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class CheckUsernameAvailability {
  final UserRepository repository;

  CheckUsernameAvailability(this.repository);

  Future<Either<Failure, bool>> call({required String username}) async {
    return repository.checkUsernameAvailability(username);
  }
}
