import '../../../../error/failures.dart';
import '../entities/user.dart';
import '../entities/personal_information.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Stream<Either<Failure, User>> getUserData(String userId);
  Stream<Either<Failure, List<User>>> getFriendList(String userId);
  Stream<Either<Failure, List<User>>> searchUser(String query);
  Stream<Either<Failure, PersonalInformation>> getPersonalInformation(
      String userId);
  Future<Either<Failure, String>> updateUserData(User user);
  Future<Either<Failure, String>> updatePersonalInformation(
      PersonalInformation personalInformation);
  Future<Either<Failure, bool>> checkUsernameAvailability(String username);
}
