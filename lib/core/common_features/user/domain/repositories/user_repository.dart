import '../../../../error/failures.dart';
import '../entities/user.dart';
import '../entities/user_private_data.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Stream<Either<Failure, User>> getUserData(String userId);
  Stream<Either<Failure, UserPrivateData>> getUserPrivateData(String userId);
}
