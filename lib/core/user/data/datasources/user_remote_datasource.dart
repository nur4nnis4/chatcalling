import 'package:chatcalling/core/error/exceptions.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:chatcalling/core/user/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class UserRemoteDatasource {
  Stream<Either<Failure, UserModel>> getUserData(String userId);
  Stream<Either<Failure, UserModel>> getUserPrivateData(String userId);
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final FirebaseFirestore instance;

  UserRemoteDatasourceImpl(this.instance);

  @override
  Stream<Either<Failure, UserModel>> getUserData(String userId) async* {
    try {
      yield* instance
          .collection('users')
          .doc(userId)
          .snapshots()
          .map((event) => Right(UserModel.fromJson(event.data())));
    } on PlatformException catch (e) {
      yield Left(PlatformFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, UserModel>> getUserPrivateData(String userId) {
    // TODO: implement getUserPrivateData
    throw UnimplementedError();
  }
}
