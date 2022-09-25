import 'package:chatcalling/core/user/data/datasources/user_remote_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/fixtures/user_dummy.dart';

void main() {
  late FakeFirebaseFirestore instance;
  late UserRemoteDatasourceImpl dataSource;

  setUp(() {
    instance = FakeFirebaseFirestore();
    dataSource = UserRemoteDatasourceImpl(instance);
  });

  String tUserId = 'user1Id';

  group('getUserData', () {
    setUp(() {
      instance.collection('users').doc(tUserId).set(tUserModel.toJson());
    });
    test('Should return stream containing user data', () async {
      // Act
      final actualUserDataStream = dataSource.getUserData(tUserId);
      // Assert
      expect(actualUserDataStream, emits(Right(tUserModel)));
    });
  });
}
