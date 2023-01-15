import 'package:chatcalling/core/common_features/user/data/models/personal_information_model.dart';
import 'package:chatcalling/core/common_features/user/data/models/user_model.dart';
import 'package:chatcalling/core/error/exceptions.dart';
import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/personal_information.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDatasource userRemoteDatasource;

  UserRepositoryImpl({required this.userRemoteDatasource});

  @override
  Stream<Either<Failure, User>> getUserData(String userId) async* {
    try {
      yield* userRemoteDatasource
          .getUserData(userId)
          .map((event) => Right(event));
    } catch (e) {
      yield Left(PlatformFailure(''));
    }
  }

  @override
  Stream<Either<Failure, List<User>>> getFriendList(String userId) async* {
    try {
      yield* userRemoteDatasource
          .getFriendList(userId)
          .map((event) => Right(event));
    } catch (e) {
      yield Left(PlatformFailure(''));
    }
  }

  @override
  Stream<Either<Failure, PersonalInformation>> getPersonalInformation(
      String userId) async* {
    try {
      yield* userRemoteDatasource
          .getPersonalInformation(userId)
          .map((event) => Right(event));
    } catch (e) {
      yield Left(PlatformFailure(''));
    }
  }

  @override
  Stream<Either<Failure, List<User>>> searchUser(String query) async* {
    try {
      yield* userRemoteDatasource
          .searchUser(query)
          .map((event) => Right(event));
    } catch (e) {
      yield Left(PlatformFailure(''));
    }
  }

  @override
  Future<Either<Failure, bool>> checkUsernameAvailability(
      String username) async {
    try {
      final result = await userRemoteDatasource.isUsernameAvailable(username);

      return Right(result);
    } on PlatformException catch (e) {
      return Left(PlatformFailure(e.message));
    } catch (e) {
      return Left(PlatformFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updatePersonalInformation(
      PersonalInformation personalInformation) async {
    try {
      await userRemoteDatasource.updatePersonalInformation(
          PersonalInformationModel.fromEntity(
              personalInformation, personalInformation.userId));
      return Right('Success');
    } catch (e) {
      return Left(PlatformFailure(''));
    }
  }

  @override
  Future<Either<Failure, String>> updateUserData(User user) async {
    try {
      await userRemoteDatasource
          .updateUserData(UserModel.fromEntity(user, user.userId));
      return Right('Success');
    } catch (e) {
      return Left(PlatformFailure(''));
    }
  }
}
