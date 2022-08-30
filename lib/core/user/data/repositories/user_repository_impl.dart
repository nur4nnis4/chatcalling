import 'package:chatcalling/core/network/network_info.dart';
import 'package:chatcalling/core/user/data/datasources/user_local_datasource.dart';
import 'package:chatcalling/core/user/data/datasources/user_remote_datasource.dart';
import 'package:chatcalling/core/user/data/models/user_model.dart';
import 'package:chatcalling/core/user/domain/entities/user_private_data.dart';
import 'package:chatcalling/core/user/domain/entities/user.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:chatcalling/core/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDatasource userRemoteDatasource;
  final UserLocalDatasource userLocalDatasource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl(
      {required this.userRemoteDatasource,
      required this.userLocalDatasource,
      required this.networkInfo});

  @override
  Stream<Either<Failure, User>> getUserData(String userId) async* {
    if (await networkInfo.isConnected) {
      final userDataStream =
          userRemoteDatasource.getUserData(userId).asBroadcastStream();
      userDataStream.listen((event) {
        if (event.isRight())
          userLocalDatasource
              .cacheUserData(event.getOrElse(() => UserModel.fromJson({})));
      });
      yield* userDataStream;
    } else
      yield await userLocalDatasource.getUserData();
  }

  @override
  Stream<Either<Failure, UserPrivateData>> getUserPrivateData(
      String userId) async* {
    if (await networkInfo.isConnected) {
    } else
      yield Left(ConnectionFailure(''));
  }
}
