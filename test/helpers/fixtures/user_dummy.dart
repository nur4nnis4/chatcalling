import 'package:chatcalling/core/common_features/user/data/models/user_model.dart';
import 'package:chatcalling/core/common_features/user/domain/entities/user.dart';

final List<String> tFriendIdList = ['user2Id', 'user3Id'];

final tUser = User(
  userId: 'user1Id',
  username: 'username',
  displayName: 'displayName',
  signUpTime: DateTime.parse("2022-07-18T16:37:47.475845Z").toLocal(),
  isOnline: false,
  lastOnline: DateTime.parse("2022-08-18T16:37:47.475845Z").toLocal(),
  about: 'Busy',
  profilePhotoUrl: 'http//:user.jpg',
  coverPhotoUrl: 'http//:user.jpg',
  friendList: tFriendIdList,
);

final tUserModel = UserModel(
  userId: 'user1Id',
  username: 'username',
  displayName: 'displayName',
  signUpTime: DateTime.parse("2022-07-18 16:37:47.475845Z").toLocal(),
  isOnline: false,
  lastOnline: DateTime.parse("2022-07-18 16:37:47.475845Z").toLocal(),
  about: 'Busy',
  profilePhotoUrl: 'http//:user.jpg',
  coverPhotoUrl: 'http//:user.jpg',
  friendList: tFriendIdList,
);

final tUserModel2 = UserModel(
  userId: 'user2Id',
  username: 'username2',
  displayName: 'displayName2',
  signUpTime: DateTime.parse("2022-07-18 16:37:47.475845Z").toLocal(),
  isOnline: false,
  lastOnline: DateTime.parse("2022-07-18 16:37:47.475845Z").toLocal(),
  about: 'Busy',
  profilePhotoUrl: 'http//:user2.jpg',
  coverPhotoUrl: 'http//:user2.jpg',
  friendList: ['user1Id'],
);

final Map<String, dynamic> tUserJson = {
  "userId": "user1Id",
  "username": "username",
  "displayName": "displayName",
  "signUpTime": "2022-07-18T16:37:47.475845Z",
  "isOnline": false,
  "lastOnline": "2022-07-18T16:37:47.475845Z",
  "about": "Busy",
  "profilePhotoUrl": "http//:user.jpg",
  "coverPhotoUrl": 'http//:user.jpg',
  "friendList": tFriendIdList,
};

final tUserModelList = [
  tUserModel,
  UserModel(
    userId: tFriendIdList[0],
    username: 'username2',
    displayName: 'displayName2',
    signUpTime: DateTime.parse("2022-07-18 16:37:47.475845Z").toLocal(),
    isOnline: false,
    lastOnline: DateTime.parse("2022-07-18 16:37:47.475845Z").toLocal(),
    about: 'Busy',
    profilePhotoUrl: 'http//:user2.jpg',
    coverPhotoUrl: 'http//:user2.jpg',
    friendList: ['user1Id'],
  ),
  UserModel(
    userId: tFriendIdList[1],
    username: 'username3',
    displayName: 'displayName3',
    signUpTime: DateTime.parse("2022-07-18 23:37:47.475845Z").toLocal(),
    isOnline: false,
    lastOnline: DateTime.parse("2022-07-18 23:37:47.475845Z").toLocal(),
    about: 'Available',
    profilePhotoUrl: 'http//:user3.jpg',
    coverPhotoUrl: 'http//:user3.jpg',
    friendList: ['user1Id', 'user4Id'],
  ),
  UserModel(
    userId: 'user4Id',
    username: 'flutterdev',
    displayName: 'Nur Annisa Herman',
    signUpTime: DateTime.parse("2022-07-18 23:37:47.475845Z").toLocal(),
    isOnline: false,
    lastOnline: DateTime.parse("2022-07-18 23:37:47.475845Z").toLocal(),
    about: 'Available',
    profilePhotoUrl: 'http//:user4.jpg',
    coverPhotoUrl: 'http//:user4.jpg',
    friendList: ['user3Id'],
  ),
];
final tExpectedFriendList = [
  UserModel(
    userId: tFriendIdList[0],
    username: 'username2',
    displayName: 'displayName2',
    signUpTime: DateTime.parse("2022-07-18 16:37:47.475845Z").toLocal(),
    isOnline: false,
    lastOnline: DateTime.parse("2022-07-18 16:37:47.475845Z").toLocal(),
    about: 'Busy',
    profilePhotoUrl: 'http//:user2.jpg',
    coverPhotoUrl: 'http//:user2.jpg',
    friendList: ['user1Id'],
  ),
  UserModel(
    userId: tFriendIdList[1],
    username: 'username3',
    displayName: 'displayName3',
    signUpTime: DateTime.parse("2022-07-18 23:37:47.475845Z").toLocal(),
    isOnline: false,
    lastOnline: DateTime.parse("2022-07-18 23:37:47.475845Z").toLocal(),
    about: 'Available',
    profilePhotoUrl: 'http//:user3.jpg',
    coverPhotoUrl: 'http//:user3.jpg',
    friendList: ['user1Id', 'user4Id'],
  ),
];
