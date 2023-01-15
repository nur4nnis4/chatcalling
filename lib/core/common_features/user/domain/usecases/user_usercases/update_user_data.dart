import 'package:chatcalling/core/common_features/user/domain/entities/user.dart';

import '../../../../../error/failures.dart';
import '../../repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateUserData {
  final UserRepository repository;

  UpdateUserData(this.repository);

  Future<Either<Failure, String>> call({required User user}) {
    return repository.updateUserData(user);
  }
}
