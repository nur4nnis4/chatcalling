import 'package:chatcalling/core/common_features/user/data/models/personal_information_model.dart';
import 'package:chatcalling/core/error/exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserRemoteDatasource {
  Stream<UserModel> getUserData(String userId);
  Stream<List<UserModel>> getFriendList(String userId);
  Stream<List<UserModel>> searchUser(String query);
  Stream<PersonalInformationModel> getPersonalInformation(String userId);
  Future<void> addUserData(UserModel userModel);
  Future<void> addPersonalInformation(
      PersonalInformationModel personalInformationModel);
  Future<void> updateUserData(UserModel userModel);
  Future<void> updatePersonalInformation(
      PersonalInformationModel personalInformationModel);
  Future<bool> isUsernameAvailable(String username);
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final FirebaseFirestore instance;

  UserRemoteDatasourceImpl(this.instance);

  late CollectionReference<Map<String, dynamic>> usersRef =
      instance.collection('users');

  @override
  Stream<UserModel> getUserData(String userId) async* {
    await _enablePersistence();
    yield* usersRef
        .doc(userId)
        .snapshots()
        .map((event) => UserModel.fromJson(event.data()));
  }

  @override
  Stream<List<UserModel>> getFriendList(String userId) async* {
    yield* getUserData(userId).flatMap((user) => CombineLatestStream.list(
        user.friendList.map((friendId) => getUserData(friendId))));
  }

  @override
  Stream<List<UserModel>> searchUser(String query) async* {
    yield* usersRef.snapshots().map((event) {
      if (event.docs.isNotEmpty) {
        return event.docs
            .map((e) => UserModel.fromJson(e.data()))
            .toList()
            .where((user) => query
                .toLowerCase()
                .split(' ')
                .map((queryWord) =>
                    user.username.toLowerCase().startsWith(queryWord) ||
                    user.displayName
                        .toLowerCase()
                        .split(' ')
                        .map((e) => e.startsWith(queryWord))
                        .toList()
                        .reduce((value, element) => value || element))
                .reduce((value, element) => value || element))
            .toList();
      } else
        return [];
    });
  }

  @override
  Stream<PersonalInformationModel> getPersonalInformation(
      String userId) async* {
    await _enablePersistence();
    yield* usersRef
        .doc(userId)
        .collection('personal_information')
        .doc(userId)
        .snapshots()
        .map((event) => PersonalInformationModel.fromJson(event.data()));
  }

  Future<void> _enablePersistence() async {
    if (kIsWeb) {
      try {
        await instance.enablePersistence(
            const PersistenceSettings(synchronizeTabs: true));
      } catch (e) {
        return;
      }
    }
  }

  @override
  Future<void> addUserData(UserModel userModel) async {
    await usersRef.doc(userModel.userId).set(userModel.toJson());
  }

  @override
  Future<void> updateUserData(UserModel userModel) async {
    await usersRef.doc(userModel.userId).update(userModel.toJson());
  }

  @override
  Future<void> addPersonalInformation(
      PersonalInformationModel personalInformationModel) async {
    await usersRef
        .doc(personalInformationModel.userId)
        .collection('personal_information')
        .doc(personalInformationModel.userId)
        .set(personalInformationModel.toJson());
  }

  @override
  Future<void> updatePersonalInformation(
      PersonalInformationModel personalInformationModel) async {
    await usersRef
        .doc(personalInformationModel.userId)
        .collection('personal_information')
        .doc(personalInformationModel.userId)
        .update(personalInformationModel.toJson());
  }

  @override
  Future<bool> isUsernameAvailable(String username) async {
    final isAvailable = await usersRef
        .where('username', isEqualTo: username)
        .get()
        .then((value) => value.docs.isEmpty);
    if (isAvailable)
      return isAvailable;
    else
      throw PlatformException(message: 'Username is already taken');
  }
}
