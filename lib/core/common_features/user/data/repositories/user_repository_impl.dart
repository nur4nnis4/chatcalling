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
}
