import 'package:chatcalling/core/error/failures.dart';
import 'package:chatcalling/core/user/domain/entities/user.dart';
import 'package:chatcalling/core/user/domain/entities/user_private_data.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUserData(String userId);
  Future<Either<Failure, UserPrivateData>> getUserPrivateData(String userId);
}
