import 'package:chatcalling/core/common_features/user/data/datasources/auth_remote_datasource.dart';
import 'package:chatcalling/core/common_features/user/data/datasources/user_remote_datasource.dart';
import 'package:chatcalling/core/common_features/user/data/models/personal_information_model.dart';
import 'package:chatcalling/core/common_features/user/data/models/user_model.dart';
import 'package:chatcalling/core/common_features/user/domain/entities/personal_information.dart';
import 'package:chatcalling/core/common_features/user/domain/entities/user.dart';
import 'package:chatcalling/core/common_features/user/domain/repositories/auth_repository.dart';
import 'package:chatcalling/core/error/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:chatcalling/core/error/failures.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final UserRemoteDatasource userRemoteDatasource;

  AuthRepositoryImpl({
    required this.authRemoteDatasource,
    required this.userRemoteDatasource,
  });

  @override
  Future<String> getCurrentUserId() {
    return authRemoteDatasource.getCurrentUserId();
  }

  @override
  Stream<bool> isSignedIn() async* {
    yield* authRemoteDatasource.isSignedIn();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmail(User user,
      PersonalInformation personalInformation, String password) async {
    try {
      await authRemoteDatasource.signUpWithEmail(
          personalInformation.email, password);
      final userId = await getCurrentUserId();
      await userRemoteDatasource
          .addUserData(UserModel.fromEntity(user, userId));
      await userRemoteDatasource.addPersonalInformation(
          PersonalInformationModel.fromEntity(personalInformation, userId));
      return Right('success');
    } on PlatformException catch (e) {
      return Left(PlatformFailure((e.message)));
    } catch (e) {
      return Left(PlatformFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> signInWithEmail(
      String email, String password) async {
    try {
      await authRemoteDatasource.signInWithEmail(email, password);
      return Right('success');
    } on PlatformException catch (e) {
      return Left(PlatformFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> signInWithGoogle() async {
    try {
      final userInfo = await authRemoteDatasource.signInWithGoogle();
      if (userInfo != null) {
        await userRemoteDatasource.addUserData(userInfo.user);
        await userRemoteDatasource
            .addPersonalInformation(userInfo.personalInformation);
      }
      return Right('success');
    } on PlatformException catch (e) {
      return Left(PlatformFailure((e.message)));
    } catch (e) {
      return Left(PlatformFailure(('')));
    }
  }

  @override
  Future<Either<Failure, String>> signOut() async {
    try {
      await authRemoteDatasource.signOut();
      return Right('success');
    } on PlatformException catch (e) {
      return Left(PlatformFailure((e.message)));
    }
  }
}
