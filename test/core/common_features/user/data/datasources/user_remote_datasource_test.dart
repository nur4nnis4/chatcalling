import 'package:chatcalling/core/common_features/user/data/datasources/user_remote_datasource.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/fixtures/personal_information_dummy.dart';
import '../../../../../helpers/fixtures/user_dummy.dart';

void main() {
  late FakeFirebaseFirestore instance;
  late UserRemoteDatasourceImpl dataSource;
  String tUserId = 'user1Id';

  setUp(() {
    instance = FakeFirebaseFirestore();
    dataSource = UserRemoteDatasourceImpl(instance);

    tUserModelList.forEach((userModel) {
      instance
          .collection('users')
          .doc(userModel.userId)
          .set(userModel.toJson());
    });
  });

  group('getUserData', () {
    setUp(() {});
    test('Should return stream containing user data', () async {
      // Act
      final actualUserDataStream = dataSource.getUserData(tUserId);
      // Assert
      expect(actualUserDataStream, emits(tUserModel));
    });
  });

  group('getFriendList', () {
    test('Should return stream containing user friend list data', () async {
      // Act
      final actualUserDataStream = dataSource.getFriendList(tUserId);
      // Assert
      expect(actualUserDataStream, emits(tUserModelList.skip(1)));
    });
  });

  group('getPersonalInformation', () {
    setUp(() {
      instance
          .collection('users')
          .doc(tPersonalInformationModel.userId)
          .collection('personal_information')
          .doc(tPersonalInformationModel.userId)
          .set(tPersonalInformationJson);
    });
    test('Should return stream containing user personal information', () async {
      // Act
      final actualUserDataStream = dataSource.getPersonalInformation(tUserId);
      // Assert
      expect(actualUserDataStream, emits(tPersonalInformationModel));
    });
  });
}
