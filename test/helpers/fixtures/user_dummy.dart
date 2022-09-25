import 'package:chatcalling/core/user/data/models/user_model.dart';
import 'package:chatcalling/core/user/domain/entities/user.dart';

final tUser = User(
    userId: 'user1Id',
    username: 'username',
    displayName: 'displayName',
    signUpTime: DateTime.parse("2022-07-18T16:37:47.475845Z"),
    isOnline: false,
    lastOnline: DateTime.parse("2022-08-18T16:37:47.475845Z"),
    about: 'Busy',
    photoUrl: 'http//:user.jpg');

final tUserModel = UserModel(
    userId: 'user1Id',
    username: 'username',
    displayName: 'displayName',
    signUpTime: DateTime.parse("2022-07-18T16:37:47.475845Z"),
    isOnline: false,
    lastOnline: DateTime.parse("2022-08-18T16:37:47.475845Z"),
    about: 'Busy',
    photoUrl: 'http//:user.jpg');
final tUserModelNotUTC = UserModel(
    userId: 'user1Id',
    username: 'username',
    displayName: 'displayName',
    signUpTime: DateTime.parse("2022-07-18 23:37:47.475845"),
    isOnline: false,
    lastOnline: DateTime.parse("2022-08-18 23:37:47.475845"),
    about: 'Busy',
    photoUrl: 'http//:user.jpg');

final Map<String, dynamic> tUserJson = {
  "userId": "user1Id",
  "username": "username",
  "displayName": "displayName",
  "signUpTime": "2022-07-18T16:37:47.475845Z",
  "isOnline": false,
  "lastOnline": "2022-08-18T16:37:47.475845Z",
  "about": "Busy",
  "photoUrl": "http//:user.jpg"
};
