import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/user_private_data.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';

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
