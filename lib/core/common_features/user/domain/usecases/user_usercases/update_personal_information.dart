import 'package:chatcalling/core/common_features/user/domain/entities/personal_information.dart';

import '../../../../../error/failures.dart';
import '../../repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UpdatePersonalInformation {
  final UserRepository repository;

  UpdatePersonalInformation(this.repository);

  Future<Either<Failure, String>> call(
      {required PersonalInformation personalInformation}) {
    return repository.updatePersonalInformation(personalInformation);
  }
}
