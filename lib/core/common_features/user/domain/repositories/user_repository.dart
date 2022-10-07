import 'package:chatcalling/core/error/failures.dart';
import 'package:chatcalling/core/common_features/user/domain/entities/user.dart';
import 'package:chatcalling/core/common_features/user/domain/entities/user_private_data.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Stream<Either<Failure, User>> getUserData(String userId);
  Stream<Either<Failure, UserPrivateData>> getUserPrivateData(String userId);
}
