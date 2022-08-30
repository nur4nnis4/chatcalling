import 'package:chatcalling/core/error/failures.dart';
import 'package:chatcalling/core/user/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class UserLocalDatasource {
  Future<Either<Failure, UserModel>> getUserData();
  Future<Either<Failure, String>> cacheUserData(UserModel userToCache);
}

class UserLocalDatasourceImpl extends UserLocalDatasource {
  @override
  Future<Either<Failure, String>> cacheUserData(UserModel userToCache) {
    // TODO: implement cacheUserData
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> getUserData() {
    // TODO: implement getUserData
    throw UnimplementedError();
  }
}
