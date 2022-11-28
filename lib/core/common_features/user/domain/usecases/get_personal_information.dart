import 'package:chatcalling/core/common_features/user/domain/entities/personal_information.dart';

import '../../../../error/failures.dart';
import '../repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetPersonalInformation {
  final UserRepository repository;

  GetPersonalInformation(this.repository);

  Stream<Either<Failure, PersonalInformation>> call(
      {required String userId}) async* {
    yield* repository.getPersonalInformation(userId);
  }
}
