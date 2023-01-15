import 'package:chatcalling/core/common_features/user/data/datasources/user_remote_datasource.dart';
import 'package:chatcalling/core/common_features/user/data/models/user_model.dart';
import 'package:chatcalling/core/error/exceptions.dart';
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

    instance
        .collection('users')
        .doc(tPersonalInformationModel.userId)
        .collection('personal_information')
        .doc(tPersonalInformationModel.userId)
        .set(tPersonalInformationJson);
  });

  group('getUserData', () {
    test('Should emit stream containing user data', () async {
      // Act
      final actualUserDataStream = dataSource.getUserData(tUserId);
      // Assert
      expect(actualUserDataStream, emits(tUserModel));
    });
  });

  group('searchUser', () {
    test('Should emit stream containing list of all matching user data ',
        () async {
      //Arrange
      final List<UserModel> expectedList = [tUserModelList[3]];
      // Act
      final actualUserDataStream1 =
          await dataSource.searchUser('nur annisa').first;

      final actualUserDataStream2 = await dataSource.searchUser('Annisa').first;

      final actualUserDataStream3 =
          await dataSource.searchUser('Annisa herman').first;

      final actualUserDataStream4 =
          await dataSource.searchUser('flutter').first;
      // Assert
      expect(actualUserDataStream1, expectedList);
      expect(actualUserDataStream2, expectedList);
      expect(actualUserDataStream3, expectedList);
      expect(actualUserDataStream4, expectedList);
    });

    test('Should emit stream containg empty list when no match is found',
        () async {
      // Act
      final actualUserDataStream = dataSource.searchUser('utter');
      // Assert
      expect(actualUserDataStream, emits([]));
    });
  });

  group('getFriendList', () {
    test('Should emit stream containing user friend list data', () async {
      // Act
      final actualUserDataStream = dataSource.getFriendList(tUserId);
      // Assert
      expect(actualUserDataStream, emits(tExpectedFriendList));
    });
  });

  group('addUserData', () {
    test('Should add new user data to remote database', () async {
      // Act
      await dataSource.addUserData(tNewUserModel);
      // Assert
      final newUserDataStream = dataSource.getUserData(tNewUserModel.userId);
      expect(newUserDataStream, emits(tNewUserModel));
    });
  });

  group('updateUserData', () {
    test('Should update user data on remote database', () async {
      // Act
      await dataSource.updateUserData(tUpdateUserModel);
      // Assert
      final newUserDataStream = dataSource.getUserData(tUpdateUserModel.userId);
      expect(newUserDataStream, emits(tUpdateUserModel));
    });
  });

  group('getPersonalInformation', () {
    test('Should emit stream containing user personal information', () async {
      // Act
      final actualUserDataStream = dataSource.getPersonalInformation(tUserId);
      // Assert
      expect(actualUserDataStream, emits(tPersonalInformationModel));
    });
  });

  group('addPersonalInformation', () {
    test('Should add new user personal information to remote database',
        () async {
      // Act
      await dataSource.addPersonalInformation(tNewPersonalInformationModel);
      // Assert
      final newUserDataStream = dataSource
          .getPersonalInformation(tNewPersonalInformationModel.userId);
      expect(newUserDataStream, emits(tNewPersonalInformationModel));
    });
  });

  group('updatePersonalInformation', () {
    test('Should update user personal information on remote database',
        () async {
      // Act
      await dataSource
          .updatePersonalInformation(tUpdatePersonalInformationModel);
      // Assert
      final newUserDataStream = dataSource
          .getPersonalInformation(tUpdatePersonalInformationModel.userId);
      expect(newUserDataStream, emits(tUpdatePersonalInformationModel));
    });
  });

  group('isUsernameAvailable', () {
    test(
        'should return true if no user with the same username is found in the database',
        () async {
      // Act
      final actual = await dataSource.isUsernameAvailable('availableUsername');
      // Assert
      expect(actual, true);
    });

    test(
        'should throw platformfailure if a user with the same username is found in the database',
        () async {
      // Act
      final actual = dataSource.isUsernameAvailable(tUserModelList[0].username);
      // Assert
      expectLater(() => actual, throwsA(isA<PlatformException>()));
    });
  });
}
