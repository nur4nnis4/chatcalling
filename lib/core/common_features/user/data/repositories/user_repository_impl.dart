import 'package:chatcalling/core/common_features/user/data/datasources/user_remote_datasource.dart';
import 'package:chatcalling/core/common_features/user/domain/entities/user_private_data.dart';
import 'package:chatcalling/core/common_features/user/domain/entities/user.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:chatcalling/core/common_features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDatasource userRemoteDatasource;

  UserRepositoryImpl({required this.userRemoteDatasource});

  @override
  Stream<Either<Failure, User>> getUserData(String userId) async* {
    yield* userRemoteDatasource.getUserData(userId).asBroadcastStream();
  }

  @override
  Stream<Either<Failure, UserPrivateData>> getUserPrivateData(String userId) {
    // TODO: implement getUserPrivateData
    throw UnimplementedError();
  }
}
